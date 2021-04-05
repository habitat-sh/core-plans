pkg_origin=core
pkg_name=logback
pkg_version=1.2.3
pkg_description="The reliable, generic, fast and flexible logging framework for Java."
pkg_upstream_url=http://logback.qos.ch
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=(EPL-1.0)
pkg_source=https://repo1.maven.org/maven2/ch/qos/logback
pkg_lib_dirs=(lib)

_target_sources=(
  "$pkg_source/${pkg_name}-core/${pkg_version}/${pkg_name}-core-${pkg_version}.jar"
  "$pkg_source/${pkg_name}-core/${pkg_version}/${pkg_name}-core-${pkg_version}-sources.jar"
  "$pkg_source/${pkg_name}-access/${pkg_version}/${pkg_name}-access-${pkg_version}.jar"
  "$pkg_source/${pkg_name}-access/${pkg_version}/${pkg_name}-access-${pkg_version}-sources.jar"
  "$pkg_source/${pkg_name}-classic/${pkg_version}/${pkg_name}-classic-${pkg_version}.jar"
  "$pkg_source/${pkg_name}-classic/${pkg_version}/${pkg_name}-classic-${pkg_version}-sources.jar"
)

_target_shasums=(
  5946d837fe6f960c02a53eda7a6926ecc3c758bbdd69aa453ee429f858217f22
  1f69b6b638ec551d26b10feeade5a2b77abe347f9759da95022f0da9a63a9971
  0a4fc8753abe266ea7245e6d9653d6275dc1137cad6ecd1b2612204033d89687
  930137eac280cd70a34622c8cacc9f120040dc78b3f191af63ee9b7b311559fb
  fb53f8539e7fcb8f093a56e138112056ec1dc809ebb020b59d8a36a5ebac37e0
  480cb5e99519271c9256716d4be1a27054047435ff72078d9deae5c6a19f63eb
)

do_download() {
  for i in $(seq 0 $((${#_target_sources[@]} - 1))); do
    p="${_target_sources[$i]}"
    download_file "$p" "$(basename "$p")" "${_target_shasums[$i]}"
  done; unset i p
}

do_verify() {
  for i in $(seq 0 $((${#_target_sources[@]} - 1))); do
    verify_file "$(basename "${_target_sources[$i]}")" "${_target_shasums[$i]}"
  done; unset i
}

do_unpack() {
  return 0
}

do_build() {
  return 0
}

do_install() {
  for i in $(seq 0 $((${#_target_sources[@]} - 1))); do
    cp "$HAB_CACHE_SRC_PATH/$(basename "${_target_sources[$i]}")" "$pkg_prefix/lib"
  done; unset i
}
