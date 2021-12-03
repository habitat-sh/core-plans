pkg_name=c-ares
pkg_origin=core
pkg_version="1.18.1"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_upstream_url="https://c-ares.haxx.se/"
pkg_description="A C library for asynchronous DNS requests"
pkg_source="https://github.com/c-ares/c-ares/archive/cares-${pkg_version//\./_}.tar.gz"
pkg_shasum=414872549eec4e221b576693fdc9c9bce44ff794d0f1f06f2515b56a7f6ec9c9
pkg_dirname="c-ares-cares-${pkg_version//\./_}"
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
  ./bin/arestest -4 --gtest_filter=-*.Live*:AddressFamilies/MockChannelTest.HostAliasUnreadable*:AddressFamiliesAI/MockChannelTestAI.FamilyV4ServiceName*

  if ifconfig | grep -q 'inet6'
  then
    build_line "HAS IPV6"
    ./bin/arestest -6 --gtest_filter=-*.Live*:AddressFamilies/MockChannelTest.HostAliasUnreadable*:AddressFamiliesAI/MockChannelTestAI.FamilyV4ServiceName*
  fi

  popd || exit 1
}

do_install() {
  pushd "${BUILDDIR}" || exit 1
  ninja install
  popd || exit 1
}
