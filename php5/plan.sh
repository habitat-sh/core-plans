pkg_name=php5
pkg_distname=php
pkg_origin=core
pkg_version=5.6.35
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('PHP-3.01')
pkg_upstream_url=http://php.net/
pkg_description="PHP is a popular general-purpose scripting language that is especially suited to web development."
pkg_source=https://php.net/get/${pkg_distname}-${pkg_version}.tar.bz2/from/this/mirror
pkg_filename=${pkg_distname}-${pkg_version}.tar.bz2
pkg_dirname=${pkg_distname}-${pkg_version}
pkg_shasum=ee78a7e9ca21d8ea394d037c55effff477a49dbae31c7753c547036f5bd73b92
pkg_deps=(
  core/coreutils
  core/curl
  core/glibc
  core/libxml2
  core/openssl
  core/readline
  core/zlib
)
pkg_build_deps=(
  core/bison2
  core/gcc
  core/make
  core/re2c
)
pkg_bin_dirs=(bin sbin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_interpreters=(bin/php)

do_build() {
  ./configure --prefix="$pkg_prefix" \
    --enable-exif \
    --enable-fpm \
    --enable-mbstring \
    --enable-opcache \
    --with-readline="$(pkg_path_for readline)" \
    --with-curl="$(pkg_path_for curl)" \
    --with-libxml-dir="$(pkg_path_for libxml2)" \
    --with-openssl="$(pkg_path_for openssl)" \
    --with-xmlrpc \
    --with-zlib="$(pkg_path_for zlib)"
  make
}

do_install() {
  do_default_install

  # Modify PHP-FPM config so it will be able to run out of the box. To run a real
  # PHP-FPM application you would want to supply your own config with
  # --fpm-config <file>.
  mv "$pkg_prefix/etc/php-fpm.conf.default" "$pkg_prefix/etc/php-fpm.conf"
  # Run as the hab user by default, as it's more likely to exist than nobody.
  sed -i "s/nobody/hab/g" "$pkg_prefix/etc/php-fpm.conf"
}

do_check() {
  make test
}
