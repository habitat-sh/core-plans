pkg_name=man-pages
pkg_origin=core
pkg_version=5.11
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0-or-later')
pkg_source=https://www.kernel.org/pub/linux/docs/"$pkg_name"/"${pkg_name}"-"${pkg_version}".tar.xz
pkg_upstream_url="https://www.kernel.org/doc/man-pages/"
pkg_description="The Linux man-pages project documents the Linux kernel and C library interfaces that are employed by user-space programs."
pkg_shasum=3eda5dce5184599ec37dae3494cf964c550362e9a41fb724792da610bdb13caa
pkg_build_deps=(core/coreutils core/make)

do_build() {
  return 0
}

do_install() {
  make install prefix="$pkg_prefix"
}
