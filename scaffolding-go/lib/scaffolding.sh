#
# DO NOT OVERRIDE `do_default_xxxxx` IN PLANS!
#

#
# Internal functions. Do not use these in your plans as they can change.
#

# This strips URI prefixes from strings passed into the function. This is
# required for `go get` to function since it does not support URI.
_sanitize_pkg_source() {
  local uri
  local scheme
  uri="$1"
  scheme="$(echo "$uri" | grep :// | sed -e's%^\(.*://\).*%\1%g')"
  printf "%s" "${uri/$scheme/}"
}

# The default_begin phase is executed prior to loading the scaffolding. As such
# we have a scaffolding specific callback to allow us to run anything we need
# to execute before download and build. This callback executes immediately
# after the scaffolding is loaded.
_scaffolding_begin() {
  return 0
}

#
# Scaffolding Variables
#

# Path constuctor for GOPATH
scaffolding_go_gopath=${scaffolding_go_gopath:-"$HAB_CACHE_SRC_PATH/$pkg_dirname"}
export scaffolding_go_gopath
# Set GOPATH
GOPATH="$scaffolding_go_gopath"
export GOPATH
# Path string used by go get without preceeding URI notation.
scaffolding_go_src_path="${GOPATH:?}/src/$(_sanitize_pkg_source "$pkg_source")"
export scaffolding_go_src_path

#
# Scaffolding Callback Functions
#

scaffolding_go_get() {
  local deps
  deps=($pkg_source ${scaffolding_go_build_deps[@]})
  build_line "Running go get"
  if [[ "${#deps[@]}" -gt 0 ]] ; then
    for dependency in "${deps[@]}" ; do
      go get "$(_sanitize_pkg_source "$dependency")"
    done
  fi
}

# Fetch golang specific build dependencies.
scaffolding_go_download() {
  scaffolding_go_get
}

# Recursively clean GOPATH and dependencies.
do_default_clean() {
  local clean_args
  clean_args="-r -i"
  if [[ -n "$DEBUG" ]]; then
    clean_args="$clean_args -x"
  fi

  build_line "Clean the cache"

  pushd "$scaffolding_go_src_path"
  # shellcheck disable=SC2086
  go clean $clean_args
  popd
}

# Assume a automake/autoconf build script if the go project uses one.
# Otherwise, attempt to just run go build.
scaffolding_go_build() {
  export PATH="$PATH:$GOPATH/bin"

  pushd "${GOPATH:?}/src/$(_sanitize_pkg_source "$pkg_source")"
  if [[ -f "$scaffolding_go_src_path/Makefile" ]]; then
    make
  else
    go build
  fi
  popd
}

scaffolding_go_install() {
  pushd "$scaffolding_go_src_path"
  go install
  popd
  cp -r "${scaffolding_go_gopath:?}/bin" "${pkg_prefix}/${bin}"
}


do_default_download() {
  scaffolding_go_download
}

do_default_verify() {
  return 0
}

do_default_unpack() {
  return 0
}

do_default_build() {
  scaffolding_go_build
}

do_default_install() {
  scaffolding_go_install
}
