pkg_name=qemu
pkg_origin=core
pkg_version=2.12.1
pkg_source=https://download.qemu.org/qemu-${pkg_version}.tar.bz2
pkg_shasum=4150809a52d821398dfd38c94b065513ef26b393fda9aba4bb6f09644cf1e5ca
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="QEMU is a generic and open source machine emulator and virtualizer."
pkg_upstream_url="http://www.qemu.org"
pkg_license=('GPL-2.0')
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_build_deps=(
  core/autoconf
  core/automake
  core/diffutils
  core/gcc
  core/libtool
  core/make
  core/m4
  core/pkg-config
)
pkg_deps=(
  core/bzip2
  core/curl
  core/gcc-libs
  core/glib
  core/glibc
  core/jemalloc
  core/libaio
  core/libcap-ng
  core/lzo
  core/ncurses
  core/patch
  core/pcre
  core/pixman
  core/python2
  core/snappy
  core/util-linux
  core/vde2
  core/zlib
)

do_build() {
  mkdir build
  pushd build

  # QEMU uses its own CFLAGS, etc. so we need to inject our environment into
  #   those variables.
  export CFLAGS+=" -fPIC"
  export QEMU_CFLAGS=$CFLAGS
  ../configure --prefix="${pkg_prefix}" \
    --target-list=x86_64-softmmu
  make
  popd
}

do_install() {
  pushd build
  make install
  popd
}

do_strip() {
  return 0
}
