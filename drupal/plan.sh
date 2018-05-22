pkg_name=drupal
pkg_origin=core
pkg_version="8.5.3"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Apache-2.0")
pkg_source="https://ftp.drupal.org/files/projects/$pkg_name-$pkg_version.tar.gz"
pkg_shasum="7fc105f9e04ac5ccd337ff784aeaba6b48841490d7a80fd8ddb002fac0def47b"
pkg_deps=(core/nginx)
pkg_binds=(
  [php]="port local_only"
)
pkg_svc_user="root"

do_build() {
  return 0
}

do_install() {
  cp -r "$CACHE_PATH" "$pkg_prefix/drupal"
}
