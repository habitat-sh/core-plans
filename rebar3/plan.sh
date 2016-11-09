pkg_origin=core
pkg_name=rebar3
pkg_version=3.1.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=(Apache-2.0)
pkg_source=https://github.com/erlang/${pkg_name}/archive/${pkg_version}.tar.gz
pkg_shasum=432fcb27f6d615655ef432f881a5e38d63fdc6e5c6584cac963d0a1391edafbd
pkg_deps=(core/erlang core/busybox-static)
pkg_build_deps=(core/coreutils)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

do_prepare() {
  fix_interpreter ./bootstrap core/busybox-static bin/env
}

do_build() {
  ./bootstrap
}

do_install() {
  cp -R _build/default/* "${pkg_prefix}"
  fix_interpreter "${pkg_prefix}/bin/*" core/busybox-static bin/env
  chmod +x "${pkg_prefix}/bin/rebar3"
}
