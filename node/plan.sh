pkg_name=node
pkg_origin=core
pkg_version=5.6.0
pkg_description="Node.js® is a JavaScript runtime built on Chrome's V8 JavaScript engine."
pkg_upstream_url=https://nodejs.org/
pkg_license=('MIT')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://nodejs.org/dist/v${pkg_version}/${pkg_name}-v${pkg_version}.tar.gz
# the archive contains a 'v' version # prefix, but the default value of
# pkg_version is node-4.2.6 (without the v). This tweak makes build happy
pkg_dirname=node-v${pkg_version}
pkg_shasum=3af2cc5e5970afc83e59f2065fea2e2df846a544a100cd3c0527f0db05bec27f
pkg_deps=(core/glibc core/gcc-libs)
pkg_build_deps=(core/coreutils core/python2 core/gcc core/make)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_interpreters=(bin/node)
pkg_lib_dirs=(lib)

do_prepare() {
  # The `/usr/bin/env` path is hardcoded, so we'll add a symlink if needed.
  # We can't do fix_interpreter here without adding a coreutils runtime dep.
  if [[ ! -r /usr/bin/env ]]; then
    ln -sv "$(pkg_path_for coreutils)/bin/env" /usr/bin/env
    _clean_env=true
  fi
}

do_build() {
  # use --without-snapshot, because https://github.com/nodejs/node/issues/4212
  ./configure --prefix="$pkg_prefix" --without-snapshot
  make
}

do_install() {
  do_default_install

  # Node produces a lot of scripts that hardcode `/usr/bin/env`, so we
  # need to fix that everywhere to point directly at the node binary. There is
  # no other good reason to add the env indirection trick on these shebangs.
  grep -nrlI '^\#\!/usr/bin/env' "$pkg_prefix" | while read -r target; do
    sed -e "s#\#\!/usr/bin/env node#\#\!${pkg_prefix}/bin/node#" -i "$target"
  done
}

do_end() {
  # Clean up the `env` link, if we set it up.
  if [[ -n "$_clean_env" ]]; then
    rm -fv /usr/bin/env
  fi
}
