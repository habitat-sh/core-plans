#
# DO NOT OVERRIDE `do_default_xxxxx` IN PLANS!
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

#
# Scaffolding Variables
#

# Path constuctor for GOPATH
export scaffolding_go_gopath=${scaffolding_go_gopath:-"${HAB_CACHE_SRC_PATH}/scaffolding-go-gopath"}

# Set GOPATH
#
# The GOPATH is very important to develop go applications, it has a very strict directory
# structure that we need to follow.
#
# => Read more about it at: https://golang.org/doc/code.html#Workspaces
export GOPATH="$scaffolding_go_gopath"

# Path to the Workspace src/ directory
export scaffolding_go_workspace_src="$GOPATH/src"

# Base path
#
# When you start having sub-packages or dependencies you are going to need to choose a
# unique base_path, if you don't specify one, we will use the default localhost/user.
#
# => Read more about it at: https://golang.org/doc/code.html#ImportPaths
export scaffolding_go_base_path=${scaffolding_go_base_path:-"localhost/user"}

# If $pkg_source is set, it means that we are building a packages from source.
# Otherwise we will try to build the package from the local /src. To do that we
# need to check if $scaffolding_go_base_path is set, if not we will use the
# default `localhost/user` since Go looks at this path structure to create
# the directory structure inside the Go Workspace.
if [ "$pkg_source" ]; then
  scaffolding_go_pkg_path="$scaffolding_go_workspace_src/$(_sanitize_pkg_source "$pkg_source")"
else
  scaffolding_go_pkg_path="$scaffolding_go_workspace_src/$scaffolding_go_base_path/$pkg_name"
fi

export scaffolding_go_pkg_path

#
# Scaffolding Callback Functions
#

scaffolding_go_before() {
  # Initialize the Go Workspace package path if we are tryng to build the
  # package from local /src, that is when there is no $pkg_source set.
  if [ ! "$pkg_source" ]; then
    mkdir -p "$scaffolding_go_workspace_src/$scaffolding_go_base_path"
    ln -sf "${SRC_PATH:-/src}" "$scaffolding_go_pkg_path"
  fi
}

scaffolding_go_get() {
  if [ "$pkg_source" ]; then
    build_line "Downloading package from source. ($pkg_source)"
    go get "$(_sanitize_pkg_source "$pkg_source")"
  fi

  if [ "${#scaffolding_go_build_deps[@]}" -gt 0 ] ; then
    build_line "Downloading Go build dependencies speficied inside 'scaffolding_go_build_deps'"
    for dependency in "${scaffolding_go_build_deps[@]}" ; do
      go get "$(_sanitize_pkg_source "$dependency")"
    done
  fi
}

# Fetch golang specific build dependencies.
scaffolding_go_download() {
  scaffolding_go_get
}

# Recursively clean GOPATH and dependencies.
scaffolding_go_clean() {
  local clean_args
  clean_args="-r -i"
  if [ -n "$DEBUG" ]; then
    clean_args="$clean_args -x"
  fi

  build_line "Clean the cache"

  pushd "$scaffolding_go_pkg_path" >/dev/null
  # shellcheck disable=SC2086
  go clean $clean_args
  popd >/dev/null
}

# Assume a automake/autoconf build script if the go project uses one.
# Otherwise, attempt to just run go build.
scaffolding_go_build() {
  export PATH="$PATH:$GOPATH/bin"

  pushd "$scaffolding_go_pkg_path" >/dev/null
  if [[ -f "$scaffolding_go_pkg_path/Makefile" ]]; then
    make
  else
    go build
  fi
  popd >/dev/null
}

scaffolding_go_install() {
  pushd "$scaffolding_go_pkg_path" >/dev/null
  go install
  popd >/dev/null
  # Avoids the need to have pkg_bin_dirs=(bin) on every plan
  mkdir -p "${pkg_prefix}/bin/"
  cp -r "${scaffolding_go_gopath:?}/bin" "${pkg_prefix}/${bin}"
}

do_default_before() {
  scaffolding_go_before
}

do_default_download() {
  scaffolding_go_download
}

do_default_clean() {
  scaffolding_go_clean
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
