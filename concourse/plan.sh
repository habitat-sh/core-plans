pkg_name=concourse
pkg_origin=core
pkg_version="3.6.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_source="https://github.com/${pkg_name}/${pkg_name}/releases/download/v${pkg_version}/${pkg_name}_linux_amd64"
pkg_filename="${pkg_name}_linux_amd64"
pkg_shasum="87132e62f227e776b10178c21c83eb9f0049e4b53adc4e4dbb7eb06dfbb2e3b1"
pkg_deps=(core/glibc)
pkg_build_deps=(core/patchelf)
pkg_bin_dirs=(bin)
pkg_description="CI that scales with your project"
pkg_upstream_url="https://concourse.ci"

do_unpack() {
  pushd "${HAB_CACHE_SRC_PATH}"
    mv "${pkg_name}_linux_amd64" "${pkg_name}"
    chmod +x "${pkg_name}"
  popd
}

do_build(){
  return 0
}

do_install(){
  cp "$HAB_CACHE_SRC_PATH/${pkg_name}" "${pkg_prefix}/bin/${pkg_name}" || exit 1
  patchelf --interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" \
    "${pkg_prefix}/bin/concourse"
}
