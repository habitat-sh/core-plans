pkg_origin=core
pkg_name=maven
pkg_version=3.6.2
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="A software project management and comprehension tool"
pkg_upstream_url="https://maven.apache.org/"
pkg_license=("Apache-2.0")
pkg_source="http://apache.cs.utah.edu/maven/maven-3/${pkg_version}/source/apache-maven-${pkg_version}-src.tar.gz"
pkg_shasum=7ed94655b4098729de292a13c96765bb90a407bb6feb64f201a9444aebde69d1
pkg_dirname="apache-${pkg_name}-${pkg_version}"
pkg_deps=(
  core/coreutils
  core/corretto8
  core/which
)
pkg_build_deps=(core/maven)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

do_prepare() {
  export JAVA_HOME
  JAVA_HOME="$(pkg_path_for corretto8)"
  build_line "Setting JAVA_HOME=$JAVA_HOME"
}

do_build() {
  mvn -DdistributionTargetDir="$pkg_prefix" install
}

do_install() {
  return 0
}
