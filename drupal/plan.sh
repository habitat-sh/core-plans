pkg_name=drupal
pkg_origin=core
pkg_version="8.9.13"
pkg_license=('gplv2+')
pkg_deps=(core/mysql-client core/drush core/nginx core/php)
pkg_binds=(
  [database]="port username password"
)
pkg_svc_user="root"
pkg_svc_run="php-fpm --nodaemonize"
pkg_description="Drupal is a free and open source content-management framework written in PHP."
pkg_upstream_url="https://www.drupal.org"
pkg_maintainers="The Habitat Maintainers <humans@habitat.sh>"

do_build() {
  drush dl drupal-8.3.2 --destination="$CACHE_PATH" --drupal-project-rename=drupal
}

do_install() {
  cp -r "$CACHE_PATH/drupal" "$pkg_prefix/drupal"
}
