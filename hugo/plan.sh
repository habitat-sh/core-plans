pkg_name=hugo
pkg_origin=core
pkg_version="0.46"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Apache-2.0")
pkg_description="Hugo is one of the most popular open-source static site generators."
pkg_build_deps=(
  core/dep
  rakops/mage
)
pkg_bin_dirs=(bin)
pkg_source="https://github.com/gohugoio/hugo"
pkg_upstream_url="https://gohugo.io"
pkg_scaffolding="core/scaffolding-go"

scaffolding_go_build_deps=(
  github.com/magefile/mage
)

do_download() {
  scaffolding_go_download
  pushd "${scaffolding_go_pkg_path}" > /dev/null
  git reset --hard "v${pkg_version}"
  popd > /dev/null
}

do_build() {
  pushd "${scaffolding_go_pkg_path}" > /dev/null
  mage vendor
  mage install
  popd > /dev/null
}

do_install() {
  cp "${GOPATH}/bin/hugo" "${pkg_prefix}/bin/hugo"
}
