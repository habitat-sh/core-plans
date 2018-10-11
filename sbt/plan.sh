pkg_origin=core
pkg_name=sbt
pkg_version=1.2.4
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="A build tool for Scala, Java, and more"
pkg_upstream_url="https://www.scala-sbt.org"
pkg_license=("BSD-3-Clause")
pkg_source=https://github.com/sbt/sbt/releases/download/v${pkg_version}/sbt-${pkg_version}.tgz
pkg_shasum=36db5a4cbad1d39fb01978a09007b9d833c9172d9cd4a3b08180c24c6a0dfb1b
pkg_dirname="$pkg_name-$pkg_version"
pkg_deps=(
  core/coreutils
  core/jre8
  core/bash
  core/sed
  core/grep
)
pkg_bin_dirs=(bin)

do_prepare() {
  JAVA_HOME="$(pkg_path_for jre8)"
  export JAVA_HOME
  build_line "Setting JAVA_HOME=$JAVA_HOME"
}

do_build() {
  return 0
}

do_install() {
  mkdir -p "$pkg_prefix/share"
  cp -ra "$HAB_CACHE_SRC_PATH/sbt" "$pkg_prefix/share"
  ln -s "$pkg_prefix/share/sbt/bin/sbt" "$pkg_prefix/bin/"
  fix_interpreter "${pkg_prefix}/bin/sbt" core/coreutils bin/env
}
