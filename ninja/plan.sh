pkg_name=ninja
pkg_origin=core
pkg_version=1.10.2
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_upstream_url=https://ninja-build.org/
pkg_description="A small build system with a focus on speed"
pkg_licenses=('Apache-2.0')
pkg_source=https://github.com/ninja-build/${pkg_name}/archive/v${pkg_version}.tar.gz
pkg_shasum=86b8700c3d0880c2b44c2ff67ce42774aaf8c28cbf57725cb881569288c1c6f4
pkg_deps=(core/glibc core/gcc-libs)
pkg_build_deps=(core/gcc core/python2 core/re2c)
pkg_bin_dirs=(bin)

do_build() {
  python configure.py --bootstrap
}

do_install() {
  mkdir -p "$pkg_prefix/bin/"
  cp ninja "$pkg_prefix/bin/"
}

do_check() {
  ./ninja all
  ./ninja_test --gtest_filter=-SubprocessTest.SetWithLots
  python ./misc/ninja_syntax_test.py
}
