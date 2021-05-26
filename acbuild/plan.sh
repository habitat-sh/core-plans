pkg_origin=core
pkg_name=acbuild
pkg_version=0.4.0
pkg_description="A tool to build Application Container Images (ACI)"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2')
pkg_upstream_url=https://github.com/containers/build
pkg_source="https://github.com/containers/build/archive/v${pkg_version}.tar.gz"
pkg_shasum=88d99a002eb53212752d6f405d9e02555512b27c5b84e8ef5828607ee9774ed4
pkg_dirname="build-${pkg_version}"
pkg_deps=(
  core/gnupg
  core/glibc
)
pkg_build_deps=(
  core/go
  core/coreutils
)
pkg_bin_dirs=(bin)

do_prepare() {
  do_default_prepare

  export GO111MODULE=auto

  build_line "Modifying 'build' file"
  sed -e "s#\#\!/usr/bin/env#\#\!$(pkg_path_for core/coreutils)/bin/env#" -i build
  sed -e "s#VERSION=\$(cd \"\${DIR}\" && git describe --dirty)#VERSION=${pkg_version}#" -i build
}

do_build() {
  ./build
}

do_install() {
  cp "${HAB_CACHE_SRC_PATH}/${pkg_dirname}/bin/acbuild" "${pkg_prefix}/bin/"
}
