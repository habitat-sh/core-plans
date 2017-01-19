pkg_origin=core
pkg_name=logback
pkg_version=1.1.8
pkg_description="The reliable, generic, fast and flexible logging framework for Java."
pkg_upstream_url=http://logback.qos.ch
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=(EPL-1.0)
pkg_source=http://logback.qos.ch/dist/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=c365d6fb6e811b78e64610abc61f04a6de79884d87c592af8593d16a48194610
pkg_lib_dirs=(lib)

do_build() {
  return 0
}

do_install() {
  install -v -t $pkg_prefix/lib $HAB_CACHE_SRC_PATH/$pkg_dirname/logback-core-${pkg_version}.jar \
    $HAB_CACHE_SRC_PATH/$pkg_dirname/logback-core-${pkg_version}-sources.jar \
    $HAB_CACHE_SRC_PATH/$pkg_dirname/logback-access-${pkg_version}.jar \
    $HAB_CACHE_SRC_PATH/$pkg_dirname/logback-access-${pkg_version}-sources.jar \
    $HAB_CACHE_SRC_PATH/$pkg_dirname/logback-classic-${pkg_version}.jar \
    $HAB_CACHE_SRC_PATH/$pkg_dirname/logback-classic-${pkg_version}-sources.jar
}
