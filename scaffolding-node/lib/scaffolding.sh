# shellcheck shell=bash

scaffolding_load() {
  _setup_funcs
  _setup_vars

  pushd "$SRC_PATH" > /dev/null
  _detect_package_json
  _detect_pkg_manager
  _detect_process_bins
  _update_vars
  _update_pkg_build_deps
  _update_pkg_deps
  _update_bin_dirs
  _update_svc_run
  popd > /dev/null
}

do_default_prepare() {
  export NODE_ENV=production
  build_line "Setting NODE_ENV=$NODE_ENV"
}

do_default_build() {
  # TODO fin: add cache loading of `$CACHE_PATH/node_modules`
  # TODO fin: support prebuild step?

  scaffolding_modules_install

  # TODO fin: support postbuild step?
  # TODO fin: add cache saving of `$CACHE_PATH/node_modules`

  scaffolding_fix_node_shebangs
  scaffolding_setup_app_config
}

do_default_install() {
  scaffolding_install_app
  scaffolding_install_node_modules
  scaffolding_create_process_bins
}

# Strip doesn't do anything for us, but it does take longer when there are lots
# of files, which, when we're using node, is always.
do_default_strip() {
  # TODO fin: better, faster strip strategy possible here
  return 0
}

# This becomes the `do_default_build_config` implementation thanks to some
# function "renaming" above. I know, right?
_new_do_default_build_config() {
  local key dir env_sh

  _stock_do_default_build_config

  if [[ ! -f "$PLAN_CONTEXT/hooks/init" ]]; then
    build_line "No user-defined init hook found, generating init hook"
    mkdir -p "$pkg_prefix/hooks"
    cat <<EOT >> "$pkg_prefix/hooks/init"
#!/bin/sh
set -e

export HOME="$pkg_svc_data_path"
. '$pkg_svc_config_path/app_env.sh'

EOT
    chmod 755 "$pkg_prefix/hooks/init"
  fi

  if [[ -f "$CACHE_PATH/default.scaffolding.toml" ]]; then
    build_line "Appending Scaffolding defaults to $pkg_prefix/default.toml"
    cat "$CACHE_PATH/default.scaffolding.toml" >> "$pkg_prefix/default.toml"
  fi

  env_sh="$pkg_prefix/config/app_env.sh"
  mkdir -p "$(dirname "$env_sh")"
  for key in "${!scaffolding_env[@]}"; do
    echo "export $key='${scaffolding_env[$key]}'" >> "$env_sh"
  done
}




scaffolding_modules_install() {
  if [[ -n "${_uses_git:-}" ]]; then
    if ! git check-ignore node_modules && [[ -d node_modules ]]; then
      warn "Detected directory 'node_modules' is not in .gitignore and is"
      warn "not empty. The contents of 'node_modules' will not be used when"
      warn "building this app."
      warn "It is not recommended to commit your node modules into your"
      warn "codebase."
    fi
  fi

  build_line "Installing dependencies using $_pkg_manager $("$_pkg_manager" --version)"
  start_sec="$SECONDS"
  case "$_pkg_manager" in
    npm)
      if [[ ! -f "$CACHE_PATH/package.json" ]]; then
        cp -av package.json "$CACHE_PATH/"
      fi
      if [[ -f "npm-shrinkwrap.json" ]]; then
        cp -av npm-shrinkwrap.json "$CACHE_PATH/"
      fi
      if [[ -n "$HAB_NONINTERACTIVE" ]]; then
        export NPM_CONFIG_PROGRESS=false
      fi
      pushd "$CACHE_PATH" > /dev/null
      npm install \
        --unsafe-perm \
        --production \
        --loglevel error \
        --fetch-retries 5 \
        --userconfig "$CACHE_PATH/.npmrc"
      npm list --json > npm-list.json
      popd > /dev/null
      ;;
    yarn)
      local extra_args
      if [[ -n "$HAB_NONINTERACTIVE" ]]; then
        extra_args="--no-progress"
      fi
      yarn install $extra_args \
        --pure-lockfile \
        --ignore-engines \
        --production \
        --modules-folder "$CACHE_PATH/node_modules" \
        --cache-folder "$CACHE_PATH/yarn_cache"
      ;;
    *)
      local e
      e="Internal error: package manager variable"
      e="$e not correctly set: '$_pkg_manager'"
      exit_with "$e" 9
      ;;
  esac
  elapsed=$((SECONDS - start_sec))
  elapsed=$(echo $elapsed | awk '{printf "%dm%ds", $1/60, $1%60}')
  build_line "Dependency installation completed ($elapsed)"
  return 0
}

