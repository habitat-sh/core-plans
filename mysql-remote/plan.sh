pkg_name=mysql-remote
pkg_origin=core
pkg_version="1.0.0"
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=('MIT')
pkg_upstream_url='https://www.mysql.com/'
pkg_description='A dummy service that can be configured with an arbitrary MySQL connection to health check and provide in place of a mysql bind'
pkg_deps=(
  core/mysql-client
)


pkg_exports=(
  [host]=host
  [port]=port
  [password]=app_password
  [username]=app_username
  [server_id]=server_id
)


do_build() {
  return 0
}

do_install() {
  return 0
}
