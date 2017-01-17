pkg_name=logback
pkg_origin=core
pkg_version=1.1.8
pkg_source=http://logback.qos.ch/dist/logback-${pkg_version}.tar.gz
pkg_shasum=c365d6fb6e811b78e64610abc61f04a6de79884d87c592af8593d16a48194610
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Logback is intended as a successor to the popular log4j project."
pkg_license=('Apache-2.0')\
pkg_upstream_url=http://logback.qos.ch/


do_build() {
  return 0
}

do_install() {
  cp "${HAB_CACHE_SRC_PATH}/${pkg_name}-${pkg_version}"/*.jar "$pkg_prefix"
}
