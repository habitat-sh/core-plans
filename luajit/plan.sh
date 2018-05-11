pkg_origin=core
pkg_name=LuaJIT
pkg_version=2.0.5
pkg_description="LuaJIT is a Just-In-Time (JIT) compiler for the Lua programming language."
pkg_upstream_url="http://luajit.org/"
pkg_license=("MIT")
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://luajit.org/download/LuaJIT-${pkg_version}.tar.gz"
pkg_shasum=874b1f8297c697821f561f9b73b57ffd419ed8f4278c82e05b48806d30c1e979
pkg_deps=(core/glibc core/gcc-libs)
pkg_build_deps=(core/gcc core/make)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_prepare() {
  export TARGET_CFLAGS=${CFLAGS}
  export TARGET_LDFLAGS=${CFLAGS}
}

do_build() {
  make
}

do_install() {
   make V=1 PREFIX="${pkg_prefix}" install
}
