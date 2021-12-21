source "$(dirname "${BASH_SOURCE[0]}")/../elasticsearch/plan.sh"

pkg_name=elasticsearch5
pkg_distname=elasticsearch
pkg_origin=core
pkg_version=5.6.16
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Open Source, Distributed, RESTful Search Engine"
pkg_upstream_url="https://elastic.co"
pkg_license=('Revised BSD')
pkg_source=https://artifacts.elastic.co/downloads/${pkg_distname}/${pkg_distname}-${pkg_version}.tar.gz
pkg_shasum=6b035a59337d571ab70cea72cc55225c027ad142fbb07fd8984e54261657c77f
pkg_dirname="elasticsearch-${pkg_version}"

do_install() {
  install -vDm644 README.textile "${pkg_prefix}/README.textile"
  install -vDm644 LICENSE.txt "${pkg_prefix}/LICENSE.txt"
  install -vDm644 NOTICE.txt "${pkg_prefix}/NOTICE.txt"

  # Elasticsearch is greedy when grabbing config files from /bin/..
  # so we need to put the untemplated config dir out of reach
  mkdir -p "${pkg_prefix}/es"
  cp -a ./* "${pkg_prefix}/es"

  # Delete unused binaries to save space
  rm "${pkg_prefix}/es/bin/"*.bat "${pkg_prefix}/es/bin/"*.exe
}
