pkg_name=apache-cassandra
pkg_origin=core
pkg_version=3.10
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Open source distributed realtime computation system."
pkg_upstream_url="https://cassandra.apache.org/"
pkg_license=("Apache-2.0")
pkg_source="http://apache.40b.nl/cassandra/${pkg_version}/${pkg_name}-${pkg_version}-bin.tar.gz"
pkg_shasum=c09c3f92d4f80d5639e3f1624c9eec45d25793bbb6b3e3640937b68a9c6d107f
pkg_deps=(
  core/jre8
  core/python
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

# thrift port is for legacy client connection, need to be enabled to be used
pkg_exports=(
  [port]=native_transport.port
  # [ssl-port]=native_transport.ssl_port
  [thrift-port]=rpc.port
)
pkg_exposes=(
  port
  #ssl-port
  thrift-port
)

do_build() {
  return 0
}

do_strip() {
  return 0
}

do_install() {
  install -vDm644 LICENSE.txt "$pkg_prefix/LICENSE.txt"
  install -vDm644 NOTICE.txt "$pkg_prefix/NOTICE.txt"

  cp -a bin lib  "$pkg_prefix"
  rm "$pkg_prefix/bin/"*.bat
}
