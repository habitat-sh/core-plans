gopkg="github.com/open-policy-agent/opa"
pkg_name=opa
pkg_description="Open Policy Agent (OPA) is a lightweight general-purpose policy engine that can be co-located with your service."
pkg_origin=core
pkg_version="0.14.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Apache-2.0")
pkg_source="https://$gopkg"
pkg_upstream_url="https://www.openpolicyagent.org/"
pkg_build_deps=(core/bash)
pkg_exports=(
  [address]=service.address
)
pkg_deps=()
pkg_bin_dirs=(bin)
pkg_scaffolding=core/scaffolding-go
scaffolding_go_base_path=github.com/open-policy-agent
scaffolding_go_build_deps=()

do_prepare() {
  pushd "${scaffolding_go_gopath:?}/src/${gopkg}"
    sed -e "s#\#\!/usr/bin/env bash#\#\!$(pkg_path_for bash)/bin/bash#" -i build/*.sh
    sed -e "s#hostname -f#echo \"bldr.habitat.sh\"#" -i build/get-build-hostname.sh
  popd
}

do_download() {
  # `-d`: don't let go build it, we'll have to build this ourselves
  build_line "go get -d ${gopkg}"
  go get -d "$gopkg"

  pushd "${scaffolding_go_gopath:?}/src/${gopkg}"
    build_line "checking out $pkg_version"
    git reset --hard "v${pkg_version}"
  popd
}

do_build() {
  pushd "${scaffolding_go_gopath:?}/src/${gopkg}"
    PATH="${scaffolding_go_gopath:?}/bin:$PATH" make deps build
  popd
}

do_install() {
  build_line "copying binary"
  cp "${scaffolding_go_gopath:?}/src/${gopkg}/opa_linux_amd64" "${pkg_prefix}/bin/opa"
}
