pkg_name=lsyncd
pkg_origin=core
pkg_version=2.2.3
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0')
pkg_source="https://github.com/axkibe/$pkg_name/archive/release-$pkg_version.tar.gz"
pkg_dirname="$pkg_name-release-$pkg_version"
pkg_shasum="4423d107041a62f23d7d0eda195f990161983d6f6a09e2f1f42998c38570c65c"
pkg_deps=(core/glibc)
pkg_build_deps=(
  core/cmake
  core/gcc
  core/lua
  core/make
)
pkg_bin_dirs=(bin)
pkg_description="Lsyncd watches a local directory trees event monitor interface (inotify or fsevents)"
pkg_upstream_url="https://axkibe.github.io/lsyncd/"

do_build() {
  cmake \
    -DLUA_LIBRARIES="lua -ldl -lm" \
    -DLUA_INCLUDE_DIR="$(pkg_path_for lua)/include" \
    -DCMAKE_INSTALL_PREFIX:PATH="$pkg_prefix" \
    .
  make
}
