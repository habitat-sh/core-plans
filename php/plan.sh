pkg_name=php
pkg_origin=core
pkg_version=7.2.8
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("PHP-3.01")
pkg_upstream_url=http://php.net/
pkg_description="PHP is a popular general-purpose scripting language that is especially suited to web development."
pkg_source="https://php.net/get/${pkg_name}-${pkg_version}.tar.xz/from/this/mirror"
pkg_filename="${pkg_name}-${pkg_version}.tar.xz"
pkg_dirname="${pkg_name}-${pkg_version}"
pkg_shasum=53ba0708be8a7db44256e3ae9fcecc91b811e5b5119e6080c951ffe7910ffb0f
pkg_deps=(
  core/coreutils
  core/libzip
  core/bzip2-musl
  core/curl
  core/glibc
  core/libxml2
  core/icu
  core/libjpeg-turbo
  core/libpng
  core/openssl
  core/readline
  core/zip
  core/zlib
)
pkg_build_deps=(
  core/autoconf
  core/bison2
  core/gcc
  core/gcc-libs
  core/libgd
  core/make
  core/re2c
)
pkg_bin_dirs=(bin sbin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_interpreters=(bin/php)

do_build() {

  set_ld_library_path

  ./configure --prefix="${pkg_prefix}" \
    --enable-exif \
    --enable-fpm \
    --with-fpm-user=hab \
    --with-fpm-group=hab \
    --enable-mbstring \
    --enable-opcache \
    --with-mysql=mysqlnd \
    --with-mysqli=mysqlnd \
    --with-pdo-mysql=mysqlnd \
    --with-readline="$(pkg_path_for readline)" \
    --with-curl="$(pkg_path_for curl)" \
    --with-gd \
    --with-jpeg-dir="$(pkg_path_for libjpeg-turbo)" \
    --with-libxml-dir="$(pkg_path_for libxml2)" \
    --with-openssl="$(pkg_path_for openssl)" \
    --with-png-dir="$(pkg_path_for libpng)" \
    --with-xmlrpc \
    --with-zlib="$(pkg_path_for zlib)" \
    --enable-zip \
    --with-libzip="$(pkg_path_for "core/libzip")" \
    --with-bz2="$(pkg_path_for "core/bzip2-musl")" \
    --enable-intl

  make
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

set_ld_library_path() {
  local ld_library_path_part=()

  for dep in "${pkg_build_deps[@]}"; do
    local dep_path
    dep_path=$(pkg_path_for "$dep");

    if [[ -f "$dep_path/LD_RUN_PATH" ]]; then
      local data
      local trimmed
      data=$(cat "$dep_path/LD_RUN_PATH")
      trimmed=$(trim "$data")
      ld_library_path_part+=("$trimmed")
    fi
  done

  LD_LIBRARY_PATH=$(join_by ':' "${ld_library_path_part[@]}")
  export LD_LIBRARY_PATH
}
