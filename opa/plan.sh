pkg_name=opa
pkg_description="Open Policy Agent (OPA) is a lightweight general-purpose policy engine that can be co-located with your service."
pkg_origin=core
pkg_version="0.27.1"
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
pkg_deps=(
    core/gcc
)
pkg_shasum=d1f3cee2261adc83df54fba2d62b045549d064ac14b7683031ec3897c2bdbd44

do_prepare() {
  sed -e "s#\#\!/usr/bin/env bash#\#\!$(pkg_path_for bash)/bin/bash#" -i build/*.sh
  sed -e "s#hostname -f#echo \"bldr.habitat.sh\"#" -i build/get-build-hostname.sh
}

do_build() {
    return 0
}

do_install() {
  build_line "copying binary: $pwd"
  make build BIN="${pkg_prefix}/bin/opa" BUILD_COMMIT="" VERSION="${pkg_version}"
}