scaffolding_fix_node_shebangs() {
  local shebang bin_path
  shebang="#!$(pkg_path_for "$_node_pkg")/bin/node"
  bin_path="$CACHE_PATH/node_modules/.bin"

  build_line "Fixing Node shebang for node_module bins"
  if [[ -d "$bin_path" ]]; then
    find "$bin_path" -type f -o -type l | while read -r bin; do
      sed -e "s|^#!.\{0,\}\$|${shebang}|" -i "$(readlink -f "$bin")"
    done
  fi
}

scaffolding_setup_app_config() {
  local t
  t="$CACHE_PATH/default.scaffolding.toml"

  echo "" >> "$t"

  if _default_toml_has_no node_env \
      && [[ -v "scaffolding_env[NODE_ENV]" ]]; then
    echo 'node_env = "production"' >> "$t"
  fi

  if _default_toml_has_no app; then
    echo "" >> "$t"
    echo '[app]' >> "$t"
    if _default_toml_has_no app.port; then
      echo "port = $scaffolding_app_port" >> "$t"
    fi
  fi
}

scaffolding_install_app() {
  build_line "Installing app codebase to $scaffolding_app_prefix"
  mkdir -pv "$scaffolding_app_prefix"
  if [[ -n "${_uses_git:-}" ]]; then
    # Use git commands to skip any git-ignored files and directories including
    # the `.git/ directory. Current on-disk state of all files is used meaning
    # that dirty and unstaged files are included which should help while
    # working on package builds.
    { git ls-files; git ls-files --exclude-standard --others; } \
      | _tar_pipe_app_cp_to "$scaffolding_app_prefix"
  else
    # Use find to enumerate all files and directories for copying. This is the
    # safe-fallback strategy if no version control software is detected.
    find . | _tar_pipe_app_cp_to "$scaffolding_app_prefix"
  fi
}

scaffolding_install_node_modules() {
  build_line "Installing vendored Node modules to $scaffolding_app_prefix/node_modules"
  rm -rf "$scaffolding_app_prefix/node_modules"
  cp -a "$CACHE_PATH/node_modules" "$scaffolding_app_prefix/"

  if [[ -f "$CACHE_PATH/npm-list.json" \
      && ! -f "$scaffolding_app_prefix/npm-list.json" ]]; then
    cp -av "$CACHE_PATH/npm-list.json" "$scaffolding_app_prefix/"
  fi
}

scaffolding_create_process_bins() {
  local bin cmd

  for bin in "${!scaffolding_process_bins[@]}"; do
    cmd="${scaffolding_process_bins[$bin]}"
    _create_process_bin "$pkg_prefix/bin/${pkg_name}-${bin}" "$cmd"
  done
}




_setup_funcs() {
  # Use the stock `do_default_build_config` by renaming it so we can call the
  # stock behavior. How does this rate on the evil scale?
  _rename_function "do_default_build_config" "_stock_do_default_build_config"
  _rename_function "_new_do_default_build_config" "do_default_build_config"
}

_setup_vars() {
  # The default Node package if one cannot be detected
  _default_node_pkg="core/node"
  # `$scaffolding_pkg_manager` is empty by default
  : "${scaffolding_pkg_manager:=}"
  # `$scaffolding_node_pkg` is empty by default
  : "${scaffolding_node_pkg:=}"
  # The install prefix path for the app
  scaffolding_app_prefix="$pkg_prefix/app"
  #
  : "${scaffolding_app_port:=8000}"
  # If `${scaffolding_env[@]` is not yet set, setup the hash
  if [[ ! "$(declare -p scaffolding_env 2> /dev/null || true)" =~ "declare -A" ]]; then
    declare -g -A scaffolding_env
  fi
  # If `${scaffolding_process_bins[@]` is not yet set, setup the hash
  if [[ ! "$(declare -p scaffolding_process_bins 2> /dev/null || true)" =~ "declare -A" ]]; then
    declare -g -A scaffolding_process_bins
  fi

  _jq="$(pkg_path_for jq-static)/bin/jq"
}

_detect_package_json() {
  if [[ ! -f package.json ]]; then
    exit_with \
      "Node Scaffolding cannot find package.json in the root directory." 5
  fi
  # shellcheck disable=SC2002
  if ! cat package.json | "$_jq" . > /dev/null; then
    exit_with "Failed to parse package.json as JSON." 6
  fi

  # TODO fin: do we check for any lockfiles here?
}

_detect_pkg_manager() {
  if [[ -n "$scaffolding_pkg_manager" ]]; then
    case "$scaffolding_pkg_manager" in
      npm)
        _pkg_manager=npm
        build_line "Detected package manager in Plan, using '$_pkg_manager'"
        ;;
      yarn)
        _pkg_manager=yarn
        build_line "Detected package manager in Plan, using '$_pkg_manager'"
        ;;
      *)
        local e
        e="Variable 'scaffolding_pkg_manager' can only be"
        e="$e set to: 'npm', 'yarn', or empty."
        exit_with "$e" 9
        ;;
    esac
  elif [[ -f yarn.lock ]]; then
    _pkg_manager=yarn
    build_line "Detected yarn.lock in root directory, using '$_pkg_manager'"
  else
    _pkg_manager=npm
    build_line "No package manager could be detected, using default '$_pkg_manager'"
  fi
}

