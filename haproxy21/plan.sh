source "$(dirname "${BASH_SOURCE[0]}")/../haproxy/plan.sh"

pkg_name=haproxy21
pkg_origin=core
pkg_description="The Reliable, High Performance TCP/HTTP Load Balancer"
pkg_distname=haproxy
pkg_version=2.1.12
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=('GPL-2.0' 'LGPL-2.1')
pkg_source="https://www.haproxy.org/download/2.1/src/${pkg_distname}-${pkg_version}.tar.gz"
pkg_shasum=acebbf932f2703ee287d6e945bd845cde8c9db9a13f7cbb2a99671499c558056
pkg_dirname="${pkg_distname}-${pkg_version}"
pkg_upstream_url="https://www.haproxy.org/"
pkg_deps=(
  core/gcc-libs
  core/zlib
  core/pcre
  core/openssl
)
pkg_build_deps=(
  core/coreutils
  core/gcc
  core/make
  core/diffutils
)
