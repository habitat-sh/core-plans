# shellcheck disable=SC2148,SC1091
source ../ruby/plan.sh

pkg_name=ruby24
pkg_origin=core
pkg_version=2.4.7
pkg_description="A dynamic, open source programming language with a focus on \
  simplicity and productivity. It has an elegant syntax that is natural to \
  read and easy to write."
pkg_license=("Ruby")
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://cache.ruby-lang.org/pub/ruby/ruby-${pkg_version}.tar.gz
pkg_upstream_url=https://www.ruby-lang.org/en/
pkg_shasum=cd6efc720ca6a622745e2bac79f45e6cd63ab0f5a53ad7eb881545f58ff38b89
pkg_dirname="ruby-$pkg_version"
