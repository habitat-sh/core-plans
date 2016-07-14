pkg_name=libscrypt
pkg_version=1.21
pkg_origin=core
pkg_license=('BSD-2-Clause')
pkg_description="An implementation of Colin Percival's scrypt hash"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_upstream_url="http://www.lolware.net/libscrypt.html"
pkg_source=https://github.com/technion/libscrypt/archive/v${pkg_version}.tar.gz
pkg_shasum=68e377e79745c10d489b759b970e52d819dbb80dd8ca61f8c975185df3f457d3
pkg_deps=(core/glibc)
pkg_build_deps=(core/gcc core/make)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

do_build() {
  CFLAGS="${CFLAGS} -O2 -Wall -g -D_FORTIFY_SOURCE=2 -fstack-protector -fPIC"
  make
}

do_install() {
  PREFIX="${pkg_prefix}" make install
}

do_check() {
  make check
}
