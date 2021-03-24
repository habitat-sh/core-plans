pkg_origin=core
pkg_name=ant
pkg_version=1.10.9
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Apache-2.0")
pkg_description="Ant is a Java based build tool."
pkg_upstream_url=https://ant.apache.org/
pkg_source="https://github.com/apache/ant/archive/rel/${pkg_version}.tar.gz"
pkg_shasum=0f676da0507ca750f7cf77cbe7750a44213dc611a94e78a47870e79417e09776
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

do_prepare() {
  JAVA_HOME="$(pkg_path_for core/corretto8)"
  export JAVA_HOME
  cd "${HAB_CACHE_SRC_PATH}/${pkg_name}-rel-${pkg_version}"
  sed -i 's|/usr/bin/python|/usr/bin/python2|' src/script/runant.py
}

do_build() {
  cd "${HAB_CACHE_SRC_PATH}/${pkg_name}-rel-${pkg_version}"
  ./bootstrap.sh
  bootstrap/bin/ant -Ddest=optional -f fetch.xml
  bootstrap/bin/ant dist
}

do_install() {
  mv "${HAB_CACHE_SRC_PATH}/${pkg_name}-rel-${pkg_version}/apache-${pkg_name}-${pkg_version}/bin/"* "${pkg_prefix}/bin/"
  mv "${HAB_CACHE_SRC_PATH}/${pkg_name}-rel-${pkg_version}/apache-${pkg_name}-${pkg_version}/lib/"* "${pkg_prefix}/lib/"
}
