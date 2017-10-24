# shellcheck shell=bash

scaffolding_load() {
  _setup_funcs
  _setup_vars

  pushd "$SRC_PATH" > /dev/null
  _confirm_scaffolding
  _detect_app_type
  _detect_process_bins
  _update_vars
  _update_pkg_build_deps
  _update_pkg_deps
  _update_bin_dirs
  popd > /dev/null
}

do_default_prepare() {
  _update_svc_run

  _app_cache_dir="$CACHE_PATH/cache"

  # The install prefix path for the app
  scaffolding_app_prefix="$pkg_prefix/app"
  # The gradle build directory
  scaffolding_build_dir="$_app_cache_dir/build"
  # The gradle build directory
  scaffolding_jars_glob="${scaffolding_jars_glob:-libs/*.jar}"

  _cache_archive="$pkg_output_path/build-cache/build-cache-scaffolding-gradle-$(\
    echo "$PLAN_CONTEXT" \
    | $bb sed -e 's,^/$,root,' -e 's,^/,,' -e 's,/,--,g').tar"

  export GRADLE_USER_HOME="$CACHE_PATH/cache/.gradle"
  build_line "Setting GRADLE_USER_HOME=$GRADLE_USER_HOME"

  GRADLE_OPTS="$GRADLE_OPTS -Dorg.gradle.daemon=false"
  GRADLE_OPTS="$GRADLE_OPTS -Dorg.gradle.caching=true"
  GRADLE_OPTS="$GRADLE_OPTS -Dorg.gradle.java.home=$(pkg_path_for "$_jdk_pkg")"
  GRADLE_OPTS="$GRADLE_OPTS -Dorg.gradle.project.buildDir=$scaffolding_build_dir"
  export GRADLE_OPTS
  build_line "Setting GRADLE_OPTS=$GRADLE_OPTS"
}

do_default_build() {
  scaffolding_cache_load
  scaffolding_build
  scaffolding_cache_save
  scaffolding_setup_app_config
}

do_default_install() {
  scaffolding_cp_jars
  scaffolding_create_process_bins
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



scaffolding_cache_load() {
  local dst
  dst="$(dirname "$_app_cache_dir")"

  if [[ -f "$_cache_archive" ]]; then
    build_line "Loading build cache $_cache_archive into $dst"
    "$(pkg_path_for tar)/bin/tar" xf "$_cache_archive" -C "$dst"
  else
    build_line "No build cache found, skipping"
  fi
}

scaffolding_cache_save() {
  local src_dir src
  src="$(basename "$_app_cache_dir")"
  src_dir="$(dirname "$_app_cache_dir")"

  if [[ -f "$_cache_archive" ]]; then
    rm -f "$_cache_archive"
  fi

  build_line "Saving build cache $_cache_archive from $src_dir"
  mkdir -p "$(dirname "$_cache_archive")"
  "$(pkg_path_for tar)/bin/tar" -cf "$_cache_archive" \
    --exclude='build/*' -C "$src_dir" "$src"

  # TODO fn: owner/perms for cache
}

scaffolding_build() {
  case "$_app_type" in
    springboot)
      gradle build --project-cache-dir "$GRADLE_USER_HOME" -x test
      ;;
    ratpack)
      gradle installDist --project-cache-dir "$GRADLE_USER_HOME" -x test
      ;;
    gradle)
      gradle stage --project-cache-dir "$GRADLE_USER_HOME"
      ;;
  esac
}

scaffolding_setup_app_config() {
  local t
  t="$CACHE_PATH/default.scaffolding.toml"

  echo "" >> "$t"

  if _default_toml_has_no app; then
    echo "" >> "$t"
    echo '[app]' >> "$t"
    if _default_toml_has_no app.port; then
      echo "port = $scaffolding_app_port" >> "$t"
    fi
  fi
}

scaffolding_cp_jars() {
  # shellcheck disable=SC2012,SC2086
  ls -1 "$scaffolding_build_dir"/$scaffolding_jars_glob | while read -r f; do
    install -v -D -m 0644 "$f" "$scaffolding_app_prefix/$(basename "$f")"
  done
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
  # The default Gradle package if one cannot be detected
  _default_gradle_pkg="core/gradle"
  # `$scaffolding_gradle_pkg` is empty by default
  : "${scaffolding_gradle_pkg:=}"
  # The default JDK package if one cannot be detected
  _default_jdk_pkg="core/jdk8"
  # `$scaffolding_jdk_pkg` is empty by default
  : "${scaffolding_jdk_pkg:=}"
  # The default JRE package if one cannot be detected
  _default_jre_pkg="core/jre8"
  # `$scaffolding_jre_pkg` is empty by default
  : "${scaffolding_jre_pkg:=}"
  #
  : "${scaffolding_app_port:=8080}"
  # If `${scaffolding_env[@]` is not yet set, setup the hash
  if [[ ! "$(declare -p scaffolding_env 2> /dev/null || true)" =~ "declare -A" ]]; then
    declare -g -A scaffolding_env
  fi
  # If `${scaffolding_process_bins[@]` is not yet set, setup the hash
  if [[ ! "$(declare -p scaffolding_process_bins 2> /dev/null || true)" =~ "declare -A" ]]; then
    declare -g -A scaffolding_process_bins
  fi
  # Default Java flags and options
  if [[ ! "$(declare -p scaffolding_java_opts 2> /dev/null || true)" =~ "declare -a" ]]; then
    scaffolding_java_opts=()
  fi
  # Default flags and options to the jar being executed
  if [[ ! "$(declare -p scaffolding_extra_opts 2> /dev/null || true)" =~ "declare -a" ]]; then
    scaffolding_extra_opts=()
  fi
}

