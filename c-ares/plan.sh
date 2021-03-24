pkg_name=c-ares
pkg_origin=core
pkg_version="1.17.1"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_upstream_url="https://c-ares.haxx.se/"
pkg_description="A C library for asynchronous DNS requests"
pkg_source="https://github.com/c-ares/c-ares/archive/cares-1_17_1.tar.gz"
pkg_shasum=b263e31fe422251eb0fdc1c777fb5b2cb11a363d1270b52258615ea7c7006425
pkg_dirname="c-ares-cares-1_15_0"
pkg_deps=(
  core/glibc
  core/gcc-libs
)
pkg_build_deps=(
  core/coreutils
  core/busybox-static
  core/diffutils
  core/file
  core/gcc
  core/cmake
  core/ninja
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_begin() {
  export HAB_ENV_CMAKE_FIND_ROOT_PATH_SEPARATOR=";"
  export HAB_ENV_CMAKE_FIND_ROOT_PATH_TYPE="aggregate"
}

do_setup_environment() {
  set_buildtime_env BUILDDIR "build"

  # this allows cmake users to utilize `CMAKE_FIND_ROOT_PATH` to find various cmake configs
  push_runtime_env CMAKE_FIND_ROOT_PATH "${pkg_prefix}/lib/cmake/c-ares"
}

do_prepare() {
  mkdir -p "${BUILDDIR}"
}

do_build() {
  pushd "${BUILDDIR}" || exit 1
    cmake \
    -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
    -DCARES_STATIC="ON" \
    -DCARES_INSTALL="ON" \
    -DCARES_BUILD_TESTS="${DO_CHECK}" \
    -DCARES_BUILD_TOOLS="ON" \
    -G "Ninja" \
    ..
  ninja -j"$(nproc --ignore=1)"
  popd || exit 1
}

do_check() {
  pushd "${BUILDDIR}" || exit 1
  CTEST_OUTPUT_ON_FAILURE=1 ctest -R aresfuzz

  # TODO(bdangit): disabled 2 types of tests:
  #  1. Live Testing: requires access to the internet.
  #  2. MockChannelTest.HostAliasUnreadable: seg faults and would require extensive deepdive
  #     with a debugger.
  ./bin/arestest -4 --gtest_filter=-*.Live*:AddressFamilies/MockChannelTest.HostAliasUnreadable*

  if ifconfig | grep -q 'inet6'
  then
    build_line "HAS IPV6"
    ./bin/arestest -6 --gtest_filter=-*.Live*:AddressFamilies/MockChannelTest.HostAliasUnreadable*
  fi

  popd || exit 1
}

do_install() {
  pushd "${BUILDDIR}" || exit 1
  ninja install
  popd || exit 1
}
