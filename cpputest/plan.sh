pkg_name=cpputest
pkg_origin=core
pkg_version="3.8"
pkg_description="$(cat << EOF
  CppUTest is a C/C++ based unit xUnit test framework for unit testing and for test-driving your
  code. It is written in C++ but is used in C and C++ projects and frequently used in embedded
  systems but it works for any C/C++ project.
EOF
)"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('bsd-3-clause')
pkg_source="https://github.com/cpputest/${pkg_name}/archive/v${pkg_version}.tar.gz"
pkg_shasum="2b95bb4a568f680cdcca678345a2c41c028275471c2ed7bf0b6f6f1f689c3b76"
pkg_upstream_url="http://cpputest.github.io"
pkg_deps=(
  core/gcc-libs
  core/glibc
  core/libtool
)
pkg_build_deps=(
  core/cmake
  core/gcc
  core/m4
  core/make
  core/pkg-config
  core/valgrind
)
pkg_bin_dirs=(sbin)

do_build() {
  pushd cpputest_build > /dev/null
  cmake \
    -DCMAKE_INSTALL_PREFIX="${pkg_prefix}" \
   ..
  make
  popd > /dev/null
}

do_check() {
  pushd cpputest_build > /dev/null
  make test
  popd > /dev/null
}

do_install() {
  pushd cpputest_build > /dev/null
  make install
  install -Dm644 ../COPYING "${pkg_prefix}/share/licenses/license.txt"
  popd > /dev/null
}
