pkg_name=restic
pkg_origin=core
pkg_version="0.12.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("BSD-2-Clause")
pkg_source="https://github.com/restic/${pkg_name}/releases/download/v${pkg_version}/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="39b615a36a5082209a049cce188f0654c6435f0bc4178b7663672334594f10fe"
pkg_build_deps=(
  core/go
)
pkg_bin_dirs=(bin)
pkg_description="Fast, secure, efficient backup program"
pkg_upstream_url="https://restic.net/"

do_build() {
  go run build.go --goos linux --goarch amd64
}

do_install() {
  cp -v restic "${pkg_prefix}/bin/restic"
}
