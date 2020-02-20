pkg_name=bash-completion
pkg_origin=core
pkg_version=2.9
pkg_license=('GPL-2.0')
pkg_upstream_url="https://github.com/scop/bash-completion"
pkg_description="Programmable completion functions for bash"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/scop/bash-completion/releases/download/${pkg_version}/bash-completion-${pkg_version}.tar.xz"
pkg_shasum=d48fe378e731062f479c5f8802ffa9d3c40a275a19e6e0f6f6cc4b90fa12b2f5
pkg_deps=(
  core/bash
)
pkg_build_deps=(
  core/gcc
  core/make
)
