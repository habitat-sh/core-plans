pkg_name=scaffolding-python2
pkg_description="Scaffolding for Python Applications"
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_version="0.2.0"
pkg_license=('Apache-2.0')
pkg_source=nosuchfile.tar.gz
pkg_upstream_url="https://github.com/habitat-sh/core-plans"
pkg_deps=(
  ${pkg_deps[@]}
  core/python2
  core/make
)
pkg_scaffolding=core/scaffolding-base
