pkg_origin=core
pkg_name=rebar
pkg_version=2.6.4
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=(Apache-2.0)
pkg_source=https://github.com/${pkg_name}/${pkg_name}/archive/${pkg_version}.tar.gz
pkg_shasum=577246bafa2eb2b2c3f1d0c157408650446884555bf87901508ce71d5cc0bd07
pkg_description="rebar is an Erlang build tool that makes it easy to compile and test Erlang applications, port drivers and releases."
pkg_upstream_url="https://github.com/rebar/rebar"
pkg_deps=(core/erlang core/busybox-static)
pkg_build_deps=(core/coreutils)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

do_prepare() {
  # The `/usr/bin/env` path is hardcoded, so we'll add a symlink if needed.
  if [[ ! -r /usr/bin/env ]]; then
    ln -sv "$(pkg_path_for coreutils)/bin/env" /usr/bin/env
    _clean_env=true
  fi
}

do_build() {
  ./bootstrap
}

do_install() {
  cp -a "rebar" "${pkg_prefix}/bin/rebar"
  fix_interpreter "${pkg_prefix}/bin/"* core/busybox-static bin/env
}

do_end() {
  # Clean up the `env` link, if we set it up.
  if [[ -n "$_clean_env" ]]; then
    rm -fv /usr/bin/env
  fi
}
