pkg_origin=core
pkg_name=relx
pkg_version=3.23.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=(Apache-2.0)
pkg_source=https://github.com/erlware/${pkg_name}/archive/v${pkg_version}.tar.gz
pkg_shasum=55b9af46c0a2ad8f9f38cc3345ccb78d42b31f7a42ed1dce14fdedca38774441
pkg_deps=(core/erlang)
pkg_build_deps=(core/rebar3)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

do_build() {
  rebar3 update
  rebar3 escriptize
}

do_install() {
  cp -R "_build/default/"* "${pkg_prefix}"
  chmod +x "${pkg_prefix}/bin/relx"
}
