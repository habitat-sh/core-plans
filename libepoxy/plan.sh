pkg_name=libepoxy
pkg_origin=core
pkg_version=1.5.5
pkg_description="Epoxy is a library for handling OpenGL function pointer management for you"
pkg_upstream_url="https://github.com/anholt/libepoxy"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_source="https://github.com/anholt/${pkg_name}/releases/download/${pkg_version}/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum=412b7f359da4ae15ebbda8776e853be6bb8831151917756dd1666962fc8ab239
pkg_deps=(
  core/glibc
  core/libdrm # not linked to bins/libs
  core/libxau # not linked to bins/libs
  core/libxcb # not linked to bins/libs
  core/libxdamage # not linked to bins/libs
  core/libxdmcp # not linked to bins/libs
  core/libxext # not linked to bins/libs
  core/libxfixes # not linked to bins/libs
  core/mesa # not linked to bins/libs
  core/xlib # not linked to bins/libs
)
pkg_build_deps=(
  core/damageproto
  core/fixesproto
  core/gcc
  core/kbproto
  core/libpthread-stubs
  core/meson
  core/ninja
  core/pkg-config
  core/python
  core/xextproto
  core/xproto
)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_build() {
  mkdir _build
  pushd _build > /dev/null
    meson --prefix="$pkg_prefix" \
      --buildtype release
    ninja
  popd > /dev/null
}

do_install() {
  pushd _build > /dev/null
    ninja install
  popd > /dev/null
}
