pkg_name=lsyncd
pkg_origin=core
pkg_version="2.2.1"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0')
pkg_source="https://github.com/axkibe/$pkg_name/archive/release-$pkg_version.tar.gz"
pkg_dirname="$pkg_name-release-$pkg_version"
pkg_shasum="f41969454a17f9441a9b1809bb251235631768393bf5d29ad8e8142670ae4735"
pkg_deps=(core/glibc)
pkg_build_deps=(
  core/cmake
  core/gcc
  core/lua
  core/make
  core/patch
)
pkg_bin_dirs=(bin)
pkg_description="Lsyncd watches a local directory trees event monitor interface (inotify or fsevents)"
pkg_upstream_url="https://axkibe.github.io/lsyncd/"

do_prepare() {
	# function lua_objlen is renamed to lua_rawlen in v5.2.x which makes lsyncd
	# incompatible with current version (v5.4.3) of lua
	patch -p1 < "$PLAN_CONTEXT"/compatibility_lua_v5.4.3.patch
}

do_build() {
	CFLAGS="$CFLAGS -DLUA_COMPAT_5_4"
  cmake \
    -DLUA_LIBRARIES="lua -ldl -lm" \
    -DLUA_INCLUDE_DIR="$(pkg_path_for lua)/include" \
    -DCMAKE_INSTALL_PREFIX:PATH="$pkg_prefix" \
    .
  make
}
