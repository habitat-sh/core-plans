pkg_name=lsyncd
pkg_origin=core
pkg_version=2.1.6
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0')
pkg_source="https://github.com/axkibe/$pkg_name/archive/release-$pkg_version.tar.gz"
pkg_dirname="$pkg_name-release-$pkg_version"
pkg_shasum=02c241ee71b6abb23a796ac994a414e1229f530c249b838ae72d2ef74ae0f775
pkg_deps=(core/glibc)
pkg_build_deps=(
  core/cmake
  core/gcc
  core/lua/5.1.5
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
