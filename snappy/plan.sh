pkg_origin=core
pkg_name=snappy
pkg_version=1.1.8
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('BSD-3-Clause')
pkg_source=https://github.com/google/snappy/archive/${pkg_version}.tar.gz
pkg_shasum=16b677f07832a612b0836178db7f374e414f94657c138e6993cbfc5dcc58651f
pkg_deps=(core/glibc)
pkg_build_deps=(core/gcc core/make core/autoconf core/automake core/pkg-config core/libtool core/m4 core/sed core/pkg-config)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_upstream_url=https://github.com/google/snappy
pkg_description="A fast compressor/decompressor http://google.github.io/snappy/"

do_build () {
 libtoolize --force
 ACLOCAL_PATH=$(pkg_path_for core/pkg-config)/share/aclocal autoreconf -iv
 ./configure --prefix="$pkg_prefix"
 make
}

do_check () {
  make check
}
