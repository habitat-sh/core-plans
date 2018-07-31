pkg_origin=afiore
pkg_name=sbt
pkg_version=1.1.6
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="A build tool for Scala, Java, and more"
pkg_upstream_url="https://www.scala-sbt.org"
pkg_license=("BSD-3-Clause")
pkg_source=https://github.com/sbt/sbt/releases/download/v${pkg_version}/sbt-${pkg_version}.tgz
pkg_shasum=f545b530884e3abbca026df08df33d5a15892e6d98da5b8c2297413d1c7b68c1
pkg_dirname="$pkg_name-$pkg_version"
pkg_interpreters=(bin/bash)
pkg_deps=(
  core/coreutils
  core/jre8
  core/bash
  core/sed
  core/grep
)
pkg_bin_dirs=(bin)

do_prepare() {
  export JAVA_HOME
  JAVA_HOME="$(pkg_path_for jre8)"
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
