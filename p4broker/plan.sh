pkg_name=p4broker
pkg_origin=core
pkg_version="18.1"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Apache-2.0")
pkg_source="http://www.perforce.com/downloads/perforce/r${pkg_version}/bin.linux26x86_64/p4broker"
pkg_filename="p4broker"
pkg_shasum="83cbaad39ed814d9ba05680d629168b79f51f127ca2ca3fa6e9063f731b239b8"
pkg_upstream_url="https://www.perforce.com/downloads/helix-broker-p4broker"
pkg_deps=(core/glibc)
pkg_build_deps=(core/patchelf)
pkg_bin_dirs=(bin)
pkg_exports=(
  [host]=srv.address
  [port]=srv.port
)
pkg_exposes=(port)
pkg_description="Helix' P4Broker daemon service for proxying requests through to a Helix PerForce server."

do_build() {
  return 0
}

do_unpack() {
  return 0
}
do_strip() {
  return 0
}

do_install() {
  mkdir -p "$pkg_prefix/bin"
  cp "$HAB_CACHE_SRC_PATH/p4broker" "$pkg_prefix/bin/p4broker"
  chmod +x "$pkg_prefix/bin/p4broker"
  patchelf --interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" "${pkg_prefix}/bin/p4broker"
}
