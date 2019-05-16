pkg_name=haproxy
pkg_origin=smartb
pkg_description="The Reliable, High Performance TCP/HTTP Load Balancer"
pkg_version=1.9.6
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=('GPL-2.0' 'LGPL-2.1')
pkg_source="https://www.haproxy.org/download/1.9/src/haproxy-${pkg_version}.tar.gz"
pkg_upstream_url="https://www.haproxy.org/"
pkg_shasum=0837c35e2914d40f685740487886e86b1b16132b81ecb60a3be66cf9a6f19bef
pkg_svc_run='haproxy -f config/haproxy.conf -db'
pkg_svc_user=root
pkg_svc_group=root
pkg_exports=(
  [port]=front-end.port
  [status-port]=status.port
)
pkg_exposes=(port status-port)
pkg_binds_optional=(
  [backend]="port"
  [tls_certificates]="domain fullchain privkey"
)
pkg_deps=(core/zlib core/pcre core/openssl)
pkg_build_deps=(
  core/coreutils
  core/gcc
  core/pcre
  core/make
  core/openssl
  core/zlib
  core/diffutils
)
pkg_bin_dirs=(bin)

do_build() {
  make USE_PCRE=1 \
       USE_PCRE_JIT=1 \
       TARGET=linux2628 \
       USE_OPENSSL=1 \
       USE_ZLIB=1 \
       USE_GETADDRINFO=1 \
       ADDINC="${CFLAGS}" \
       ADDLIB="${LDFLAGS}"
}

do_install() {
  mkdir -p "${pkg_prefix}"/bin
  cp haproxy "${pkg_prefix}"/bin
}
