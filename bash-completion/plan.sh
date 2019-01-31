pkg_name=bash-completion
pkg_origin=core
pkg_version=2.8
pkg_license=('GPL-2.0')
pkg_upstream_url="https://github.com/scop/bash-completion"
pkg_description="Programmable completion functions for bash"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/scop/bash-completion/releases/download/${pkg_version}/bash-completion-${pkg_version}.tar.xz"
pkg_shasum="c01f5570f5698a0dda8dc9cfb2a83744daa1ec54758373a6e349bd903375f54d"
pkg_deps=(
  core/bash
)
pkg_build_deps=(
  core/gcc
  core/make
)
