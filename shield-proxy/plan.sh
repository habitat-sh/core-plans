pkg_name=shield-proxy
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Proxy package for the Shield backup and restore tool"
pkg_license=('Apache-2.0')
pkg_version=0.10.9
pkg_svc_user=root
pkg_svc_group="${pkg_svc_user}"
pkg_upstream_url=""
pkg_deps=(
  core/nginx
  core/openssl
  core/bash
)

do_build() {
  return 0
}

do_download() {
  return 0
}

do_install() {
  return 0
}
