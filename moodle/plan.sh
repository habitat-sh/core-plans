pkg_name=moodle
pkg_origin=core
pkg_version=3.3
pkg_filename="${pkg_name}-latest-${pkg_version/\./}.tgz"
pkg_dirname="moodle"
pkg_source="https://download.moodle.org/download.php/direct/stable${pkg_version/\./}/${pkg_filename}"
pkg_shasum=d567c6899eb8aa5b25091dd486c396a6032726dbe27a6319e2a809423a0008d7
pkg_upstream_url="https://www.moodle.org"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Learning platform designed to provide educators, administrators and learners with a single robust, secure and integrated system to create personalised learning environments"
pkg_license=('AGPL-3.0')

pkg_deps=(
  core/php5
  core/moodle-proxy
  core/findutils
  core/coreutils
  core/bash
  core/mysql-client
)
pkg_svc_run="php-fpm --fpm-config ${pkg_svc_config_path}/php-fpm.conf -c ${pkg_svc_config_path}"
pkg_svc_user="root"
pkg_svc_group=$pkg_svc_user

pkg_binds=(
  [database]="port username password"
)

do_build() {
  return 0
}

do_install() {
  # durig the init hook the tarball is extracted to /hab/svc/moodle/static
  cp -r . "${pkg_prefix}/moodle"
  return 0
}

do_verify() {
  return 0
}
