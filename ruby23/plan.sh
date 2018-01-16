# shellcheck disable=SC2148,SC1091
source ../ruby/plan.sh

pkg_name=ruby23
pkg_origin=core
pkg_version=2.3.6
pkg_description="A dynamic, open source programming language with a focus on \
  simplicity and productivity. It has an elegant syntax that is natural to \
  read and easy to write."
pkg_license=("Ruby")
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://cache.ruby-lang.org/pub/ruby/ruby-${pkg_version}.tar.gz
pkg_upstream_url=https://www.ruby-lang.org/en/
pkg_shasum=8322513279f9edfa612d445bc111a87894fac1128eaa539301cebfc0dd51571e
pkg_dirname="ruby-$pkg_version"
