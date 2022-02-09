source "$(dirname "${BASH_SOURCE[0]}")/../haproxy19/plan.sh"

pkg_name=haproxy16
pkg_origin=core
pkg_description="The Reliable, High Performance TCP/HTTP Load Balancer"
pkg_distname=haproxy
pkg_version=1.6.16
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=('GPL-2.0' 'LGPL-2.1')
pkg_source="https://www.haproxy.org/download/1.6/src/${pkg_distname}-${pkg_version}.tar.gz"
pkg_shasum=c129f85364aca047339f839aefe20151635bc8142e7e342a6797579b54019e11
pkg_dirname="${pkg_distname}-${pkg_version}"
pkg_upstream_url="https://www.haproxy.org/"
pkg_build_deps=(
  core/coreutils
  core/gcc
  core/pcre
  core/make
  core/openssl/1.0.2t
  core/zlib
)
