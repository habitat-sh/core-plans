# This file is the heart of your application's habitat.
# See full docs at https://www.habitat.sh/docs/reference/plan-syntax/

pkg_name=wordpress-proxy
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_version=4.7.4
pkg_source=nosuchfile.tar.xz
pkg_description="nginx wordpress proxy"
pkg_upstream_url="https://nginx.org/"

pkg_svc_user=root
pkg_svc_group=$pkg_svc_user

pkg_deps=(core/nginx)



do_begin() {
  return 0
}

do_build() {
  return 0
}

update_pkg_version() {
  return 0
}

do_download() {
  return 0
}

do_install() {
  return 0
}

do_prepare() {
  return 0
}

do_unpack() {
  return 0
}
