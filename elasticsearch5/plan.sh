source "$(dirname "${BASH_SOURCE[0]}")/../elasticsearch/plan.sh"

pkg_name=elasticsearch5
pkg_distname=elasticsearch
pkg_origin=core
pkg_version=5.6.14
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Open Source, Distributed, RESTful Search Engine"
pkg_upstream_url="https://elastic.co"
pkg_license=('Revised BSD')
pkg_source=https://artifacts.elastic.co/downloads/${pkg_distname}/${pkg_distname}-${pkg_version}.tar.gz
pkg_shasum=6c8b46498186bb2f4183660d8653375fc38bddd043302ddb20c516b42ab0125e
pkg_dirname="elasticsearch-${pkg_version}"
