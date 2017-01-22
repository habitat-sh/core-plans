pkg_origin=core
pkg_name=logstash2
pkg_version=2.4.1
pkg_description="Logstash is an open source, server-side data processing pipeline that ingests data from a multitude of sources simultaneously, transforms it, and then sends it to your favorite 'stash.'"
pkg_upstream_url=https://www.elastic.co/products/logstash
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Apache-2.0")
pkg_source=https://download.elastic.co/logstash/logstash/logstash-${pkg_version}.tar.gz
pkg_shasum=957647af07e54c7d18c6e3b543030edae461d447d27412ebb7637cd7eb109f4f
pkg_deps=(
  core/coreutils
  core/jre8
  core/jruby1
)
pkg_build_deps=()
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_dirname=logstash-${pkg_version}

do_build() {
  return 0
}

do_install() {
  mkdir -p "$pkg_prefix"
  cp -r ./* "$pkg_prefix"
  rm -rf "$pkg_prefix/vendor/jruby"
  rm -rf "$pkg_prefix/bin"/*.bat
}
