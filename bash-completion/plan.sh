pkg_name=bash-completion
pkg_origin=core
pkg_version=2.11
pkg_license=("GPL-2.0")
pkg_upstream_url=https://github.com/scop/bash-completion
pkg_description="Programmable completion functions for bash"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/scop/bash-completion/releases/download/${pkg_version}/bash-completion-${pkg_version}.tar.xz"
pkg_shasum=f13188a0f324d774f375f0e4c4894e87b61aedcb914e1147c9b2b372c8970fc0
pkg_deps=(
  core/bash
)
pkg_build_deps=(
  core/gcc
  core/make
)
