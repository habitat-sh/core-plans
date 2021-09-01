pkg_name=dgraph
pkg_origin=core
pkg_version="1.2.6"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_source="https://github.com/${pkg_name}-io/${pkg_name}/releases/download/v${pkg_version}/${pkg_name}-linux-amd64.tar.gz"
pkg_shasum=fb869726fe223e3a9631a7105a5a764b3c83365a4de2ffe61afbed3098e4d80a
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
