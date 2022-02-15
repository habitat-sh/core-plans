pkg_name=mage
pkg_origin=core
pkg_version=1.12.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Apache-2.0")
pkg_description="Mage is a make/rake-like build tool using Go. You write plain-old go functions, and Mage automatically uses them as Makefile-like runnable targets."
pkg_source="https://github.com/magefile/mage"
pkg_upstream_url=https://magefile.org/
pkg_scaffolding="core/scaffolding-go"
pkg_bin_dirs=(bin)

do_download() {
  scaffolding_go_download
  pushd "${scaffolding_go_pkg_path}" > /dev/null
  git reset --hard "v${pkg_version}"
  popd > /dev/null
}

do_build() {
  pushd "${scaffolding_go_pkg_path}" > /dev/null
  go run bootstrap.go
  popd > /dev/null
}

do_install() {
  cp "${GOPATH}/bin/mage" "${pkg_prefix}/bin/mage"
}
