pkg_name=apr-util
pkg_origin=core
pkg_version=1.6.1
pkg_license=('Apache-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Apache Portable Runtime util"
pkg_upstream_url="https://apr.apache.org/"
pkg_source=https://archive.apache.org/dist/apr/${pkg_name}-${pkg_version}.tar.bz2
pkg_shasum=d3e12f7b6ad12687572a3a39475545a072608f4ba03a6ce8a3778f607dd0035b
pkg_deps=(core/gcc-libs core/glibc core/apr core/expat)
pkg_build_deps=(core/gcc core/make)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_build() {
  ./configure --prefix="${pkg_prefix}" \
              --with-apr="$(pkg_path_for core/apr)" \
              --with-expat="$(pkg_path_for core/expat)"
  make
}
