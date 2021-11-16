pkg_name=restic
pkg_origin=core
pkg_version="0.12.1"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("BSD-2-Clause")
pkg_source="https://github.com/restic/${pkg_name}/releases/download/v${pkg_version}/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="a9c88d5288ce04a6cc78afcda7590d3124966dab3daa9908de9b3e492e2925fb"
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
