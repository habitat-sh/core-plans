pkg_name=jo
pkg_origin=core
pkg_version=1.4
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0')
pkg_description="jo, a small utility to create JSON objects."
pkg_upstream_url="https://github.com/jpmens/jo"
pkg_source="https://github.com/jpmens/${pkg_name}/releases/download/v${pkg_version}/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum=0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5
pkg_build_deps=(core/linux-headers-musl core/musl core/make core/gcc core/diffutils)
pkg_deps=()
pkg_bin_dirs=(bin)

do_prepare() {
  CFLAGS="-I$(pkg_path_for linux-headers-musl)/include -I$(pkg_path_for musl)/include"
  build_line "Setting CFLAGS=$CFLAGS"

  LDFLAGS="-static $LDFLAGS"
  build_line "Setting LDFLAGS=$LDFLAGS"

  export CC=musl-gcc
  build_line "Setting CC=$CC"
}

do_check() {
  make check
}
