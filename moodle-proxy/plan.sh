pkg_name=moodle-proxy
pkg_origin=core
pkg_version=0.1.0
pkg_shasum=undefined
pkg_source=nosuchfile.tar.xz
pkg_upstream_url="https://nginx.org/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Nginx HTTP Proxy for Moodle"
pkg_license=('Apache-2.0')

pkg_deps=(core/nginx core/coreutils core/bash)
pkg_svc_run="nginx -c ${pkg_svc_config_path}/nginx.conf"
pkg_svc_user="root"
pkg_svc_group=$pkg_svc_user

# Note: exported key 'port' (with value server.listen) is only used to allow
# pkg_exposes to reference this key. In turn pkg_exposes is used if this
# package is to be exported to a Docker container
# the configuration settings below apply only if you use docker
pkg_exports=([port]=server.listen)
pkg_exposes=(port)

do_verify() {
  return 0
}

do_begin() {
  return 0
}

do_build() {
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
