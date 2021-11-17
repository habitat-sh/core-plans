pkg_name=libpcap
pkg_origin=core
pkg_version=1.10.1
pkg_description="A portable C/C++ library for network traffic capture."
pkg_upstream_url="http://www.tcpdump.org/"
pkg_license=('BSD')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://www.tcpdump.org/release/libpcap-${pkg_version}.tar.gz"
pkg_shasum=ed285f4accaf05344f90975757b3dbfe772ba41d1c401c2648b7fa45b711bdd4
pkg_deps=(core/glibc)
pkg_build_deps=(core/gcc core/make core/flex core/bison core/m4)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)
pkg_pconfig_dirs=(lib/pkgconfig)

do_build() {
  ./configure --prefix="$pkg_prefix" --with-pcap=linux
  make -j "$(nproc)"
}

do_check() {
  make tests
}
