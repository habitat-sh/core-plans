pkg_name=opa
pkg_description="Open Policy Agent (OPA) is a lightweight general-purpose policy engine that can be co-located with your service."
pkg_origin=core
pkg_version="0.21.1"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Apache-2.0")
pkg_source="https://github.com/open-policy-agent/opa/archive/v${pkg_version}.tar.gz"
pkg_upstream_url="https://www.openpolicyagent.org/"
pkg_exports=(
  [address]=service.address
)
pkg_bin_dirs=(bin)
pkg_build_deps=(
    core/bash
    core/make
    core/git
    core/go
)
pkg_shasum="87813ab618fd465c6becfd4bb32c2461257d80e5ddd6eb13de0a27a195a4cccf"

do_prepare() {
  sed -e "s#\#\!/usr/bin/env bash#\#\!$(pkg_path_for bash)/bin/bash#" -i build/*.sh
  sed -e "s#hostname -f#echo \"bldr.habitat.sh\"#" -i build/get-build-hostname.sh
}

do_build() {
    return 0
}

do_install() {
  build_line "copying binary: $pwd"
  make build BIN="${pkg_prefix}/bin/opa" CGO_ENABLED=0 BUILD_COMMIT="" VERSION="${pkg_version}"
}
