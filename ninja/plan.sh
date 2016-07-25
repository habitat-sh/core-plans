pkg_name=ninja
pkg_origin=core
pkg_version=1.7.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_upstream_url=https://ninja-build.org/
pkg_description="A small build system with a focus on speed"
pkg_licenses=('Apache-2.0')
pkg_source=https://github.com/ninja-build/${pkg_name}/archive/v${pkg_version}.tar.gz
pkg_shasum=51581de53cf4705b89eb6b14a85baa73288ad08bff256e7d30d529155813be19
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
