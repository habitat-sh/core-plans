pkg_name=php
pkg_origin=core
pkg_version=7.4.16
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("PHP-3.01")
pkg_upstream_url=http://php.net/
pkg_description="PHP is a popular general-purpose scripting language that is especially suited to web development."
pkg_source="https://php.net/get/${pkg_name}-${pkg_version}.tar.xz/from/this/mirror"
pkg_filename="${pkg_name}-${pkg_version}.tar.xz"
pkg_dirname="${pkg_name}-${pkg_version}"
pkg_shasum=1c16cefaf88ded4c92eed6a8a41eb682bb2ef42429deb55f1c4ba159053fb98b
pkg_deps=(
  core/bzip2
  core/coreutils
  core/curl
  core/glibc
  core/icu
  core/libjpeg-turbo
  core/libpng
  core/libxml2
  core/libzip
  core/openssl
  core/readline
  core/zip
  core/zlib
  core/gcc-libs
  core/oniguruma
  core/sqlite
)
pkg_build_deps=(
  core/autoconf
  core/bison
  core/gcc
  core/libgd
  core/make
  core/re2c
)
pkg_bin_dirs=(bin sbin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_interpreters=(bin/php)

do_build() {
  ./configure --prefix="${pkg_prefix}" \
    --enable-fpm \
    --with-fpm-user=hab \
    --with-fpm-group=hab \
    --with-mysqli=mysqlnd \
    --with-pdo-mysql=mysqlnd \
    --with-readline="$(pkg_path_for readline)" \
    --with-curl \
    --with-jpeg \
    --with-libxml \
    --with-openssl \
    --with-xmlrpc \
    --with-zip \
    --with-zlib \
    --with-bz2="$(pkg_path_for bzip2)" \
    --with-gettext="$(pkg_path_for glibc)" \
    --enable-bcmath \
    --enable-exif \
    --enable-mbstring \
    --enable-opcache \
    --enable-gd \
    --enable-intl

  make -j "$(nproc)"
}

do_install() {
  do_default_install

  # Modify PHP-FPM config so it will be able to run out of the box. To run a real
  # PHP-FPM application you would want to supply your own config with
  # --fpm-config <file>.
  mv "${pkg_prefix}/etc/php-fpm.conf.default" "${pkg_prefix}/etc/php-fpm.conf"
}

do_check() {
  make test
}
