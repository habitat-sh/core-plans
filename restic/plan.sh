pkg_name=restic
pkg_origin=core
pkg_version="0.11.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("BSD-2-Clause")
pkg_source="https://github.com/restic/${pkg_name}/releases/download/v${pkg_version}/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="73cf434ec93e2e20aa3d593dc5eacb221a71d5ae0943ca59bdffedeaf238a9c6"
pkg_build_deps=(
  core/go
)
pkg_bin_dirs=(bin)
pkg_description="Fast, secure, efficient backup program"
pkg_upstream_url="https://restic.net/"

do_build() {
  # from https://github.com/restic/restic/blob/master/doc/developer_information.rst
  GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -ldflags "-s -w" -tags selfupdate -o restic_linux_amd64 ./cmd/restic
}

do_install() {
  cp -v restic_linux_amd64 "${pkg_prefix}/bin/restic"
}
