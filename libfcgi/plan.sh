pkg_name=libfcgi
pkg_origin=core
pkg_version="2.4.2"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("custom")
pkg_description="FastCGI is a language independent, scalable, open extension to CGI that provides high performance without the limitations of server specific APIs."
pkg_upstream_url="https://directory.fsf.org/wiki/Libfcgi"
pkg_source="http://ftp.debian.org/debian/pool/main/${pkg_name:0:4}/${pkg_name}/${pkg_name}_${pkg_version}.orig.tar.gz"
pkg_shasum="1fe83501edfc3a7ec96bb1e69db3fd5ea1730135bd73ab152186fd0b437013bc"
pkg_filename="${pkg_name}_${pkg_version}.orig.tar.gz"
pkg_dirname="fcgi2-${pkg_version}"
pkg_build_deps=(
  core/autoconf
  core/automake
  core/libtool
  core/m4
  core/make
  core/gcc
  core/patch
)
pkg_deps=(
  core/glibc
  core/gcc-libs
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)

do_build() {
  patch -p0 -i "${PLAN_CONTEXT}/stdio.patch"
  ACLOCAL_PATH="$ACLOCAL_PATH:$(pkg_path_for core/libtool)/share/aclocal"
  export ACLOCAL_PATH
  ./autogen.sh
  do_default_build
}

do_install() {
  do_default_install
  cp -v ./LICENSE.TERMS "${pkg_prefix}/LICENSE"
}
