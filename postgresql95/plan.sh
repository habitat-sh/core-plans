# shellcheck disable=SC2148,SC1091
source ../postgresql/plan.sh

pkg_name=postgresql95
pkg_version=9.5.13
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="PostgreSQL is a powerful, open source object-relational database system."
pkg_upstream_url="https://www.postgresql.org/"
pkg_license=('PostgreSQL')
pkg_source="https://ftp.postgresql.org/pub/source/v${pkg_version}/postgresql-${pkg_version}.tar.bz2"
pkg_shasum="5408b86a0b56fd0140c6a0016bf9179bc7817fa03d5571cca346c9ab122ea5ee"
pkg_dirname="postgresql-${pkg_version}"

# Copy service files (hooks, config, default.toml) from the postgresql plan
do_begin() {
  _copy_service_files
}

# Cleanup from our workaround in `do_begin`
do_end() {
  _cleanup_copied_service_files
}
