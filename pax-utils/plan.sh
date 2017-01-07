pkg_name=pax-utils
pkg_version=1.1.7
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL')
pkg_description="ELF related utils for ELF 32/64 binaries that can check files
  for security relevant properties"
pkg_upstream_url='http://hardened.gentoo.org/pax-utils.xml'
pkg_source=http://distfiles.gentoo.org/distfiles/${pkg_name}-${pkg_version}.tar.xz
pkg_shasum=bb9bdbf0888de9444b53b78f7b8069af9832bac7cef0588030b8ce49e8ebad10
pkg_deps=(
  core/bash
  core/glibc
  core/libcap
)
pkg_build_deps=(
  core/diffutils
  core/gcc
  core/make
  core/pkg-config
)
pkg_bin_dirs=(bin)

do_build() {
  ./configure --prefix="$pkg_prefix" \
              --with-caps \
              --without-python
  make
}

do_check() {
  make check USE_PYTHON='no'
}

do_install() {
  do_default_install
  fix_interpreter "$pkg_prefix/bin/*" core/bash bin/bash
}
