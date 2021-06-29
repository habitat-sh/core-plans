pkg_origin=core
pkg_name=libpipeline
pkg_version=1.5.3
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-3.0-or-later')
pkg_description="libpipeline is a C library for manipulating pipelines of subprocesses in a flexible and convenient way."
pkg_upstream_url=http://libpipeline.nongnu.org/
pkg_source="http://download.savannah.gnu.org/releases/libpipeline/libpipeline-${pkg_version}.tar.gz"
pkg_shasum=5dbf08faf50fad853754293e57fd4e6c69bb8e486f176596d682c67e02a0adb0
pkg_deps=(core/glibc)
pkg_build_deps=(
  core/gcc
  core/coreutils
  core/make
  core/diffutils
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

do_prepare() {
  export CFLAGS="${CFLAGS} -O2 -fstack-protector-strong -Wformat -Werror=format-security "
  export CXXFLAGS="${CXXFLAGS} -O2 -fstack-protector-strong -Wformat -Werror=format-security "
  export CPPFLAGS="${CPPFLAGS} -Wdate-time"
  export LDFLAGS="${LDFLAGS} -Wl,-Bsymbolic-functions -Wl,-z,relro"
}

do_build () {
  ./configure \
  --prefix="${pkg_prefix}" \
  --disable-silent-rules \
  --enable-largefile \
  --enable-threads=posix

  make -j "$(nproc)"
}

do_check () {
  make check
}

do_install() {
  make install
  make installcheck
}
