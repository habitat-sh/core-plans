pkg_name=spark
pkg_origin=core
pkg_version=2.1.1
pkg_source=https://www.apache.org/dist/${pkg_name}/${pkg_name}-${pkg_version}/${pkg_name}-${pkg_version}-bin-hadoop2.7.tgz
pkg_shasum=372ac4f73221c07696793101007a4f19e31566d1f0d9bd0e5205b6fb5b45bfc2
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Apache Spark is a fast and general-purpose cluster computing system. It provides high-level APIs in Java, Scala, Python and R, and an optimized engine that supports general execution graphs."
pkg_upstream_url="https://spark.apache.org"
pkg_dirname=${pkg_name}-${pkg_version}-bin-hadoop2.7
pkg_license=('Apache-2.0')
pkg_bin_dirs=(bin sbin)
pkg_lib_dirs=(jars)
pkg_build_deps=()
pkg_deps=(
  core/bash
  core/jre8
  core/procps-ng
)
pkg_exports=(
  [port]=port
)

pkg_exposes=(port)

do_build() {
  return 0
}

do_install() {
  cp -r sbin bin jars "$pkg_prefix"
}
