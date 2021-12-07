pkg_origin=core
pkg_name=snappy
pkg_version=1.1.9
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('BSD-3-Clause')
pkg_source=https://github.com/google/snappy/archive/${pkg_version}.tar.gz
pkg_shasum=75c1fbb3d618dd3a0483bff0e26d0a92b495bbe5059c8b4f1c962b478b6e06e7
pkg_deps=(core/glibc)
pkg_build_deps=(
  core/cmake
  core/gcc
  core/make
  core/libtool
  core/patchelf
  core/git
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_upstream_url=https://github.com/google/snappy
pkg_description="A fast compressor/decompressor http://google.github.io/snappy/"

do_prepare() {
  git clone https://github.com/google/benchmark.git "$HAB_CACHE_SRC_PATH/$pkg_dirname/third_party/benchmark"
  git clone https://github.com/google/googletest.git "$HAB_CACHE_SRC_PATH/$pkg_dirname/third_party/googletest"
  __gcc_LD_RUN_PATH="$(pkg_path_for gcc)/LD_RUN_PATH"
  LD_RUN_PATH="${LD_RUN_PATH}:$(cat "${__gcc_LD_RUN_PATH}")"
  export LD_RUN_PATH
}

do_build () {
  libtoolize --force
  mkdir build
  pushd build &>/dev/null || exit 1
    cmake ../
    make
  popd &>/dev/null || exit 1
}

do_install() {
  return 0
}

do_check () {
  patchelf --interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" \
    --set-rpath "${LD_RUN_PATH}" "${SRC_PATH}/build/snappy_unittest"
  build/snappy_unittest
}
