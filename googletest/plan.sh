pkg_name=googletest
pkg_origin=core
pkg_version="1.8.0"
pkg_description="$(cat << EOF
Google C++ Testing Framework helps you write better C++ tests.
EOF
)"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('bsd-3-clause')
pkg_source="https://github.com/google/${pkg_name}/archive/release-${pkg_version}.tar.gz"
pkg_shasum="58a6f4277ca2bc8565222b3bbd58a177609e9c488e8a72649359ba51450db7d8"
pkg_upstream_url="https://github.com/google/googletest"
pkg_dirname="${pkg_name}-release-${pkg_version}"

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
      "../../${GTEST_TARGET}"
  make
}

do_check() {
  cd "${BUILDDIR}/${GTEST_TARGET}" || exit
  CTEST_OUTPUT_ON_FAILURE=1 make test
}

do_install() {
  cd "${BUILDDIR}/${GTEST_TARGET}" || exit
  make install
  cd ../.. || exit

  install -Dm644 googletest/m4/gtest.m4 "${pkg_prefix}/share/aclocal"
  install -Dm644 googletest/LICENSE "${pkg_prefix}/share/licenses/license.txt"

  mkdir -p "${pkg_prefix}/lib/pkgconfig"
  cat <<EOF > "${pkg_prefix}/lib/pkgconfig/libgtest.pc"
Name: libgtest
Description: ${pkg_description}
Version: ${pkg_version}
Cflags: -I${pkg_prefix}/include/gtest
Libs: -L${pkg_prefix}/lib -lgtest -lgtest_main
EOF
}
