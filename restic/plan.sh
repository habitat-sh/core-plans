pkg_name=restic
pkg_origin=core
pkg_version="0.16.2"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("BSD-2-Clause")
pkg_source="https://github.com/restic/${pkg_name}/releases/download/v${pkg_version}/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="88165b5b89b6064df37a9964d660f40ac62db51d6536e459db9aaea6f2b2fc11"
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
