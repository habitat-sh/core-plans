source ../ruby/plan.sh

pkg_name=ruby22
pkg_origin=core
pkg_version=2.2.9
pkg_description="A dynamic, open source programming language with a focus on \
  simplicity and productivity. It has an elegant syntax that is natural to \
  read and easy to write."
pkg_license=("Ruby")
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://cache.ruby-lang.org/pub/ruby/ruby-${pkg_version}.tar.gz
pkg_upstream_url=https://www.ruby-lang.org/en/
pkg_shasum=2f47c77054fc40ccfde22501425256d32c4fa0ccaf9554f0d699ed436beca1a6
pkg_dirname="ruby-$pkg_version"

pkg_version() {
  echo "$pkg_version"
}

do_before() {
  update_pkg_version
}
