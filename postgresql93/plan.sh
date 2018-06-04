# shellcheck disable=SC2148,SC1091
source ../postgresql/plan.sh

pkg_name=postgresql93
pkg_version=9.3.23
pkg_source="https://ftp.postgresql.org/pub/source/v${pkg_version}/postgresql-${pkg_version}.tar.bz2"
pkg_shasum="1d981006dce3851e470b038e88bf496a80813c614c2e89ed7d2c7fb38e66f6cb"
pkg_dirname="postgresql-${pkg_version}"
