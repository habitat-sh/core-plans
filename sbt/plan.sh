pkg_origin=core
pkg_name=sbt
pkg_version=1.4.9
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="A build tool for Scala, Java, and more"
pkg_upstream_url="https://www.scala-sbt.org"
pkg_license=("Apache-2.0")
pkg_source="https://github.com/sbt/sbt/releases/download/v${pkg_version}/sbt-${pkg_version}.tgz"
pkg_shasum=95468119f7641499367330a60a4b8a6211e6ea7f8bde7d647c67b19dd8fddb6e
pkg_deps=(
  core/coreutils
  core/openjdk11
  core/bash
  core/sed
  core/grep
)
pkg_bin_dirs=(bin)

do_prepare() {
  JAVA_HOME="$(pkg_path_for core/openjdk11)"
  export JAVA_HOME
}

do_build() {
  return 0
}

do_install() {
  mkdir -p "${pkg_prefix}/share"
  cp -ra "${HAB_CACHE_SRC_PATH}/sbt" "${pkg_prefix}/share"
  ln -s "${pkg_prefix}/share/sbt/bin/sbt" "${pkg_prefix}/bin/"
  fix_interpreter "${pkg_prefix}/bin/sbt" core/coreutils bin/env
}
