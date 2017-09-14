pkg_origin=core
pkg_name=maven
pkg_version=3.3.9
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="A software project management and comprehension tool"
pkg_upstream_url="https://maven.apache.org/"
pkg_license=("Apache-2.0")
pkg_source=http://apache.cs.utah.edu/maven/maven-3/${pkg_version}/source/apache-maven-${pkg_version}-src.tar.gz
pkg_shasum=9150475f509b23518e67a220a9d3a821648ab27550f4ece4d07b92b1fc5611bc
pkg_dirname="apache-$pkg_name-$pkg_version"
pkg_deps=(
  core/coreutils
  core/jdk8
  core/which
)
pkg_build_deps=(core/ant)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

do_prepare() {
  export JAVA_HOME
  JAVA_HOME="$(pkg_path_for jdk8)"
  build_line "Setting JAVA_HOME=$JAVA_HOME"
}

do_build() {
  ant -Dmaven.home="$pkg_prefix"
}

do_install() {
  return 0
}
