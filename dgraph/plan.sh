pkg_name=dgraph
pkg_origin=core
pkg_version="1.0.16"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_source="https://github.com/${pkg_name}-io/${pkg_name}/releases/download/v${pkg_version}/${pkg_name}-linux-amd64.tar.gz"
pkg_shasum=c778603e747e98fccf212d823c396f72be28153b7832f3804447f39a4ea6a92f
pkg_deps=(core/glibc)
pkg_build_deps=(core/patchelf)
pkg_bin_dirs=(bin)
pkg_description="Distributed transactional graph database written in go"
pkg_upstream_url="https://dgraph.io"

do_build() {
  return 0
}

do_install() {
  cp "${HAB_CACHE_SRC_PATH}/${pkg_name}" "${pkg_prefix}/bin/${pkg_name}" || exit 1
  patchelf \
    --interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" \
    "${pkg_prefix}/bin/${pkg_name}"
}
