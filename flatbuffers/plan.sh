pkg_name=flatbuffers
pkg_origin=core
pkg_version=1.4.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_description="$(cat << EOF
  FlatBuffers is an efficient cross platform serialization library for C++,
  C#, C, Go, Java, JavaScript, PHP, and Python. It was originally created at
  Google for game development and other performance-critical applications.
EOF
)"
pkg_source="https://github.com/google/${pkg_name}/archive/v${pkg_version}.tar.gz"
pkg_shasum="d3355f0adcc16054afcce4a3eac90b9c26f926be9a65b2e158867f56ab689e63"
pkg_upstream_url="http://google.github.io/flatbuffers/index.html"

pkg_deps=(
  core/glibc
  core/gcc-libs
)

pkg_build_deps=(
  core/make
  core/gcc
  core/cmake
)

pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

do_build() {
  export LD_LIBRARY_PATH
  LD_LIBRARY_PATH="$(pkg_path_for gcc)/lib"
  build_line "Setting LD_LIBRARY_PATH=$LD_LIBRARY_PATH"

  cmake -G "Unix Makefiles" \
        -DCMAKE_INSTALL_PREFIX="$pkg_prefix" \
        -DCMAKE_CXX_FLAGS="$CXXFLAGS"
  make
}

do_check() {
  ./flattests
}
