pkg_name=envoy
pkg_origin=core
pkg_version='1.20.1'
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=('Apache-2.0')
pkg_description="Build and test software of any size, quickly and reliably"
pkg_upstream_url='https://www.envoyproxy.io/'
pkg_source="https://github.com/envoyproxy/envoy/archive/refs/tags/v${pkg_version}.tar.gz"
pkg_build_deps=(
  core/curl
  core/jq-static
  core/patchelf
  core/coreutils
  core/go
)
pkg_deps=(core/glibc)
pkg_bin_dirs=(bin)

do_download() {
  curl "https://raw.githubusercontent.com/moby/moby/master/contrib/download-frozen-image-v2.sh" -o "${HAB_CACHE_SRC_PATH}/download-frozen-image-v2.sh"
  sed -e "s#\#\!/usr/bin/env bash#\#\!/bin/bash#" -i "${HAB_CACHE_SRC_PATH}/download-frozen-image-v2.sh"
  chmod +x "${HAB_CACHE_SRC_PATH}/download-frozen-image-v2.sh"
  "${HAB_CACHE_SRC_PATH}/download-frozen-image-v2.sh" "${HAB_CACHE_SRC_PATH}/envoy" "envoyproxy/envoy:v${pkg_version}"
}

do_unpack() {
  mkdir -p "${CACHE_PATH}"
  find "${HAB_CACHE_SRC_PATH}/envoy" -name "*.tar" -exec tar -xf {} -C "${CACHE_PATH}" \;
}

do_verify() {
  return 0
}

do_build() {
  return 0
}

do_install() {
  mkdir -p "${pkg_prefix}/bin/"
  cp ./usr/local/bin/envoy "${pkg_prefix}/bin/envoy"
  patchelf --interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" --set-rpath "${LD_RUN_PATH}" "${pkg_prefix}/bin/envoy"
}

do_strip() {
  return 0
}
