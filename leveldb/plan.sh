pkg_name=leveldb
pkg_origin=core
pkg_description="LevelDB is a fast key-value storage library written at Google that provides an ordered mapping from string keys to string values."
pkg_upstream_url="https://github.com/google/leveldb"
pkg_version="1.23"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('BSD-3-Clause')
pkg_source="https://github.com/google/leveldb/archive/v${pkg_version}.tar.gz"
pkg_shasum="9ccc8706561591a540ce0165041beb1b0361338a11e135a9fcff18fd5984d7c7"
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
