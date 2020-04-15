pkg_origin=core
pkg_name=logback
pkg_version=1.1.8
pkg_description="The reliable, generic, fast and flexible logging framework for Java."
pkg_upstream_url=http://logback.qos.ch
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=(EPL-1.0)
pkg_source=https://repo1.maven.org/maven2/ch/qos/logback
pkg_lib_dirs=(lib)

_target_sources=(
  $pkg_source/${pkg_name}-core/${pkg_version}/${pkg_name}-core-${pkg_version}.jar
  $pkg_source/${pkg_name}-core/${pkg_version}/${pkg_name}-core-${pkg_version}-sources.jar
  $pkg_source/${pkg_name}-access/${pkg_version}/${pkg_name}-access-${pkg_version}.jar
  $pkg_source/${pkg_name}-access/${pkg_version}/${pkg_name}-access-${pkg_version}-sources.jar
  $pkg_source/${pkg_name}-classic/${pkg_version}/${pkg_name}-classic-${pkg_version}.jar
  $pkg_source/${pkg_name}-classic/${pkg_version}/${pkg_name}-classic-${pkg_version}-sources.jar
)

_target_shasums=(
  418d84bad04ee43bc1a83c30d9beb64d9a544ffdf368d12f4b46ca18503310ca
  d1801014b0bfcc0c7478731fd48c9fef3e6076cc2a328759fe3446fc139a3ed5
  18921674e61740ffde5efeabb42958aab0ca26b19b205f898a039e3c18b5638a
  65aa440dce752d20072d911852b35aca2c16c5b7ad9acad2942ed48d87ffffd2
  b1593321b950b583e23419ddb5443c4214c89ab519d83b3a3b04cdbcee531ab2
  63ba4609b455e3c8ddb5b86e04bba96dfd1e678ee2af8fe407b31549a536213a
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
    cp "$HAB_CACHE_SRC_PATH/$(basename "${_target_sources[$i]}")" $pkg_prefix/lib
  done; unset i
}
