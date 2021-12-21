pkg_origin=core
pkg_name=logback
pkg_version=1.2.9
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
	4a9ef7ed809b1fbc6992bf87d404087c247e7a9766e25bb84377b58ed5c9eb58
	44f11cf8dddba832ccc7658ebf19e3945249474e809ddc57265a799c63e1db22
	4db03561790664b823181cf8db78260c675464741372459ecba4fadf6d5538d2
	35ae608caaf74643935e0014dfccb7430870a157d039346c57d5c3afeefadc2a
	ad745cc243805800d1ebbf5b7deba03b37c95885e6bce71335a73f7d6d0f14ee
	18b073d37c800b18d6721d023156575105adf25e26dfa0e5218237f4ca64301b
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
