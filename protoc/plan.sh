pkg_name=protoc
pkg_distname=protobuf
pkg_origin=core
pkg_version="3.6.1"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("BSD-3-Clause")
pkg_description="Protocol Buffers - Google's data interchange format."
pkg_upstream_url="https://github.com/google/${pkg_distname}"
pkg_source="https://github.com/protocolbuffers/${pkg_distname}/releases/download/v${pkg_version}/${pkg_name}-${pkg_version}-linux-x86_64.zip"
pkg_shasum="6003de742ea3fcf703cfec1cd4a3380fd143081a2eb0e559065563496af27807"
pkg_deps=(core/glibc)
pkg_build_deps=(core/patchelf)
pkg_bin_dirs=(bin)

do_unpack() {
  pushd "${HAB_CACHE_SRC_PATH}" > /dev/null
  mkdir -p "${pkg_dirname}"
  pushd "${pkg_dirname}" > /dev/null
  unzip "${HAB_CACHE_SRC_PATH}/${pkg_filename}"
  popd
  popd > /dev/null
}

do_build() {
  patchelf \
    --interpreter "$(pkg_path_for core/glibc)/lib/ld-linux-x86-64.so.2" \
    --set-rpath "${LD_RUN_PATH}" \
    ./bin/protoc
}

do_install() {
  cp -r "${HAB_CACHE_SRC_PATH}/${pkg_dirname}/"* "${pkg_prefix}"
}

do_strip() {
  return 0
}
