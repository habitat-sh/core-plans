source "$(dirname "${BASH_SOURCE[0]}")/../haproxy/plan.sh"

pkg_name=haproxy19
pkg_origin=core
pkg_description="The Reliable, High Performance TCP/HTTP Load Balancer"
pkg_distname=haproxy
pkg_version=1.9.8
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=('GPL-2.0' 'LGPL-2.1')
pkg_source="https://www.haproxy.org/download/1.9/src/${pkg_distname}-${pkg_version}.tar.gz"
pkg_shasum=2d9a3300dbd871bc35b743a83caaf50fecfbf06290610231ca2d334fd04c2aee
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
