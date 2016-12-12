pkg_name=qemu
pkg_origin=core
pkg_version=2.7.0
pkg_source=http://wiki.qemu-project.org/download/${pkg_name}-${pkg_version}.tar.bz2
pkg_shasum=326e739506ba690daf69fc17bd3913a6c313d9928d743bd8eddb82f403f81e53
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="QEMU is a generic and open source machine emulator and virtualizer."
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
  smacfarlane/libcap-ng
  core/lzo
  core/ncurses
  core/pcre
  core/pixman
  core/python2
  core/snappy
  core/util-linux
  smacfarlane/vde2
  core/zlib
)

do_build() {
  mkdir build
  cd build

  # QEMU uses its own CFLAGS, etc. so we need to inject our environment into
  #   those variables.
  export CFLAGS+=" -fPIC"
  export QEMU_CFLAGS=$CFLAGS
  ../configure --prefix=${pkg_prefix} 

  make
}

do_install() {
  cd build
  make install
}

do_strip() {
# do_default_strip bombs with the following error:
#   strip: Unable to recognise the format of the input file 
#     `/hab/pkgs/core/qemu/2.7.0/20161213044729/share/qemu/palcode-clipper'
# where:
#  file /hab/pkgs/core/qemu/2.7.0/20161213044729/share/qemu/palcode-clipper
#     /hab/pkgs/core/qemu/2.7.0/20161213044729/share/qemu/palcode-clipper: 
#     ELF 64-bit LSB executable, Alpha (unofficial), version 1 (SYSV), statically linked, not stripped
  return 0
}
