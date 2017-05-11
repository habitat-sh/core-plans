pkg_name=scaffolding-node
pkg_origin=core
pkg_version="0.1.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_build_deps=(chef/inspec)
pkg_deps=(core/git core/tar)
pkg_upstream_url=https://github.com/habitat-sh/core-plans/tree/master/scaffolding-node
pkg_scaffolding=core/scaffolding-base

do_install() {
  do_default_install
  install -m 0644 lib/packageJsonParser.js "$pkg_prefix/lib/packageJsonParser.js"
}
