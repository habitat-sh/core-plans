# shellcheck disable=SC2148,SC1091
source ../postgresql/plan.sh

pkg_name=postgresql94
pkg_version=9.4.11
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="PostgreSQL is a powerful, open source object-relational database system."
pkg_upstream_url="https://www.postgresql.org/"
pkg_license=('PostgreSQL')
pkg_source=https://ftp.postgresql.org/pub/source/v${pkg_version}/postgresql-${pkg_version}.tar.bz2
pkg_shasum=e3eb51d045c180b03d2de1f0c3af9356e10be49448e966ca01dfc2c6d1cc9d23
pkg_dirname="postgresql-${pkg_version}"

# Workaround `pkg_exports` check that runs before `do_build_config`
do_prepare() {
  cp "${PLAN_CONTEXT}/../postgresql/default.toml" "${PLAN_CONTEXT}/default.toml"
}

do_build_config() {
  PLAN_CONTEXT="${PLAN_CONTEXT}/../postgresql/" do_default_build_config
}

# Cleanup from our workaround in `do_prepare`
do_end() {
  rm "${PLAN_CONTEXT}/default.toml"
  do_default_end
}
