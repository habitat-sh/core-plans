source ../postgresql95/plan.sh

pkg_name=postgresql95-client
pkg_version=9.5.6
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="PostgreSQL is a powerful, open source object-relational database system."
pkg_upstream_url="https://www.postgresql.org/"
pkg_license=('PostgreSQL')
pkg_source=https://ftp.postgresql.org/pub/source/v${pkg_version}/postgresql-${pkg_version}.tar.bz2
pkg_shasum=bb9e5f6d34e20783e96e10c1d6c0c09c31749e802aaa46b793ce2522725ae12f
pkg_dirname="postgresql-${pkg_version}"

# No exports/exposes for client
unset pkg_exports
unset pkg_exposes

do_install() {
	make -C src/bin install
	make -C src/include install
	make -C src/interfaces install
}
