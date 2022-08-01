pkg_name=node16
pkg_origin=core
pkg_version=16.13.1
pkg_description="Node.js® is a JavaScript runtime built on Chrome's V8 JavaScript engine."
pkg_upstream_url=https://nodejs.org/
pkg_license=('MIT')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://nodejs.org/dist/v${pkg_version}/node-v${pkg_version}.tar.gz"
pkg_shasum=34b23965457fb08a8c62f81e8faf74ea60587cda6fa898e5d030211f5f374cb6
pkg_deps=(
  core/glibc
  core/gcc-libs
  core/python
  core/bash
)
pkg_build_deps=(
  core/gcc
  core/grep
  core/make
  core/which
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_interpreters=(bin/node)
pkg_lib_dirs=(lib)
pkg_dirname="node-v${pkg_version}"

do_prepare() {
  # ./configure has a shebang of #!/usr/bin/env python. Fix it.
  sed -e "s#/usr/bin/env python#$(pkg_path_for python)/bin/python#" -i configure
}

do_build() {
  ./configure \
    --prefix "${pkg_prefix}" \
    --dest-cpu "x64" \
    --dest-os "linux"

  make -j"$(nproc)"
}

do_install() {
  do_default_install

  # Node produces a lot of scripts that hardcode `/usr/bin/env`, so we need to
  # fix that everywhere to point directly at the env binary in core/coreutils.
  grep -nrlI '^\#\!/usr/bin/env' "$pkg_prefix" | while read -r target; do
    sed -e "s#\#\!/usr/bin/env node#\#\!${pkg_prefix}/bin/node#" -i "$target"
    sed -e "s#\#\!/usr/bin/env sh#\#\!$(pkg_path_for bash)/bin/sh#" -i "$target"
    sed -e "s#\#\!/usr/bin/env bash#\#\!$(pkg_path_for bash)/bin/bash#" -i "$target"
    sed -e "s#\#\!/usr/bin/env python#\#\!$(pkg_path_for python)/bin/python#" -i "$target"
  done

  # This script has a hardcoded bare `node` command
  sed -e "s#^\([[:space:]]\)\+node\([[:space:]]\)#\1${pkg_prefix}/bin/node\2#" -i "${pkg_prefix}/lib/node_modules/npm/bin/node-gyp-bin/node-gyp"
}
