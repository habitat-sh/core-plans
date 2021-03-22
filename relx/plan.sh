pkg_origin=core
pkg_name=relx
pkg_version=3.33.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="A release assembler for Erlang."
pkg_license=(Apache-2.0)
pkg_source=https://github.com/erlware/${pkg_name}/archive/v${pkg_version}.tar.gz
pkg_upstream_url="https://github.com/erlware/relx"
pkg_shasum=0f43b6cd1e3941634e75eb7b6241e1d3b18ccad4c2f8652475f3a388c24cfd87
pkg_deps=(core/erlang core/coreutils)
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
  fix_interpreter "${pkg_prefix}"/bin/relx core/coreutils bin/env
}
