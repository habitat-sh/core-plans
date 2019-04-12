pkg_name=tap-xunit
pkg_origin=core
pkg_version=2.3.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("MIT")
pkg_source="https://github.com/aghassemi/tap-xunit/archive/${pkg_version}.tar.gz"
pkg_shasum=2ab6d5bbe47cc01cc12bbb8df6e3c0f1f24b8b9b17c52cad246a291f7468612f
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
