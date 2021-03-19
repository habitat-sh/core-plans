pkg_name=tap-xunit
pkg_origin=core
pkg_version=2.4.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("MIT")
pkg_source="https://github.com/aghassemi/tap-xunit/archive/${pkg_version}.tar.gz"
pkg_shasum=bfcea54ca9dafd11468666d40f04060eb26e51947d6b491f26cb16b74df4c005
pkg_deps=(
  core/coreutils
  core/node
)
pkg_bin_dirs=(bin)
pkg_description="TAP to xUnit XML converter"
pkg_upstream_url=https://github.com/aghassemi/tap-xunit

do_build() {
  return 0
}

do_install() {
	cp -r ./* "${pkg_prefix}/"
  pushd "${pkg_prefix}" > /dev/null
  npm install
  fix_interpreter "${pkg_prefix}/bin/*" core/coreutils bin/env
  popd > /dev/null
}
