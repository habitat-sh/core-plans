source "$(dirname "${BASH_SOURCE[0]}")/../haproxy/plan.sh"

pkg_name=haproxy19
pkg_origin=core
pkg_description="The Reliable, High Performance TCP/HTTP Load Balancer"
pkg_distname=haproxy
pkg_version=1.9.6
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=('GPL-2.0' 'LGPL-2.1')
pkg_source="https://www.haproxy.org/download/1.9/src/${pkg_distname}-${pkg_version}.tar.gz"
pkg_shasum=0837c35e2914d40f685740487886e86b1b16132b81ecb60a3be66cf9a6f19bef
pkg_dirname="${pkg_distname}-${pkg_version}"
pkg_upstream_url="https://www.haproxy.org/"
pkg_build_deps=(
  core/coreutils
  core/gcc
  core/pcre
  core/make
  core/openssl
  core/zlib
  core/diffutils
)