_detect_process_bins() {
  local json_start

  if [[ -f Procfile ]]; then
    local line bin cmd

    build_line "Procfile detected, reading processes"
    # Procfile parsing was heavily inspired by the implementation in
    # gliderlabs/herokuish. Thanks to:
    # https://github.com/gliderlabs/herokuish/blob/master/include/procfile.bash
    while read -r line; do
      if [[ "$line" =~ ^#.* ]]; then
        continue
      else
        bin="${line%%:*}"
        cmd="${line#*:}"
        _set_if_unset scaffolding_process_bins "$(trim "$bin")" "$(trim "$cmd")"
      fi
    done < Procfile
  fi

  json_start="$(_json_val package.json .scripts.start)"
  if [[ -n "$json_start" ]]; then
    _set_if_unset scaffolding_process_bins web "$(trim "$json_start")"
    build_line "Detected scripts.start entry in package.json, using it for web process bin"
  fi

  if [[ ! -v "scaffolding_process_bins[web]" && -z "$pkg_svc_run" ]]; then
    local e
    e="A default proccess bin called 'web' could not be detected from"
    e="$e a Procfile or package.json."
    exit_with "$e" 11
  fi

  _set_if_unset scaffolding_process_bins "sh" 'sh'
}

_update_vars() {
  local val

  _set_if_unset scaffolding_env PORT "{{cfg.app.port}}"
  # Export the app's listen port
  _set_if_unset pkg_exports port "app.port"

  _set_if_unset scaffolding_env NODE_ENV "{{cfg.node_env}}"

  # TODO fin: try to detect `$pkg_version` in package.json. This may involve a
  # change to `hab-plan-build.sh` to delay the checking of required Plan
  # variables.

  if [[ -z "${pkg_description:-}" ]]; then
    val="$(_json_val package.json .description)"
    if [[ -n "$val" ]]; then
      pkg_description="$val"
      build_line "Detected description in package.json, setting pkg_description='$val'"
    fi
  fi
  if [[ -z "${pkg_license:-}" ]]; then
    val="$(_json_val package.json .license)"
    if [[ -n "$val" ]]; then
      pkg_license="$val"
      build_line "Detected license in package.json, setting pkg_license='$val'"
    fi
  fi
  if [[ -z "${pkg_maintainer:-}" ]]; then
    val="$(_json_val package.json .author)"
    if [[ -n "$val" ]]; then
      pkg_maintainer="$val"
      build_line "Detected author in package.json, setting pkg_maintainer='$val'"
    fi
  fi
  if [[ -z "${pkg_upstream_url:-}" ]]; then
    val="$(_json_val package.json .homepage)"
    if [[ -n "$val" ]]; then
      pkg_upstream_url="$val"
      build_line "Detected homepage in package.json, setting pkg_upstream_url='$val'"
    fi
  fi
}

_update_pkg_build_deps() {
  # Order here is important--entries which should be first in
  # `${pkg_build_deps[@]}` should be called last.

  _detect_git
  _detect_yarn

  # TODO fin: support different version of npm?
}

_update_pkg_deps() {
  # Order here is important--entries which should be first in `${pkg_deps[@]}`
  # should be called last.

  _add_busybox
  _detect_node
}

_update_bin_dirs() {
  # Add the `bin/` directory and the app's `node_modules/.bin/` directory to
  # the bin dirs so they will be on `PATH.  We do this after the existing
  # values so that the Plan author's `${pkg_bin_dir[@]}` will always win.
  pkg_bin_dirs=(
    ${pkg_bin_dir[@]}
    bin
    $(basename "$scaffolding_app_prefix")/node_modules/.bin
  )
}

_update_svc_run() {
  if [[ -z "$pkg_svc_run" ]]; then
    pkg_svc_run="$pkg_prefix/bin/${pkg_name}-web"
    build_line "Setting pkg_svc_run='$pkg_svc_run'"
  fi
}




_add_busybox() {
  build_line "Adding Busybox package to run dependencies"
  pkg_deps=(core/busybox-static ${pkg_deps[@]})
  debug "Updating pkg_deps=(${pkg_deps[*]}) from Scaffolding detection"
}

_detect_git() {
  if [[ -d ".git" ]]; then
    build_line "Detected '.git' directory, adding git packages as build deps"
    pkg_build_deps=(core/git ${pkg_build_deps[@]})
    debug "Updating pkg_build_deps=(${pkg_build_deps[*]}) from Scaffolding detection"
    _uses_git=true
  fi
}

_detect_node() {
  if [[ -n "$scaffolding_node_pkg" ]]; then
    _node_pkg="$scaffolding_node_pkg"
    build_line "Detected Node.js version in Plan, using '$_node_pkg'"
  else
    local val
    val="$(_json_val package.json .engines.node)"
    if [[ -n "$val" ]]; then
      # TODO fin: Add more robust packages.json to Habitat package matching
      case "$val" in
        *)
          _node_pkg="core/node/$val"
          ;;
      esac
      build_line "Detected Node.js version '$val' in package.json, using '$_node_pkg'"
    elif [[ -f .nvmrc && -n "$(cat .nvmrc)" ]]; then
      val="$(trim "$(cat .nvmrc)")"
      # TODO fin: Add more robust .nvmrc to Habitat package matching
      case "$val" in
        *)
          _node_pkg="core/node/$val"
          ;;
      esac
      build_line "Detected Node.js version '$val' in .nvmrc, using '$_node_pkg'"
    else
      _node_pkg="$_default_node_pkg"
      build_line "No Node.js version detected in Plan, package.json, or .nvmrc, using default '$_node_pkg'"
    fi
  fi
  pkg_deps=($_node_pkg ${pkg_deps[@]})
  debug "Updating pkg_deps=(${pkg_deps[*]}) from Scaffolding detection"
}

