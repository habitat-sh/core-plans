pkg_name=flatbuffers
pkg_origin=core
pkg_version=1.10.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_description="$(cat << EOF
  FlatBuffers is an efficient cross platform serialization library for C++,
  C#, C, Go, Java, JavaScript, PHP, and Python. It was originally created at
  Google for game development and other performance-critical applications.
EOF
)"
pkg_source="https://github.com/google/${pkg_name}/archive/v${pkg_version}.tar.gz"
pkg_shasum="3714e3db8c51e43028e10ad7adffb9a36fc4aa5b1a363c2d0c4303dd1be59a7c"
pkg_upstream_url="http://google.github.io/flatbuffers/index.html"
pkg_deps=(
)
pkg_build_deps=(
  core/cmake
  core/gcc
  core/make
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib64)

do_prepare() {
  export LD_LIBRARY_PATH
  LD_LIBRARY_PATH="$(pkg_path_for gcc)/lib"
}

do_build() {
  cmake -G "Unix Makefiles" \
        -DCMAKE_INSTALL_PREFIX="$pkg_prefix" \
        -DCMAKE_CXX_FLAGS="$CXXFLAGS"
  make
}

do_check() {
  ./flattests
}
