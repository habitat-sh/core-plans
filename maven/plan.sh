pkg_origin=core
pkg_name=maven
pkg_version=3.6.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="A software project management and comprehension tool"
pkg_upstream_url="https://maven.apache.org/"
pkg_license=("Apache-2.0")
pkg_source=http://apache.cs.utah.edu/maven/maven-3/${pkg_version}/source/apache-maven-${pkg_version}-src.tar.gz
pkg_shasum=025921fff6ba827a25413ffc08fb1933565eb1f07ee2d3f228911913ee4f3c3f
pkg_dirname="apache-$pkg_name-$pkg_version"
pkg_deps=(
  core/coreutils
  core/jdk8
  core/which
)
pkg_build_deps=(core/maven)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

do_prepare() {
  export JAVA_HOME
  JAVA_HOME="$(pkg_path_for jdk8)"
  build_line "Setting JAVA_HOME=$JAVA_HOME"
}

do_build() {
  mvn -DdistributionTargetDir="$pkg_prefix" install
}

do_install() {
  return 0
}
