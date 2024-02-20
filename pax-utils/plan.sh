pkg_name=pax-utils
pkg_version=1.3.3
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL')
pkg_description="ELF related utils for ELF 32/64 binaries that can check files
  for security relevant properties"
pkg_upstream_url='http://hardened.gentoo.org/pax-utils.xml'
pkg_source="https://github.com/gentoo/pax-utils/archive/refs/tags/v${pkg_version}.tar.gz"
pkg_shasum="5b83b440fb18995f622569fdebd48f060999d61c861c71db96db788f3f569c88"
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
  make
}

do_check() {
  make check USE_PYTHON='no'
}

do_install() {
  install -m755 scanelf "${pkg_prefix}/bin"
  install -m755 dumpelf "${pkg_prefix}/bin"
  install -m755 pspax "${pkg_prefix}/bin"
  install -m755 scanmacho "${pkg_prefix}/bin"
  fix_interpreter "$pkg_prefix/bin/*" core/bash bin/bash
}
