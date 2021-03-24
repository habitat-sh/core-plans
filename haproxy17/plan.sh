source "$(dirname "${BASH_SOURCE[0]}")/../haproxy19/plan.sh"

pkg_name=haproxy17
pkg_origin=core
pkg_description="The Reliable, High Performance TCP/HTTP Load Balancer"
pkg_distname=haproxy
pkg_version=1.7.13
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=('GPL-2.0' 'LGPL-2.1')
pkg_source="https://www.haproxy.org/download/1.7/src/${pkg_distname}-${pkg_version}.tar.gz"
pkg_shasum=53ae3ae722236a56cc8b584bf1f8ef422fc40e9ce032d244e256c486c1713600
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
