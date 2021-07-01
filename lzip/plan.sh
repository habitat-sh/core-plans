pkg_name=lzip
pkg_origin=core
pkg_version=1.22
pkg_description="A lossless data compressor with a user interface similar to the one of gzip or bzip2."
pkg_upstream_url="http://www.nongnu.org/lzip/lzip.html"
pkg_license=('GPL-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://download.savannah.gnu.org/releases/lzip/lzip-${pkg_version}.tar.gz"
pkg_shasum=c3342d42e67139c165b8b128d033b5c96893a13ac5f25933190315214e87a948
pkg_deps=(core/glibc core/gcc-libs)
pkg_build_deps=(core/gcc core/make core/diffutils)
pkg_bin_dirs=(bin)

do_check() {
  make check
}
