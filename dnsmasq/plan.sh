pkg_name=dnsmasq
pkg_origin=core
pkg_version=2.80
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Provides network infrastructure for small networks"
pkg_upstream_url="http://www.thekelleys.org.uk/dnsmasq/doc.html"
pkg_license=("GPL-2.0-or-later")
pkg_source="http://www.thekelleys.org.uk/dnsmasq/dnsmasq-${pkg_version}.tar.gz"
pkg_shasum="9e4a58f816ce0033ce383c549b7d4058ad9b823968d352d2b76614f83ea39adc"
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
pkg_svc_run="dnsmasq -x $pkg_svc_path/dnsmasq.pid -C $pkg_svc_config_path/dnsmasq.conf --no-daemon"
pkg_svc_user="root"
pkg_svc_group="root"

do_build() {
  make
}

do_install() {
  mv ./src/dnsmasq "$pkg_prefix/bin/"
}
