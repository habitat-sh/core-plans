source "$(dirname "${BASH_SOURCE[0]}")/../haproxy19/plan.sh"

pkg_name=haproxy17
pkg_origin=core
pkg_description="The Reliable, High Performance TCP/HTTP Load Balancer"
pkg_distname=haproxy
pkg_version=1.7.14
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=('GPL-2.0' 'LGPL-2.1')
pkg_source="https://www.haproxy.org/download/1.7/src/${pkg_distname}-${pkg_version}.tar.gz"
pkg_shasum=1f9fb6c5a342803037a622c7dd04702b0d010a88b5c3922cd3da71a34f3377a4
pkg_dirname="${pkg_distname}-${pkg_version}"
pkg_upstream_url="https://www.haproxy.org/"
pkg_build_deps=(
  core/coreutils
  core/gcc
  core/pcre
  core/make
  core/openssl
  core/zlib
)
