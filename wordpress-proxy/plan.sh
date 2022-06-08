pkg_name=wordpress-proxy
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_version=4.9.18
pkg_description="nginx wordpress proxy"
pkg_upstream_url="https://nginx.org/"
pkg_svc_user=root
pkg_svc_group=$pkg_svc_user
pkg_deps=(core/nginx)

do_build() {
  return 0
}

do_download() {
  return 0
}

do_install() {
  return 0
}
