pkg_name=scaffolding-inspec
pkg_description="Scaffolding for InSpec"
pkg_origin=core
pkg_version="0.1.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_upstream_url="https://www.inspec.io"
pkg_deps=("chef/inspec" "core/cacerts")
pkg_svc_user="root"

do_download() {
    return 0;
}

do_build() {
    return 0;
}

do_install() {
    return 0;
}
