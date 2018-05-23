pkg_name=drupal-app
pkg_origin=core
pkg_version="7.1.4"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("PHP-3.01")
pkg_deps=(core/php)
pkg_svc_run="php-fpm --fpm-config ${pkg_svc_config_path}/php-fpm.conf -c ${pkg_svc_config_path}"
pkg_exports=(
  [port]=port
  [local_only]=local_only
)
pkg_description="PHP is a popular general-purpose scripting language that is especially suited to web development."
pkg_upstream_url="http://php.net"

do_build() {
  return 0
}

do_install() {
  return 0
}
