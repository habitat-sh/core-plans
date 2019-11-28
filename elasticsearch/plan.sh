pkg_name=elasticsearch
pkg_origin=core
pkg_version=6.8.5
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Open Source, Distributed, RESTful Search Engine"
pkg_upstream_url="https://elastic.co"
pkg_license=('Revised BSD')
pkg_source="https://artifacts.elastic.co/downloads/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum=5fe84fa84a0ca0136aad9bbdfc2053f8dda9a3e166ddf34e947bb1fe24e4ce6d
pkg_build_deps=(
  core/patchelf
)
pkg_deps=(
  core/coreutils-static
  core/busybox-static
  core/glibc
  core/zlib
  core/openjdk11
  core/wget
)
pkg_bin_dirs=(es/bin)
pkg_binds_optional=(
  [elasticsearch]="http-port transport-port"
)
pkg_lib_dirs=(es/lib)
pkg_exports=(
  [http-port]=network.port
  [transport-port]=transport.port
)
pkg_exposes=(http-port transport-port)

do_build() {
  return 0
}

do_install() {
  install -vDm644 README.textile "${pkg_prefix}/README.textile"
  install -vDm644 LICENSE.txt "${pkg_prefix}/LICENSE.txt"
  install -vDm644 NOTICE.txt "${pkg_prefix}/NOTICE.txt"

  # Elasticsearch is greedy when grabbing config files from /bin/..
  # so we need to put the untemplated config dir out of reach
  mkdir -p "${pkg_prefix}/es"
  cp -a ./* "${pkg_prefix}/es"

  # jvm.options needs to live relative to the binary.
  # mkdir -p "$pkg_prefix/es/config"
  # install -vDm644 config/jvm.options "$pkg_prefix/es/config/jvm.options"

  # Delete unused binaries to save space
  rm "${pkg_prefix}/es/bin/"*.bat "${pkg_prefix}/es/bin/"*.exe

  LD_RUN_PATH=$LD_RUN_PATH:${pkg_prefix}/es/modules/x-pack-ml/platform/linux-x86_64/lib
  export LD_RUN_PATH

  _es_ml_bins=( "autoconfig" "autodetect" "categorize" "controller" "normalize" )
  for bin in "${_es_ml_bins[@]}"; do
    build_line "patch ${pkg_prefix}/es/modules/x-pack-ml/platform/linux-x86_64/bin/${bin}"
    patchelf --interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" --set-rpath "${LD_RUN_PATH}" \
      "${pkg_prefix}/es/modules/x-pack-ml/platform/linux-x86_64/bin/${bin}"

    find "${pkg_prefix}/es/modules/x-pack-ml/platform/linux-x86_64/lib" -type f -name "*.so" \
      -exec patchelf --set-rpath "${LD_RUN_PATH}" {} \;
  done
}

do_strip() {
  return 0
}
