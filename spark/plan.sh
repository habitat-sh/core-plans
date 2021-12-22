pkg_name=spark
pkg_origin=core
pkg_version=2.4.8
pkg_license=('Apache-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Apache Spark is a fast and general-purpose cluster computing system. It provides high-level APIs in Java, Scala, Python and R, and an optimized engine that supports general execution graphs."
pkg_upstream_url="https://spark.apache.org"
pkg_source="https://archive.apache.org/dist/${pkg_name}/${pkg_name}-${pkg_version}/${pkg_name}-${pkg_version}-bin-hadoop2.7.tgz"
pkg_shasum="feedb945ab4906d098d9d71050a4dab1972de489423008489708ecf496ce91cd"
pkg_dirname="${pkg_name}-${pkg_version}-bin-hadoop2.7"
pkg_build_deps=()
pkg_deps=(
  core/bash
  core/openjdk11
  core/procps-ng
  core/busybox-static
)
pkg_bin_dirs=(bin sbin)
pkg_lib_dirs=(jars)
pkg_exports=(
  [port]=port
)

pkg_exposes=(port)

do_build() {
  return 0
}

do_install() {
  cp -r sbin bin jars "$pkg_prefix"

  build_line "Fixing bin/env interpreters"
  fix_interpreter "${pkg_prefix}/bin/*" core/busybox-static bin/env
  fix_interpreter "${pkg_prefix}/sbin/*" core/busybox-static bin/env
}
