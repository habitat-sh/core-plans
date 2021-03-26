pkg_name=dgraph-ratel
pkg_origin=core
pkg_version="1.2.8"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_source="https://github.com/dgraph-io/dgraph/releases/download/v${pkg_version}/dgraph-linux-amd64.tar.gz"
pkg_shasum="7c243931749a93451344fc6762895217d157fa85cdae6bb0ce6c9b0ba6ea2edc"
pkg_deps=(core/glibc)
pkg_build_deps=(core/patchelf)
pkg_bin_dirs=(bin)
pkg_description="Distributed transactional graph database written in go"
pkg_upstream_url="https://dgraph.io"

do_build(){
    return 0
}

do_install(){
    cp "$HAB_CACHE_SRC_PATH/${pkg_name}" "${pkg_prefix}/bin/${pkg_name}" || exit 1
    patchelf --interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" \
        "${pkg_prefix}/bin/${pkg_name}"
}
