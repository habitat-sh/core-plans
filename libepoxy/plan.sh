pkg_name=libepoxy
pkg_origin=core
pkg_version=1.5.5
pkg_description="Epoxy is a library for handling OpenGL function pointer management for you"
pkg_upstream_url="https://github.com/anholt/libepoxy"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_source="https://github.com/anholt/${pkg_name}/releases/download/${pkg_version}/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum=261663db21bcc1cc232b07ea683252ee6992982276536924271535875f5b0556
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
  core/coreutils
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

do_prepare() {
  if [[ ! -r /usr/bin/env ]]; then
    ln -sv "$(pkg_path_for coreutils)/bin/env" /usr/bin/env
    _clean_env=true
  fi
}

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

do_end() {
  # Clean up the `env` link, if we set it up.
  if [[ -n "$_clean_env" ]]; then
    rm -fv /usr/bin/env
  fi
}
