pkg_name=multichain
pkg_origin=core
pkg_version=1.0.8
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("GPL-3.0-only")
pkg_description="MultiChain is an open source platform for private blockchains."
pkg_upstream_url="https://www.multichain.com"
pkg_source="https://www.multichain.com/download/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum=5905bc7f236d0f7ff3978bbc6e791cafdfb34e8ca5b2f5fe5fca535a1336d575
pkg_bin_dirs=(bin)
pkg_deps=(
  core/glibc
  core/gcc-libs
  core/patchelf
)
pkg_exports=(
  [port]=system.port
  [rpcport]=system.rpcport
)
pkg_exposes=(port rpcport)
pkg_binds_optional=(
  [multichain]="port rpcport"
)

do_build() {
  return 0
}

do_install() {
  local bin_path="${pkg_prefix}/bin/"

  install -D multichain-cli "${bin_path}"
  install -D multichain-util "${bin_path}"
  install -D multichaind "${bin_path}"
  install -D multichaind-cold "${bin_path}"

  find "${bin_path}" -type f -executable \
    -exec patchelf --interpreter "$(pkg_path_for core/glibc)/lib/ld-linux-x86-64.so.2" --set-rpath "${LD_RUN_PATH}" {} \;
}

do_strip() {
  return 0
}
