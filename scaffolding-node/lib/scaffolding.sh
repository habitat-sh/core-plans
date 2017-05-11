scaffolding_load() {
  scaffolding_node_package_json_location=
  # `$scaffolding_node_pkg` is empty by default
  : "${scaffolding_node_pkg:=}"

  pkg_build_deps=(${pkg_deps[@]} core/git core/grep)
  build_line "Setting pkg_build_deps=(${pkg_build_deps[*]})"

  # Add bash (used for the shebang in the run hook and coreutils (used to
  # replace /usr/bin/env in scripts) to the pkg_deps. node will be added in the
  # `_detect_node` function.
  pkg_deps=(${pkg_deps[@]} core/bash core/coreutils)
  build_line "Setting pkg_deps=(${pkg_deps[*]})"

  # NPM will always put binaries and the lib directory in the same place
  pkg_lib_dirs=(lib)
  build_line "Setting pkg_lib_dirs=(${pkg_lib_dirs[*]})"
  pkg_bin_dirs=(${pkg_bin_dirs[@]} bin lib/node_modules/.bin)
  build_line "Setting pkg_bin_dirs=(${pkg_bin_dirs[*]})"

  _detect_node
}

do_default_prepare() {
  scaffolding_node_prepare
}

do_default_build() {
  return 0
}

do_default_install() {
  scaffolding_node_install
}

# Strip doesn't do anything for us, but it does take longer when there are lots
# of files, which, when we're using node, is always.
do_default_strip() {
  return 0
}




scaffolding_node_prepare() {
  if [[ -n "$HAB_NONINTERACTIVE" ]]; then
    export npm_config_progress=false
    build_line "Setting npm_config_progress=$npm_config_progress"
  fi

  export npm_config_prefix="$pkg_prefix"
  build_line "Setting npm_config_prefix=$npm_config_prefix"
  export npm_config_global=true
  build_line "Setting npm_config_global=$npm_config_global"

  _get_package_json
  _set_variables_from_package_json
  _detect_run_hook
}

scaffolding_node_install() {
  if [[ -n "$pkg_source" ]]; then
    npm install "$pkg_source"
  else
    npm install "$SRC_PATH"
  fi

  # Since we're setting global (-g), instead of using `npm shrinkwrap`, we can
  # list the global packages in the same format to an npm-list.json in the
  # package so you can get a list of the transitive dependencies for reference.
  npm list --json > "$pkg_prefix/npm-list.json"
  build_line "Writing list of transitive Node package dependencies to $pkg_prefix/npm-list.json"

  # Find everything in the package that starts with `#!/usr/bin/env node` and
  # fix its interpreter.
  grep -l -R ^\#\!/usr/bin/env "$pkg_prefix" | while IFS= read -r f; do
    fix_interpreter "$(readlink -f "$f")" core/coreutils bin/env
  done
}




# Set the node version based on the scaffolding_pkg_node or the contents of
# .nvmrc.
_detect_node () {
  local node_pkg nvmrc_file nvmrc_version
  node_pkg="$scaffolding_node_pkg"
  nvmrc_file="$SRC_PATH/.nvmrc"
  nvmrc_version=

  if [[ -n "$node_pkg" ]]; then
    build_line "Detected Node.js version in Plan, using $node_pkg"
  elif [[ -e "$nvmrc_file" ]]; then
    nvmrc_version="$(cat "$nvmrc_file")"
    if [[ -n "$nvmrc_version" ]]; then
      node_pkg="core/node/$nvmrc_version"
      build_line "Detected Node.js version in $nvmrc_file, using $node_pkg"
    else
      build_line "$nvmrc_file detected but it did not contain a Node.js version. Not setting Node.js version from this file"
      node_pkg=core/node
    fi
  else
    node_pkg=core/node
  fi
  pkg_deps=($node_pkg ${pkg_deps[@]})
  build_line "Setting pkg_deps=(${pkg_deps[*]})"
}

# Attempts to download or locate a package.json. If we think we're pulling from
# NPM, try `npm view`, if not, try to download the package with `npm pack`
_get_package_json() {
  build_line "Checking for local package.json"
  if [[ -e "$SRC_PATH/package.json" ]]; then
    scaffolding_node_package_json_location="$SRC_PATH/package.json"
    build_line "package.json found in $SRC_PATH/package.json"
    # Use node to try and parse the package.json. If it doesn't exit 0, assume
    # we have a bad package.json.
    if ! node "$SRC_PATH/package.json" 2> /dev/null; then
      exit_with "$SRC_PATH/package.json is not valid JSON"
    fi
  elif [[ -n "$pkg_source" ]]; then
    build_line "Attempting to get package.json with 'npm view $pkg_source'"
    if npm view --json "$pkg_source" > "$CACHE_PATH/package.json" 2> /dev/null; then
      scaffolding_node_package_json_location="$CACHE_PATH/package.json"
      build_line "package.json found in $CACHE_PATH/package.json"
      return 0
    else
      build_line "Attempt to get package.json with npm view failed"
    fi
    build_line "Attempting to get package.json with 'npm pack $pkg_source'"
    if npm pack "$pkg_source" > /dev/null 2&>1; then
      tar --strip-components=1 -xf "$pkg_name-$pkg_version.tgz"
      if [[ -e "$CACHE_PATH/package.json" ]]; then
        scaffolding_node_package_json_location="$CACHE_PATH/package.json"
        build_line "package.json found in $CACHE_PATH/package.json"
        return 0
      else
        build_line "package.json not found in downloaded source"
      fi
    else
      build_line "Attempt to get package.json with npm pack failed"
    fi
  else
    exit_with "No package.json found locally or remotely. Could not determine that this is a Node package." 1
  fi
}

