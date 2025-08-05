pkg_origin=core
pkg_name=luajit
pkg_version=2.0.5
pkg_description="LuaJIT is a Just-In-Time (JIT) compiler for the Lua programming language."
pkg_upstream_url=http://luajit.org/
pkg_license=("MIT")
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/LuaJIT/LuaJIT/archive/refs/tags/v${pkg_version}.tar.gz"
pkg_dirname="LuaJIT-${pkg_version}"
pkg_shasum="8bb29d84f06eb23c7ea4aa4794dbb248ede9fcb23b6989cbef81dc79352afc97"
pkg_deps=(
  core/glibc
  core/gcc-libs
)
pkg_build_deps=(
  core/gcc
  core/make
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_prepare() {
  export TARGET_CFLAGS="${CFLAGS}"
  export TARGET_LDFLAGS="${CFLAGS}"
}

do_build() {
  make
}

do_install() {
   make V=1 PREFIX="${pkg_prefix}" install
}
