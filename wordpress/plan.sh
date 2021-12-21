# This file is the heart of your application's habitat.
# See full docs at https://www.habitat.sh/docs/reference/plan-syntax/

pkg_name=wordpress
pkg_origin=core
pkg_version="4.9.18"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_source="https://wordpress.org/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="4c0349c899c036aa750818d6be4f0571af917d63f6221b9728becadb2e7798b7"
pkg_description="installs wordpress"
pkg_upstream_url="https://wordpress.org/"

source_dir=$HAB_CACHE_SRC_PATH/${pkg_name}

pkg_svc_user=root
pkg_svc_group=$pkg_svc_user

pkg_deps=(core/php core/curl core/wordpress-proxy/4.7.4 core/mysql-client)

pkg_exports=()
pkg_exposes=()

pkg_binds=(
  [database]="port username password"
)


do_build(){
  return 0
}

do_install() {
  cp -r "$source_dir" "$pkg_prefix/public_html/"
}
