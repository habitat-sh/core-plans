pkg_origin=core
pkg_name=ccache
pkg_version=3.6
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-3.0')
pkg_description="ccache is a compiler cache. It speeds up recompilation by caching previous compilations and "\
"detecting when the same compilation is being done again."
pkg_upstream_url=https://ccache.samba.org/
pkg_source="https://www.samba.org/ftp/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum=a3f2b91a2353b65a863c5901251efe48060ecdebec46b5eaec8ea8e092b9e871
pkg_deps=(core/glibc core/zlib)
pkg_build_deps=(core/gcc core/make core/diffutils core/which)
pkg_bin_dirs=(bin)

do_check() {
  make test
}
