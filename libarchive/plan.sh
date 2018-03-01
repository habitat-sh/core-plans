pkg_name=libarchive
pkg_distname=$pkg_name
pkg_origin=core
pkg_version=3.3.2
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Multi-format archive and compression library"
pkg_upstream_url=https://www.libarchive.org
pkg_license=('BSD')
pkg_source=http://www.libarchive.org/downloads/${pkg_distname}-${pkg_version}.tar.gz
pkg_shasum=ed2dbd6954792b2c054ccf8ec4b330a54b85904a80cef477a1c74643ddafa0ce
pkg_dirname=${pkg_distname}-${pkg_version}
pkg_deps=(core/glibc core/openssl core/zlib core/bzip2 core/xz)
pkg_build_deps=(core/gcc core/coreutils core/make)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_build() {
    ./configure \
      --prefix="$pkg_prefix" \
      --without-xml2 \
      --without-lzo2
  make
}

do_check() {
  make check
}
