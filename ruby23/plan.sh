source ../ruby/plan.sh

pkg_name=ruby23
pkg_version=2.3.6
pkg_source=https://cache.ruby-lang.org/pub/ruby/ruby-${pkg_version}.tar.gz
pkg_shasum=8322513279f9edfa612d445bc111a87894fac1128eaa539301cebfc0dd51571e
pkg_dirname="ruby-$pkg_version"

pkg_version() {
  echo "$pkg_version"
}

do_before() {
  update_pkg_version
}
