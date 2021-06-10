source "$(dirname "${BASH_SOURCE[0]}")/../haproxy/plan.sh"

pkg_name=haproxy19
pkg_origin=core
pkg_description="The Reliable, High Performance TCP/HTTP Load Balancer"
pkg_distname=haproxy
pkg_version=1.9.16
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=('GPL-2.0' 'LGPL-2.1')
pkg_source="https://www.haproxy.org/download/1.9/src/${pkg_distname}-${pkg_version}.tar.gz"
pkg_shasum=47174becf7c641c837b7338210f6194f266de45c49a38b68655fcd980f95bdbf
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

do_build() {
  make \
    USE_PCRE=1 \
    USE_PCRE_JIT=1 \
    TARGET=linux2628 \
    USE_OPENSSL=1 \
    USE_ZLIB=1 \
    USE_GETADDRINFO=1 \
    ADDINC="${CFLAGS}" \
    ADDLIB="${LDFLAGS}"
}
