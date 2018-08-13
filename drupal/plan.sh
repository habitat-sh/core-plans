pkg_name=drupal
pkg_origin=core
pkg_type="composite"
pkg_version="8.5.3"

pkg_services=(
  core/drupal-app
  core/drupal-http
  core/mysql
)

pkg_bind_map=(
  [core/drupal-http]="php:core/drupal-app database:core/mysql"
)