_detect_yarn() {
  # TODO fin: support custom version of Yarn package?
  if [[ "$_pkg_manager" == "yarn" ]]; then
    build_line "Adding Yarn package to build dependencies"
    pkg_build_deps=(core/yarn ${pkg_build_deps[@]})
    debug "Updating pkg_build_deps=(${pkg_build_deps[*]}) from Scaffolding detection"
  fi
}




_create_process_bin() {
  local bin cmd env_sh
  bin="$1"
  cmd="$2"
  env_sh="$pkg_svc_config_path/app_env.sh"

  build_line "Creating ${bin} process bin"
  cat <<EOF > "$bin"
#!$(pkg_path_for busybox-static)/bin/sh
set -e
if test -n "\$DEBUG"; then set -x; fi

export HOME="$pkg_svc_data_path"

if [ -f "$env_sh" ]; then
  . "$env_sh"
else
  >&2 echo "No app env file found: '$env_sh'"
  >&2 echo "Have you not started this service ($pkg_origin/$pkg_name) before?"
  >&2 echo ""
  >&2 echo "Aborting..."
  exit 1
fi

cd $pkg_svc_var_path

exec $cmd \$@
EOF
  chmod -v 755 "$bin"
}

_default_toml_has_no() {
  local key toml
  key="$1"
  toml="$PLAN_CONTEXT/default.toml"

  if [[ ! -f "$toml" ]]; then
    return 0
  fi

  if [[ "$(rq -t < "$toml" "at \"${key}\"")" == "null" ]]; then
    return 0
  else
    return 1
  fi
}

# With thanks to:
# https://github.com/heroku/heroku-buildpack-nodejs/blob/master/lib/json.sh
# shellcheck disable=SC2002
_json_val() {
  local json
  json="$1"
  path="$2"

  cat "$json" | "$_jq" --raw-output "$path // \"\""
}

# Heavily inspired from:
# https://gist.github.com/Integralist/1e2616dc0b165f0edead9bf819d23c1e
_rename_function() {
  local orig_name new_name
  orig_name="$1"
  new_name="$2"

  declare -F "$orig_name" > /dev/null \
    || exit_with "No function named $orig_name, aborting" 97
  eval "$(echo "${new_name}()"; declare -f "$orig_name" | tail -n +2)"
}

_set_if_unset() {
  local hash key val
  hash="$1"
  key="$2"
  val="$3"

  if [[ ! -v "$hash[$key]" ]]; then
    eval "$hash[$key]='$val'"
  fi
}

# **Internal** Use a "tar pipe" to copy the app source into a destination
# directory. This function reads from `stdin` for its file/directory manifest
# where each entry is on its own line ending in a newline. Several filters and
# changes are made via this copy strategy:
#
# * All user and group ids are mapped to root/0
# * No extended attributes are copied
# * Some file editor backup files are skipped
# * Some version control-related directories are skipped
# * Any `./habitat/` directory is skipped
# * Any `./vendor/bundle` directory is skipped as it may have native gems
_tar_pipe_app_cp_to() {
  local dst_path tar
  dst_path="$1"
  tar="$(pkg_path_for tar)/bin/tar"

  "$tar" -cp \
      --owner=root:0 \
      --group=root:0 \
      --no-xattrs \
      --exclude-backups \
      --exclude-vcs \
      --exclude='habitat' \
      --exclude='node_modules' \
      --files-from=- \
      -f - \
  | "$tar" -x \
      -C "$dst_path" \
      -f -
}
