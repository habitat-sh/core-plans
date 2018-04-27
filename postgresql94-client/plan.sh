source ../postgresql94/plan.sh

pkg_name=postgresql94-client
pkg_version=9.4.11
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="PostgreSQL is a powerful, open source object-relational database system."
pkg_upstream_url="https://www.postgresql.org/"
pkg_license=('PostgreSQL')
pkg_source=https://ftp.postgresql.org/pub/source/v${pkg_version}/postgresql-${pkg_version}.tar.bz2
pkg_shasum=e3eb51d045c180b03d2de1f0c3af9356e10be49448e966ca01dfc2c6d1cc9d23
pkg_dirname="postgresql-${pkg_version}"

# No exports/exposes for client
unset pkg_exports
unset pkg_exposes

do_install() {
	make -C src/bin install
	make -C src/include install
	make -C src/interfaces install
}
