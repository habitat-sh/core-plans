pkg_name=runit
pkg_origin=core
pkg_version=2.1.2
pkg_license=('BSD-3-Clause')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=http://smarden.org/runit/runit-"$pkg_version".tar.gz
pkg_upstream_url="http://smarden.org/runit"
pkg_description="runit is a cross-platform Unix init scheme with service supervision, a replacement for sysvinit, and other init schemes"
pkg_shasum=6fd0160cb0cf1207de4e66754b6d39750cff14bb0aa66ab49490992c0c47ba18
pkg_build_deps=(core/coreutils core/gcc core/make)
pkg_deps=(core/glibc)
pkg_bin_dirs=(bin)

do_unpack() {
  mkdir -p "$HAB_CACHE_SRC_PATH"/"$pkg_name"-"$pkg_version"
  tar zxf "$HAB_CACHE_SRC_PATH"/"$pkg_filename" -C "$HAB_CACHE_SRC_PATH"/"$pkg_name"-"$pkg_version"
}

do_build() {
  pushd admin/runit-"${pkg_version}"
  ./package/compile
  popd
}

do_install() {
  mkdir -p "$pkg_prefix"/bin
  cp admin/runit-"$pkg_version"/command/* "$pkg_prefix"/bin
}
