pkg_name=man-pages
pkg_origin=core
pkg_version=5.01
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0-or-later')
pkg_source=https://www.kernel.org/pub/linux/docs/"$pkg_name"/"${pkg_name}"-"${pkg_version}".tar.xz
pkg_upstream_url="https://www.kernel.org/doc/man-pages/"
pkg_description="The Linux man-pages project documents the Linux kernel and C library interfaces that are employed by user-space programs."
pkg_shasum=7dfce1334e22e2565cf219a83c5cdfa1fc5e877d54ee15a0d1f5f1de5143b627
pkg_build_deps=(core/coreutils core/make)

do_build() {
  return 0
}

do_install() {
  make install prefix="$pkg_prefix"
}
