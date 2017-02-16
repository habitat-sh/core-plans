pkg_name=elasticsearch
pkg_origin=core
pkg_version=2.4.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Open Source, Distributed, RESTful Search Engine"
pkg_upstream_url="https://elastic.co"
pkg_license=('Revised BSD')
pkg_source=https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/tar/elasticsearch/${pkg_version}/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=23a369ef42955c19aaaf9e34891eea3a055ed217d7fbe76da0998a7a54bbe167
pkg_deps=(
  core/busybox-static
  core/glibc
  core/jre8
)
pkg_bin_dirs=(es/bin)
pkg_lib_dirs=(es/lib)
pkg_exports=(
  [http-port]=network.port
  [transport-port]=transport.port
)
pkg_exposes=(http-port transport-port)

do_build() {
  return 0
}

do_install() {
  install -vDm644 README.textile "$pkg_prefix/README.textile"
  install -vDm644 LICENSE.txt "$pkg_prefix/LICENSE.txt"
  install -vDm644 NOTICE.txt "$pkg_prefix/NOTICE.txt"

  # Elasticsearch is greedy when grabbing config files from /bin/..
  # so we need to put the untemplated config dir out of reach
  mkdir -p "$pkg_prefix/es"
  cp -a bin lib modules "$pkg_prefix/es"
  rm "$pkg_prefix/es/bin/"*.bat "$pkg_prefix/es/bin/"*.exe
}