# Use the package.json to populate some of the plan variables
_set_variables_from_package_json() {
  if [[ -n "$scaffolding_node_package_json_location" ]]; then
    if [[ -z "$pkg_description" ]]; then
      build_line "pkg_description not found in plan; attempting to set from package.json"
      local val
      val=$(_package_json_value pkg_description)
      if [[ -n "$val" ]]; then
        pkg_description=$val
        build_line "Setting pkg_description=$pkg_description"
      else
        build_line "pkg_description not found in package.json"
      fi
    fi

    if [[ -z "$pkg_license" ]]; then
      build_line "pkg_license not found in plan; attempting to set from package.json"
      local val
      val=$(_package_json_value pkg_license)
      if [[ -n "$val" ]]; then
        pkg_license=($val)
        build_line "Setting pkg_license=(${pkg_license[*]})"
      else
        build_line "pkg_license not found in package.json"
      fi
    fi

    if [[ -z "$pkg_maintainer" ]]; then
      build_line "pkg_maintainer not found in plan; attempting to set from package.json"
      local val
      val=$(_package_json_value pkg_maintainer)
      if [[ -n "$val" ]]; then
        pkg_maintainer=$val
        build_line "Setting pkg_maintainer=$pkg_maintainer"
      else
        build_line "pkg_maintainer not found in package.json"
      fi
    fi

    if [[ -z "$pkg_upstream_url" ]]; then
      build_line "pkg_upstream_url not found in plan; attempting to set from package.json"
      local val
      val=$(_package_json_value pkg_upstream_url)
      if [[ -n "$val" ]]; then
        pkg_upstream_url=$val
        build_line "Setting pkg_upstream_url=$pkg_upstream_url"
      else
        build_line "pkg_upstream_url not found in package.json"
      fi
    fi
  fi
}

# Decide whether or not we need to generate a run hook
_detect_run_hook() {
  local start_script_from_package_json run_hook_command
  start_script_from_package_json=$(_package_json_value pkg_svc_run)

  build_line "Generating run hook"
  if [[ -n "$pkg_svc_run" ]]; then
    build_line "pkg_svc_run=$pkg_svc_run already set; not generating run hook"
    return 0
  elif [[ -e "$PLAN_CONTEXT/hooks/run" ]]; then
    build_line "Existing run hook found in $PLAN_CONTEXT/hooks/run; not generating run hook"
    return 0
  elif [[ -n "$start_script_from_package_json" ]]; then
    build_line "scripts.start set to '$start_script_from_package_json' in package.json; generating run hook using this"
    run_hook_command=$start_script_from_package_json
  elif [[ -e "$SRC_PATH/server.js" ]]; then
    build_line "server.js found in package; generating run hook using this"
    run_hook_command="node server.js"
  else
    build_line "This package does not look like it runs a service; not generating run hook"
    return 0
  fi

  _generate_run_hook "$run_hook_command"
}




# Generate a run hook, given a command
_generate_run_hook() {
  local command pkg_name_from_package_json
  command="$1"
  # The thing that gets put in lib/node_modules/$name uses the $name from the
  # package.json, which may be different from the pkg_name
  pkg_name_from_package_json="$(_package_json_value pkg_name)"

  mkdir -pv "$pkg_prefix/hooks"
  cat <<-EOF > "$pkg_prefix/hooks/run"
#!$(pkg_path_for bash)/bin/bash
exec 2>&1
export HOME="$pkg_svc_data_path"
export NODE_ENV=\${NODE_ENV:-production}
export NODE_CONFIG_DIR="$pkg_svc_config_path"

if [[ -e "$pkg_svc_config_path/env" ]]; then
  source "$pkg_svc_config_path/env"
fi

cd "$pkg_prefix/lib/node_modules/$pkg_name_from_package_json"
exec $command 2>&1
EOF
  chmod 755 "$pkg_prefix/hooks/run"
}

# The directory this script is running from
_get_script_dir () {
  SOURCE="${BASH_SOURCE[0]}"
  while [ -h "$SOURCE" ]; do
    DIR="$(cd -P "$( dirname "$SOURCE" )" && pwd)"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
  done
  (cd -P "$(dirname "$SOURCE")" && pwd)
}

# Use the included packageJsonParser.js to get a value from the package.json
_package_json_value() {
  node "$(_get_script_dir)/packageJsonParser.js" "$scaffolding_node_package_json_location" "$1"
}
