pkg_name=lzip
pkg_origin=core
pkg_version=1.22
pkg_description="A lossless data compressor with a user interface similar to the one of gzip or bzip2."
pkg_upstream_url="http://www.nongnu.org/lzip/lzip.html"
pkg_license=('GPL-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://download.savannah.gnu.org/releases/lzip/lzip-${pkg_version}.tar.gz"
pkg_shasum=e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
pkg_deps=(core/glibc core/gcc-libs)
pkg_build_deps=(core/gcc core/make core/diffutils)
pkg_bin_dirs=(bin)

do_check() {
  make check
}
