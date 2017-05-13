pkg_name=node
pkg_origin=core
pkg_version=6.10.3
pkg_description="Node.js® is a JavaScript runtime built on Chrome's V8 JavaScript engine."
pkg_upstream_url=https://nodejs.org/
pkg_license=('MIT')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://nodejs.org/dist/v${pkg_version}/node-v${pkg_version}.tar.gz
pkg_shasum=a8f679f595fd921305c28d126935ad59b4419ac8474a99997a31e01ab50acd3d
pkg_deps=(core/glibc core/gcc-libs core/coreutils)
pkg_build_deps=(core/python2 core/gcc core/grep core/make)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_interpreters=(bin/node)
pkg_lib_dirs=(lib)

# the archive contains a 'v' version # prefix, but the default value of
# pkg_dirname is node-${pkg_version} (without the v). This tweak makes build happy
pkg_dirname=node-v$pkg_version

do_prepare() {
  # ./configure has a shebang of #!/usr/bin/env python2. Fix it.
  fix_interpreter configure core/coreutils bin/env
}

do_install() {
  do_default_install

  # Node produces a lot of scripts that hardcode `/usr/bin/env`, so we need to
  # fix that everywhere to point directly at the env binary in core/coreutils.
  grep -l -R ^\#\!/usr/bin/env "$pkg_prefix" | while IFS= read -r f; do
    fix_interpreter "$(readlink -f "$f")" core/coreutils bin/env
  done
}
