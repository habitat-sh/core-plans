pkg_name=zeromq
pkg_origin=core
pkg_version=4.2.2
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="ZeroMQ core engine in C++, implements ZMTP/3.0"
pkg_upstream_url=http://zeromq.org
pkg_license=('LGPL')
pkg_source=https://github.com/zeromq/libzmq/releases/download/v${pkg_version}/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=5b23f4ca9ef545d5bd3af55d305765e3ee06b986263b31967435d285a3e6df6b
pkg_deps=(core/glibc core/gcc-libs core/libsodium)
pkg_build_deps=(core/gcc core/coreutils core/make core/pkg-config core/patchelf)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_install() {
  do_default_install
    # shellcheck disable=SC2038
  find "$pkg_prefix/lib" -name "*.so" | xargs -I '%' patchelf --set-rpath "$LD_RUN_PATH" %
}
