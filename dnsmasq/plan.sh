pkg_name=dnsmasq
pkg_origin=core
pkg_version=2.84
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Provides network infrastructure for small networks"
pkg_upstream_url="http://www.thekelleys.org.uk/dnsmasq/doc.html"
pkg_license=("GPL-2.0-or-later")
pkg_source="http://www.thekelleys.org.uk/dnsmasq/dnsmasq-${pkg_version}.tar.gz"
pkg_shasum=42a765e0b7df35d81485bee7c67009bda3280d8f52c9d743a2fade2c8eb6211e
pkg_deps=(
  core/glibc
)
pkg_build_deps=(
  core/gcc
  core/make
)
pkg_bin_dirs=(
  bin
)
pkg_svc_run="dnsmasq -x ${pkg_svc_path}/dnsmasq.pid -C ${pkg_svc_config_path}/dnsmasq.conf --no-daemon"
pkg_svc_user="root"
pkg_svc_group="root"

do_build() {
  make
}

do_install() {
  mv ./src/dnsmasq "${pkg_prefix}/bin/"
}
