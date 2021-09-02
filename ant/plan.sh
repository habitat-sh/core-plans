pkg_origin=core
pkg_name=ant
pkg_version=1.10.11
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Apache-2.0")
pkg_description="Ant is a Java based build tool."
pkg_upstream_url=https://ant.apache.org/
pkg_source="https://github.com/apache/ant/archive/rel/${pkg_version}.tar.gz"
pkg_dirname="${pkg_name}-rel-${pkg_version}"
pkg_shasum=55a5afe0d40449667162b1cdc6478bc1d99370ddcbb63d708913921fa22b6232
pkg_build_deps=(
  core/python2
)
pkg_deps=(
  core/coreutils
  core/corretto8
  core/sed
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

do_setup_environment() {
  set_runtime_env ANT_HOME "${pkg_prefix}"
  set_buildtime_env ANT_HOME "${pkg_prefix}"
}

do_prepare() {
  JAVA_HOME="$(pkg_path_for core/corretto8)"
  export JAVA_HOME
  build_line "Setting JAVA_HOME=${JAVA_HOME}"

  sed -i 's|/usr/bin/python|/usr/bin/python2|' src/script/runant.py
}

do_build() {
  sh build.sh \
    -Ddist.dir="${pkg_prefix}" \
    dist
}

do_install() {
  sh build.sh install
}
