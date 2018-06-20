pkg_name=optipng
pkg_origin=core
pkg_version="0.7.7"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Zlib")
pkg_source="http://prdownloads.sourceforge.net/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="4f32f233cef870b3f95d3ad6428bfe4224ef34908f1b42b0badf858216654452"
pkg_build_deps=(
  core/make
  core/gcc
  core/zlib
)
pkg_bin_dirs=(bin)
pkg_description="OptiPNG is a PNG optimizer that recompresses image files to a smaller size, without losing any information."
pkg_upstream_url="http://optipng.sourceforge.net/"
