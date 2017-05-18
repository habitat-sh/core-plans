pkg_name=luajit
pkg_origin=core
pkg_version="2.0.5"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_source="http://luajit.org/download/LuaJIT-$pkg_version.tar.gz"
pkg_dirname="LuaJIT-$pkg_version"
pkg_shasum="874b1f8297c697821f561f9b73b57ffd419ed8f4278c82e05b48806d30c1e979"
pkg_deps=(
  core/gcc-libs
  core/glibc
)
pkg_build_deps=(
  core/gcc
  core/make
  core/sed
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)
pkg_description="a Just-In-Time Compiler for Lua."
pkg_upstream_url="http://luajit.org/"

do_prepare() {
  sed -i "s^export PREFIX=.*$^export PREFIX=$pkg_prefix^" "$CACHE_PATH/Makefile"
}

do_build() {
  make
}
