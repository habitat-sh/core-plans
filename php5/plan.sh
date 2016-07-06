pkg_name=php5
pkg_distname=php
pkg_origin=core
pkg_version=5.6.23
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('PHP-3.01')
pkg_upstream_url=http://php.net/
pkg_description="PHP is a popular general-purpose scripting language that is especially suited to web development."
pkg_source=https://php.net/get/${pkg_distname}-${pkg_version}.tar.bz2/from/this/mirror
pkg_filename=${pkg_distname}-${pkg_version}.tar.bz2
pkg_dirname=${pkg_distname}-${pkg_version}
pkg_shasum=facd280896d277e6f7084b60839e693d4db68318bfc92085d3dc0251fd3558c7
pkg_deps=(core/libxml2)
pkg_build_deps=(core/bison2 core/gcc core/make core/re2c)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_interpreters=(bin/php)

do_prepare() {
  # The configure script expects libxml2 binaries to either be in `/usr/bin`, `/usr/local/bin` or be
  # passed in as a configure param. Instead of overriding the entire do_build, symlink the
  # required executable into place.
  if [[ ! -r /usr/bin/xml2-config ]]; then
    ln -sv "$(pkg_path_for libxml2)/bin/xml2-config" /usr/bin/xml2-config
    _clean_xml2=true
  fi
}

do_check() {
  make test
}

do_end() {
  # Clean up the `xml2-config` link, if we set it up.
  if [[ -n "$_clean_xml2" ]]; then
    rm -fv /usr/bin/xml2-config
  fi
}
