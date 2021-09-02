pkg_name=tap-xunit
pkg_origin=core
pkg_version=2.4.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("MIT")
pkg_source="https://github.com/aghassemi/tap-xunit/archive/${pkg_version}.tar.gz"
pkg_shasum=78556efa2fdb85335c3e34424ce25c44ef56d4012b2870219f27d271622d74e1
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
