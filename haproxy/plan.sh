pkg_name=haproxy
pkg_derivation=chef
pkg_version=1.5.12
pkg_license=('BSD')
pkg_maintainer="Adam Jacob <adam@chef.io>"
pkg_source=http://www.haproxy.org/download/1.5/src/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=6648dd7d6b958d83dd7101eab5792178212a66c884bec0ebcd8abc39df83bb78
pkg_gpg_key=3853DA6B
pkg_binary_path=(bin)
pkg_deps=(chef/glibc chef/pcre chef/openssl chef/zlib)
pkg_service_run="bin/haproxy -f /opt/bldr/srvc/haproxy/config/haproxy.conf"
pkg_docker_build="auto"
pkg_expose=(80 443)

build() {
  make USE_PCRE=1 \
    USE_PCRE_JIT=1 \
    CPU=x86_64 \
    TARGET=linux2628 \
    USE_OPENSSL=1 \
    USE_ZLIB=1 \
    ADDINC="$CFLAGS" \
    ADDLIB="$LDFLAGS"
}

install() {
  mkdir -p $pkg_prefix/bin
  cp haproxy $pkg_prefix/bin
}