_confirm_scaffolding() {
  if [[ -f build.gradle || -f setttings.gradle ]]; then
    return 0
  else
    exit_with "Gradle Scaffolding cannot find build.gradle or settings.gradle" 5
  fi
}

_detect_app_type() {
  _detect_springboot_app \
    || _detect_ratpack_app \
    || _detect_gradle_app
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

  _set_if_unset scaffolding_process_bins "web" \
    "java -Dserver.port=\$PORT \$JAVA_OPTS -jar *.jar \$EXTRA_OPTS"

  _set_if_unset scaffolding_process_bins "sh" 'sh'
}

_update_vars() {
  local val

  _set_if_unset scaffolding_env PORT "{{cfg.app.port}}"
  _set_if_unset scaffolding_env JAVA_OPTS "$(join_by ' ' "${scaffolding_java_opts[@]}")"
  _set_if_unset scaffolding_env EXTRA_OPTS "$(join_by ' ' "${scaffolding_extra_opts[@]}")"
  # Export the app's listen port
  _set_if_unset pkg_exports port "app.port"

  # TODO fin: try to detect `$pkg_version` in a properties file. This may
  # involve a change to `hab-plan-build.sh` to delay the checking of required
  # Plan variables.
}

_update_pkg_build_deps() {
  # Order here is important--entries which should be first in
  # `${pkg_build_deps[@]}` should be called last.

  _detect_gradle
  _detect_jdk
}

_update_pkg_deps() {
  # Order here is important--entries which should be first in `${pkg_deps[@]}`
  # should be called last.

  _add_busybox
  _detect_jre
}

_update_bin_dirs() {
  pkg_bin_dirs=(
    ${pkg_bin_dir[@]}
    bin
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

_detect_gradle() {
  if [[ -n "$scaffolding_gradle_pkg" ]]; then
    _gradle_pkg="$scaffolding_gradle_pkg"
    build_line "Detected Gradle version in Plan, using '$_gradle_pkg'"
  else
    _gradle_pkg="$_default_gradle_pkg"
    build_line "No Gradle version detected in Plan, using default '$_gradle_pkg'"
  fi
  pkg_build_deps=($_gradle_pkg ${pkg_build_deps[@]})
  debug "Updating pkg_build_deps=(${pkg_build_deps[*]}) from Scaffolding detection"
}

_detect_jdk() {
  if [[ -n "$scaffolding_jdk_pkg" ]]; then
    _gradle_pkg="$scaffolding_jdk_pkg"
    build_line "Detected JDK version in Plan, using '$_jdk_pkg'"
  else
    _jdk_pkg="$_default_jdk_pkg"
    build_line "No JDK version detected in Plan, using default '$_jdk_pkg'"
  fi
  pkg_build_deps=($_jdk_pkg ${pkg_build_deps[@]})
  debug "Updating pkg_deps=(${pkg_build_deps[*]}) from Scaffolding detection"
}

_detect_jre() {
  if [[ -n "$scaffolding_jre_pkg" ]]; then
    _gradle_pkg="$scaffolding_jre_pkg"
    build_line "Detected JRE version in Plan, using '$_jre_pkg'"
  else
    _jre_pkg="$_default_jre_pkg"
    build_line "No JRE version detected in Plan, using default '$_jre_pkg'"
  fi
  pkg_deps=($_jre_pkg ${pkg_deps[@]})
  debug "Updating pkg_deps=(${pkg_deps[*]}) from Scaffolding detection"
}

_detect_springboot_app() {
  if [[ -f build.gradle ]] \
      && grep -q "^[^/].*org.springframework.boot:spring-boot" build.gradle; then
    build_line "Detected Spring Boot app type"
    _app_type="springboot"
    return 0
  else
    return 1
  fi
}

_detect_ratpack_app() {
  if [[ -f build.gradle ]] \
      && grep -q "^[^/].*io.ratpack.ratpack" build.gradle; then
    build_line "Detected Ratpack app type"
    _app_type="ratpack"
    return 0
  else
    return 1
  fi
}

_detect_gradle_app() {
  build_line "Detected Gradle app type"
  _app_type="gradle"
  return 0
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

cd $scaffolding_app_prefix

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
