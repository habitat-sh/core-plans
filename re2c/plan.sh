pkg_name=re2c
pkg_origin=core
pkg_version=1.3
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('PDDL-1.0')
pkg_upstream_url=http://re2c.org/
pkg_description="re2c is a lexer generator for C/C++."
pkg_source=https://github.com/skvadrik/${pkg_name}/releases/download/${pkg_version}/${pkg_name}-${pkg_version}.tar.xz
pkg_filename=${pkg_name}-${pkg_version}.tar.bz2
pkg_shasum=f37f25ff760e90088e7d03d1232002c2c2672646d5844fdf8e0d51a5cd75a503
pkg_deps=(core/gcc-libs)
pkg_build_deps=(core/coreutils core/diffutils core/gcc core/make)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

do_prepare() {
  # The `/usr/bin/env` path is hardcoded in tests, so we'll add a symlink since fix_interpreter won't work.
  mkdir -p /usr/bin
  if [[ ! -r /usr/bin/env ]]; then
    ln -sv "$(pkg_path_for coreutils)/bin/env" /usr/bin/env
    _clean_env=true
  fi
}

do_check() {
  make check
}

do_end() {
  # Clean up the `env` link, if we set it up.
  if [[ -n "$_clean_env" ]]; then
    rm -fv /usr/bin/env
  fi
}
