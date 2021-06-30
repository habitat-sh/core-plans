pkg_name=ninja
pkg_origin=core
pkg_version=1.10.2
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_upstream_url=https://ninja-build.org/
pkg_description="A small build system with a focus on speed"
pkg_licenses=('Apache-2.0')
pkg_source=https://github.com/ninja-build/${pkg_name}/archive/v${pkg_version}.tar.gz
pkg_shasum=ce35865411f0490368a8fc383f29071de6690cbadc27704734978221f25e2bed
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
