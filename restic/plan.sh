pkg_name=restic
pkg_origin=core
pkg_version="0.16.4"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("BSD-2-Clause")
pkg_source="https://github.com/restic/${pkg_name}/releases/download/v${pkg_version}/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="d736a57972bb7ee3398cf6b45f30e5455d51266f5305987534b45a4ef505f965"
pkg_build_deps=(
  core/go20
  core/cacerts
)
pkg_bin_dirs=(bin)
pkg_description="Fast, secure, efficient backup program"
pkg_upstream_url="https://restic.net/"

do_prepare() {
  set_buildtime_env "SSL_CERT_FILE" "$(pkg_path_for core/cacerts)/ssl/certs/cacert.pem"
  export SSL_CERT_FILE="$(pkg_path_for core/cacerts)/ssl/certs/cacert.pem"
}

do_build() {
  go run build.go --goos linux --goarch amd64
}

do_install() {
  cp -v restic "${pkg_prefix}/bin/restic"
}
