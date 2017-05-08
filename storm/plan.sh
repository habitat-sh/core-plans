pkg_name=storm
pkg_origin=core
pkg_version=1.1.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Open source distributed realtime computation system."
pkg_upstream_url="http://storm.apache.org/index.html"
pkg_license=("Apache-2.0")
pkg_source=http://apache.40b.nl/storm/apache-storm-${pkg_version}/apache-storm-${pkg_version}.tar.gz
pkg_shasum=6f584b45ec7f8d0cfd2fa78deb5de392bece07a09158a948b0ed3016ef689142
pkg_deps=(
  core/jre7
  core/python
  core/bash
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_dirname=apache-storm-${pkg_version}

pkg_exports=()
pkg_exposes=()

do_build() {
  return 0
}

do_install() {

  install -vDm644 README.markdown "$pkg_prefix/README.md"
  install -vDm644 LICENSE "$pkg_prefix/LICENSE.txt"
  install -vDm644 NOTICE "$pkg_prefix/NOTICE.txt"

  cp -a bin lib log4j2 "$pkg_prefix"
}
