pkg_distname=drupal
pkg_name=drupal-http
pkg_origin=core
pkg_version="8.5.3"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("gplv2+")
pkg_source="https://ftp.drupal.org/files/projects/${pkg_distname}-${pkg_version}.tar.gz"
pkg_filename="${pkg_distname}-${pkg_version}.tar.gz"
pkg_dirname="${pkg_distname}-${pkg_version}"
pkg_shasum="7fc105f9e04ac5ccd337ff784aeaba6b48841490d7a80fd8ddb002fac0def47b"
pkg_deps=(
  core/nginx
)
pkg_binds=(
  [php]="port local_only"
)
pkg_binds_optional=(
  [database]="port password username server_id"
)
pkg_svc_user="root"
pkg_description="Drupal is a free and open source content-management framework written in PHP."
pkg_upstream_url="https://www.drupal.org/"

do_build() {
  return 0
}

do_install() {
  cp -r "$CACHE_PATH" "${pkg_prefix}/drupal"
}
