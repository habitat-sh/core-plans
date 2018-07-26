pkg_name=hugo
pkg_origin=core
pkg_version="0.45.1"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Apache-2.0")
pkg_description="Hugo is one of the most popular open-source static site generators."
pkg_source="https://github.com/gohugoio/hugo/releases/download/v${pkg_version}/hugo_${pkg_version}_Linux-64bit.tar.gz"
pkg_shasum="e10e4162d4d568b92e3c8b49efeb1fc3fd6310138dc5d7a63b86b852d37af158"
pkg_build_deps=(core/go)
pkg_bin_dirs=(bin)
pkg_upstream_url="https://gohugo.io"

do_prepare() {
  export GOPATH="${HAB_CACHE_SRC_PATH}"
}

do_build() {
  return 0
}

do_install() {
  cp "${HAB_CACHE_SRC_PATH}/hugo" "${pkg_prefix}/bin/"
}
