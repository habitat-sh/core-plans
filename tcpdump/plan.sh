pkg_name=tcpdump
pkg_origin=core
pkg_version=4.9.0
pkg_description="A powerful command-line packet analyzer."
pkg_upstream_url="http://www.tcpdump.org/"
pkg_license=('BSD')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=http://www.tcpdump.org/release/tcpdump-${pkg_version}.tar.gz
pkg_shasum=eae98121cbb1c9adbedd9a777bf2eae9fa1c1c676424a54740311c8abcee5a5e
# core/coreutils isn't /really/ needed at runtime, but fix_interpreter
# only works if the dep is listed in pkg_deps
pkg_deps=(core/glibc core/libpcap core/openssl core/coreutils)
pkg_build_deps=(core/gcc core/make core/perl core/diffutils)
pkg_bin_dirs=(sbin)

do_build() {
  ./configure --prefix="$pkg_prefix" --with-crypto
  make -j "$(nproc)"
}

do_check() {
  fix_interpreter "tests/TESTonce" core/coreutils bin/env
  make check
}
