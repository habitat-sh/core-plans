pkg_origin=core
pkg_name=RHash
pkg_version="1.3.6"
pkg_description="Great utility for computing hash sums"
pkg_upstream_url="https://sf.net/p/rhash/"
pkg_license=('MIT')
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_source="https://github.com/rhash/${pkg_name}/archive/v${pkg_version}.tar.gz"
pkg_shasum=964df972b60569b5cb35ec989ced195ab8ea514fc46a74eab98e86569ffbcf92
pkg_deps=(core/glibc core/gcc-libs core/openssl)
pkg_build_deps=(core/gcc core/make core/which)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_build() {
  ./configure --prefix="${pkg_prefix}" --extra-cflags="$CFLAGS" --extra-ldflags="$LDFLAGS"
  make
}

do_install() {
  make install
  make -C librhash install-headers install-lib-shared install-so-link
}
