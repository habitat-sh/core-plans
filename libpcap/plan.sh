pkg_name=libpcap
pkg_origin=core
pkg_version=1.7.4
pkg_description="A portable C/C++ library for network traffic capture."
pkg_upstream_url="http://www.tcpdump.org/"
pkg_license=('BSD')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://www.tcpdump.org/release/libpcap-${pkg_version}.tar.gz"
pkg_shasum=7ad3112187e88328b85e46dce7a9b949632af18ee74d97ffc3f2b41fe7f448b0
pkg_deps=(core/glibc)
pkg_build_deps=(core/gcc core/make core/flex core/bison core/m4)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)

do_build() {
  ./configure --prefix="$pkg_prefix" --with-pcap=linux
  make -j "$(nproc)"
}

do_check() {
  make tests
}
