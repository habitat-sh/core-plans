pkg_name=nspr
pkg_origin=core
pkg_version=4.12
pkg_license=("MPL-2.0")
pkg_description="Netscape Portable Runtime"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_upstream_url=https://developer.mozilla.org/en-US/docs/Mozilla/Projects/NSPR
pkg_source=https://ftp.mozilla.org/pub/mozilla.org/nspr/releases/v${pkg_version}/src/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=e0b10a1e569153668ff8bdea6c7e491b389fab69c2f18285a1ebf7c2ea4269de
pkg_deps=(core/glibc)
pkg_build_deps=(core/gcc core/make)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include/nspr)
pkg_lib_dirs=(lib)

do_build() {
  ./nspr/configure --prefix="${pkg_prefix}" \
                   --enable-optimize \
                   --disable-debug \
                   --enable-64bit
  make
}
