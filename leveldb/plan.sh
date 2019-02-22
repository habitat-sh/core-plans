pkg_name=leveldb
pkg_origin=core
pkg_description="LevelDB is a fast key-value storage library written at Google that provides an ordered mapping from string keys to string values."
pkg_upstream_url="https://github.com/google/leveldb"
pkg_version="1.20"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('BSD-3-Clause')
pkg_source="https://github.com/google/leveldb/archive/v${pkg_version}.tar.gz"
pkg_shasum="f5abe8b5b209c2f36560b75f32ce61412f39a2922f7045ae764a2c23335b6664"
pkg_deps=(
  core/snappy
  core/glibc
  core/gcc-libs
)
pkg_build_deps=(
  core/make
  core/gcc
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

do_build() {
  make
}

do_install() {
  cp --preserve=links out-shared/libleveldb.* "${pkg_prefix}/lib"
  cp -r include/leveldb "${pkg_prefix}/include"
}
