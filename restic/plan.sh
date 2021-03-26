pkg_name=restic
pkg_origin=core
pkg_version="0.12.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("BSD-2-Clause")
pkg_source="https://github.com/restic/${pkg_name}/releases/download/v${pkg_version}/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="d15c0ac1372d47d0a34b6e3c60dbf39ec503ad29e818f8a8f1b7f916de383c68"
pkg_build_deps=(
  core/go
)
pkg_bin_dirs=(bin)
pkg_description="Fast, secure, efficient backup program"
pkg_upstream_url="https://restic.net/"

do_build() {
  GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -mod=vendor -ldflags "-s -w" -tags selfupdate -o restic_linux_amd64 ./cmd/restic
}

do_install() {
  cp -v restic_linux_amd64 "${pkg_prefix}/bin/restic"
}
