source ../ruby/plan.sh

pkg_name=ruby22
pkg_version=2.2.9
pkg_source=https://cache.ruby-lang.org/pub/ruby/ruby-${pkg_version}.tar.gz
pkg_shasum=2f47c77054fc40ccfde22501425256d32c4fa0ccaf9554f0d699ed436beca1a6
pkg_dirname="ruby-$pkg_version"

pkg_version() {
  echo "$pkg_version"
}

do_before() {
  update_pkg_version
}
