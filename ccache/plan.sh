pkg_origin=core
pkg_name=ccache
pkg_version=3.7.12
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-3.0')
pkg_description="ccache is a compiler cache. It speeds up recompilation by caching previous compilations and "\
"detecting when the same compilation is being done again."
pkg_upstream_url=https://ccache.samba.org/
pkg_source=https://github.com/ccache/ccache/releases/download/v${pkg_version}/ccache-${pkg_version}.tar.gz
pkg_shasum=d2abe88d4c283ce960e233583061127b156ffb027c6da3cf10770fc0c7244194
pkg_deps=(core/glibc core/zlib)
pkg_build_deps=(core/gcc core/make core/diffutils core/which core/perl)
pkg_bin_dirs=(bin)

do_check() {
  make test
}
