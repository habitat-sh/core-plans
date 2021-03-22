pkg_name=mesa
pkg_origin=core
pkg_version=17.3.9
pkg_description="The Mesa 3D Graphics Library"
pkg_upstream_url="https://www.mesa3d.org"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_source="https://mesa.freedesktop.org/archive/${pkg_name}-${pkg_version}.tar.xz"
pkg_source="https://mesa.freedesktop.org/archive/older-versions/17.x/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum=c5beb5fc05f0e0c294fefe1a393ee118cb67e27a4dca417d77c297f7d4b6e479
pkg_deps=(
  core/elfutils
  core/expat
  core/gcc-libs
  core/glibc
  core/libdrm
  core/libpciaccess
  core/libxau
  core/libxcb
  core/libxdamage
  core/libxdmcp
  core/libxext
  core/libxfixes
  core/libxshmfence
  core/xlib
  core/zlib
)
pkg_build_deps=(
  core/bison
  core/damageproto
  core/diffutils
  core/dri2proto
  core/file
  core/fixesproto
  core/flex
  core/gcc
  core/glproto
  core/kbproto
  core/libpthread-stubs
  core/llvm
  core/make
  core/pkg-config
  core/python2
  core/xextproto
  core/xproto
  core/patch
)
pkg_include_dirs=(include)
pkg_lib_dirs=(
  lib
  lib/dri
)
pkg_pconfig_dirs=(lib/pkgconfig)

do_prepare() {
  if [[ ! -r /usr/bin/file ]]; then
    ln -sv "$(pkg_path_for file)/bin/file" /usr/bin/file
    _clean_file=true
  fi

  # https://patchwork.freedesktop.org/patch/214086/
  patch -p0 < "$PLAN_CONTEXT"/patches/000-llvm7-support.patch
  # https://patchwork.freedesktop.org/patch/186737/
  patch -p0 < "$PLAN_CONTEXT"/patches/001-llvm-enable-new-fast-math-flags.patch
}

do_build() {
  ./configure --prefix="$pkg_prefix" \
    --enable-gles1 \
    --enable-gles2 \
    --enable-llvm  \
    --disable-llvm-shared-libs
  make
}

do_end() {
  if [[ -n "$_clean_file" ]]; then
    rm -fv /usr/bin/file
  fi
}
