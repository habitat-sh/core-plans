pkg_name=iptables
pkg_origin=core
pkg_version=1.8.7
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0-or-later')
pkg_source="http://netfilter.org/projects/iptables/files/${pkg_name}-${pkg_version}.tar.bz2"
pkg_upstream_url="http://netfilter.org/projects/iptables"
pkg_description="iptables is the userspace command line program used to configure the \
  Linux 2.4.x and later packet filtering ruleset"
pkg_shasum=c109c96bb04998cd44156622d36f8e04b140701ec60531a10668cfdff5e8d8f0
pkg_deps=(core/glibc)
pkg_build_deps=(
  core/make
  core/gcc
  core/bison
  core/flex
)
pkg_bin_dirs=(bin sbin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

do_build() {
  ./configure \
    --prefix="${pkg_prefix}" \
    --enable-devel \
    --disable-static \
    --enable-shared \
    --enable-libipq \
    --disable-nftables \
    --with-xtlibdir="${pkg_prefix}/lib/xtlibs"
  make
}
