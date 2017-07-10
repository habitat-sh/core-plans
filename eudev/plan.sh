pkg_name=eudev
pkg_origin=core
pkg_version="3.2.1"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0')
pkg_source="http://dev.gentoo.org/~blueness/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="57e3d9e51cfefbdad431848ea0ad8ae1cde04928da42474f44bd200b12f5fe19"
pkg_deps=(core/glibc core/gperf)
pkg_build_deps=(core/make core/gcc core/sed)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin sbin)
pkg_pconfig_dirs=(lib/pkgconfig)
pkg_description="eudev is a device manager for the Linux kernel"
pkg_upstream_url="https://wiki.gentoo.org/wiki/Project:Eudev"

do_prepare() {
  # http://www.linuxfromscratch.org/lfs/view/stable/chapter06/eudev.html
  sed -r -i 's|/usr(/bin/test)|\1|' test/udev-test.pl
  sed -i '/keyboard_lookup_key/d' src/udev/udev-builtin-keyboard.c
  cat > config.cache << "EOF"
HAVE_BLKID=1
BLKID_LIBS="-lblkid"
BLKID_CFLAGS="-I/tools/include"
EOF
}
