pkg_name=gifsicle
pkg_origin=core
pkg_version=1.92
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0-only')
pkg_description="Gifsicle is a command-line tool for creating, editing, and getting information about GIF images and animations."
pkg_upstream_url="https://www.lcdf.org/gifsicle/"
pkg_source="https://www.lcdf.org/gifsicle/gifsicle-${pkg_version}.tar.gz"
pkg_shasum=5ab556c01d65fddf980749e3ccf50b7fd40de738b6df679999294cc5fabfce65
pkg_bin_dirs=(bin)
pkg_deps=(
  core/zlib
  core/glibc
)
pkg_build_deps=(
  core/zlib
  core/coreutils
  core/diffutils
  core/patch
  core/make
  core/gcc
  core/sed
  core/glibc
)
