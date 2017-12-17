pkg_name=bash-completion
pkg_origin=core
pkg_version=2.7
pkg_license=('GPL-2.0')
pkg_upstream_url="https://github.com/scop/bash-completion"
pkg_description="Programmable completion functions for bash"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/scop/bash-completion/releases/download/${pkg_version}/bash-completion-${pkg_version}.tar.xz"
pkg_shasum="41ba892d3f427d4a686de32673f35401bc947a7801f684127120cdb13641441e"
pkg_deps=(
  core/bash
)
pkg_build_deps=(
  core/gcc
  core/make
)
