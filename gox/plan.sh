pkg_origin=core
pkg_name=gox
pkg_version=0.4.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="A dead simple, no frills Go cross compile tool"
pkg_license=("MPL-2.0")
pkg_upstream_url=https://github.com/mitchellh/gox
pkg_source=https://github.com/mitchellh/gox

pkg_scaffolding=core/scaffolding-go
scaffolding_go_build_deps=(
  github.com/mitchellh/iochan # AKA Leftpad of the Go world
  github.com/hashicorp/go-version
)

pkg_build_deps=(
	core/cacerts
)

pkg_bin_dirs=(bin)

do_setup_environment() {
  push_buildtime_env SSL_CERT_FILE "$(pkg_path_for core/cacerts)/ssl/certs/cacert.pem"
}

do_clean() {
  pushd "$scaffolding_go_pkg_path" >/dev/null
    go mod tidy -v
    go mod vendor -v
  popd >/dev/null
  do_default_clean
}
