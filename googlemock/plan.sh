pkg_name=googlemock
pkg_origin=core
pkg_version="1.11.0"
pkg_description="$(cat << EOF
The Google C++ mocking framework.
EOF
)"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('bsd-3-clause')
pkg_source="https://github.com/google/googletest/archive/release-${pkg_version}.tar.gz"
pkg_shasum=b4870bf121ff7795ba20d20bcdd8627b8e088f2d1dab299a031c1034eddc93d5
pkg_upstream_url="https://github.com/google/googletest/tree/master/googlemock"
pkg_dirname="googletest-release-${pkg_version}"

pkg_deps=(
  core/gcc-libs
  core/glibc
)
pkg_build_deps=(
  core/cmake
  core/gcc
  core/make
)

pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

BUILDDIR="build"

do_prepare() {
  export GTEST_TARGET="${pkg_name}"
  build_line "Plan Setting GTEST_TARGET=${GTEST_TARGET}"

  mkdir "${BUILDDIR}" || true
  mkdir "${BUILDDIR}/${GTEST_TARGET}" || true
}

do_build() {
  cd "${BUILDDIR}/${GTEST_TARGET}" || exit
  cmake -Dgtest_build_samples="${DO_CHECK}" \
      -Dgmock_build_samples="${DO_CHECK}" \
      -Dgtest_build_tests="${DO_CHECK}" \
      -Dgmock_build_tests="${DO_CHECK}" \
      -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
      "../../"
  make
}

do_check() {
  cd "${BUILDDIR}/${GTEST_TARGET}" || exit
  CTEST_OUTPUT_ON_FAILURE=1 make test
}

do_install() {
  #cd "${BUILDDIR}/${GTEST_TARGET}" || exit
  #make install
  #cd ../.. || exit

  install -Dm644 LICENSE "${pkg_prefix}/share/licenses/license.txt"

  mkdir -p "${pkg_prefix}/lib/pkgconfig"
  cat <<EOF > "${pkg_prefix}/lib/pkgconfig/libgmock.pc"
Name: libgmock
Description: ${pkg_description}
Version: ${pkg_version}
Cflags: -I${pkg_prefix}/include/gmock
Libs: -L${pkg_prefix}/lib -lgmock -lgmock_main
EOF
}
