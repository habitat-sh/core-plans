source "$(dirname "${BASH_SOURCE[0]}")/../elasticsearch/plan.sh"

pkg_name=elasticsearch5
pkg_distname=elasticsearch
pkg_origin=core
pkg_version=5.6.13
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Open Source, Distributed, RESTful Search Engine"
pkg_upstream_url="https://elastic.co"
pkg_license=('Revised BSD')
pkg_source=https://artifacts.elastic.co/downloads/${pkg_distname}/${pkg_distname}-${pkg_version}.tar.gz
pkg_shasum=6800471e65cf18f3580a5d88f1f9dac79c220408aef4bf18cccf295a5211b6b3
pkg_dirname="elasticsearch-${pkg_version}"
