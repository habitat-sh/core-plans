pkg_name=cppcheck
pkg_origin=core
pkg_version=1.90
pkg_description="static analysis of C/C++ code"
pkg_upstream_url="http://cppcheck.sourceforget.net"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("GPL-3.0")
pkg_source="https://github.com/danmar/cppcheck/archive/${pkg_version}.tar.gz"
pkg_filename="${pkg_version}.tar.gz"
pkg_shasum=c4864d3e09359214efdd503b52e241f4f56ba7ce26f8c11939fd9dcfac1fd105
pkg_deps=(
  core/glibc
  core/gcc-libs
)
pkg_build_deps=(
  core/pkg-config
  core/cmake
  core/ninja
  core/gcc
  core/pcre
  core/patch
)
pkg_bin_dirs=(bin)

do_setup_environment() {
  export BUILDDIR="build"
}

do_prepare() {
  mkdir -p "${BUILDDIR}"
  patch -p0 < "${PLAN_CONTEXT}/glibc_SIGSTKSZ_fix.patch"
}

do_build() {
  _PCRE_PATH="$(pkg_path_for pcre)"

  pushd "${BUILDDIR}" || exit 1
pwd
  cmake \
    -DCMAKE_INSTALL_PREFIX="${pkg_prefix}" \
    -DBUILD_TESTS="${DO_CHECK}" \
    -DUSE_MATCHCOMPILER=ON \
    -DPCRE_INCLUDE="yes" \
    -DPCRE_LIBRARY="${_PCRE_PATH}/lib" \
    -G Ninja \
    ..
  ninja

  popd || exit 1
}

do_check() {
  pushd "${BUILDDIR}" || exit 1
  ctest -V
  popd || exit 1
}

do_install() {
  pushd "${BUILDDIR}" || exit 1
  ninja install
  popd || exit 1
}
