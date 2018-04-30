source ../postgresql/plan.sh

pkg_name=postgresql-client
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="PostgreSQL is a powerful, open source object-relational database system."
pkg_upstream_url="https://www.postgresql.org/"
pkg_license=('PostgreSQL')
pkg_filename="postgresql-${pkg_version}.tar.bz2"
pkg_dirname="postgresql-${pkg_version}"

# No exports/exposes for client
unset pkg_exports
unset pkg_exposes

do_install() {
	make -C src/bin install
	make -C src/include install
	make -C src/interfaces install
}
