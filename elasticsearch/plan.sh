pkg_name=elasticsearch
pkg_origin=core
pkg_version=6.1.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Open Source, Distributed, RESTful Search Engine"
pkg_upstream_url="https://elastic.co"
pkg_license=('Revised BSD')
pkg_source=https://artifacts.elastic.co/downloads/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=c879fe2698635a2f132db4a02d84f657bc0ccdb5c5f68dda5102f9b2afa508d7
pkg_deps=(
  core/busybox-static
  core/glibc
  core/jre8
)
pkg_bin_dirs=(es/bin)
pkg_binds_optional=(
  [elasticsearch]="http-port transport-port"
)
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
  install -vDm644 README.textile "${pkg_prefix}/README.textile"
  install -vDm644 LICENSE.txt "${pkg_prefix}/LICENSE.txt"
  install -vDm644 NOTICE.txt "${pkg_prefix}/NOTICE.txt"

  # Elasticsearch is greedy when grabbing config files from /bin/..
  # so we need to put the untemplated config dir out of reach
  mkdir -p "${pkg_prefix}/es"
  cp -a ./* "${pkg_prefix}/es"

  # jvm.options needs to live relative to the binary.
  # mkdir -p "$pkg_prefix/es/config"
  # install -vDm644 config/jvm.options "$pkg_prefix/es/config/jvm.options"

  # Delete unused binaries to save space
  rm "${pkg_prefix}/es/bin/"*.bat "${pkg_prefix}/es/bin/"*.exe
}
