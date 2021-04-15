pkg_name=dnsmasq
pkg_origin=core
pkg_version=2.85
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Provides network infrastructure for small networks"
pkg_upstream_url="http://www.thekelleys.org.uk/dnsmasq/doc.html"
pkg_license=("GPL-2.0-or-later")
pkg_source="http://www.thekelleys.org.uk/dnsmasq/dnsmasq-${pkg_version}.tar.gz"
pkg_shasum=f36b93ecac9397c15f461de9b1689ee5a2ed6b5135db0085916233053ff3f886
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
