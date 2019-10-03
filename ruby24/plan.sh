# shellcheck disable=SC2148,SC1091
source ../ruby/plan.sh

pkg_name=ruby24
pkg_origin=core
pkg_version=2.4.9
pkg_description="A dynamic, open source programming language with a focus on \
  simplicity and productivity. It has an elegant syntax that is natural to \
  read and easy to write."
pkg_license=("Ruby")
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://cache.ruby-lang.org/pub/ruby/ruby-${pkg_version}.tar.gz
pkg_upstream_url=https://www.ruby-lang.org/en/
pkg_shasum=f99b6b5e3aa53d579a49eb719dd0d3834d59124159a6d4351d1e039156b1c6ae
pkg_dirname="ruby-$pkg_version"
