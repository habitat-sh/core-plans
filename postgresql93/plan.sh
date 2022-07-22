# shellcheck disable=SC2164
pkg_name=postgresql93
pkg_version=9.3.25
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="PostgreSQL is a powerful, open source object-relational database system."
pkg_upstream_url="https://www.postgresql.org/"
pkg_license=('PostgreSQL')
pkg_dirname="postgresql-${pkg_version}"
pkg_source="https://ftp.postgresql.org/pub/source/v${pkg_version}/${pkg_dirname}.tar.bz2"
pkg_shasum="e4953e80415d039ccd33d34be74526a090fd585cf93f296cd9c593972504b6db"

pkg_deps=(
  core/bash
  core/glibc
  core/openssl
  core/perl
  core/readline
  core/zlib
  core/libossp-uuid

  # for postgis
  core/libxml2
  core/geos
  core/proj
  core/gdal
)

pkg_build_deps=(
  core/coreutils
  core/gcc
  core/make

  # for postgis
  core/perl
  core/diffutils
)

pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_exports=(
  [port]=port
  [superuser_name]=superuser.name
  [superuser_password]=superuser.password
)
pkg_exposes=(port)

ext_postgis_version=2.4.2
ext_postgis_source=http://download.osgeo.org/postgis/source/postgis-${ext_postgis_version}.tar.gz
ext_postgis_filename=postgis-${ext_postgis_version}.tar.gz
ext_postgis_shasum=23625bc99ed440d53a20225721095a3f5c653b62421c4d597c8038f0d7a321d9

do_before() {
  ext_postgis_dirname="postgis-${ext_postgis_version}"
  ext_postgis_cache_path="$HAB_CACHE_SRC_PATH/${ext_postgis_dirname}"
}

do_download() {
  do_default_download
  download_file $ext_postgis_source $ext_postgis_filename $ext_postgis_shasum
}

do_verify() {
  do_default_verify
  verify_file $ext_postgis_filename $ext_postgis_shasum
}

do_clean() {
  do_default_clean
  rm -rf "$ext_postgis_cache_path"
}

do_unpack() {
  do_default_unpack
  unpack_file $ext_postgis_filename
}

do_build() {
    # ld manpage: "If -rpath is not used when linking an ELF
    # executable, the contents of the environment variable LD_RUN_PATH
    # will be used if it is defined"
    ./configure --disable-rpath \
              --with-openssl \
              --prefix="$pkg_prefix" \
              --with-uuid=ossp \
              --with-includes="$LD_INCLUDE_PATH" \
              --with-libraries="$LD_LIBRARY_PATH" \
              --sysconfdir="$pkg_svc_config_path" \
              --localstatedir="$pkg_svc_var_path"
    make world

    # PostGIS can't be built until after postgresql is installed to $pkg_prefix
}

do_install() {
  make install-world

  # make and install PostGIS extension
  HAB_LIBRARY_PATH="$(pkg_path_for proj)/lib:${pkg_prefix}/lib"
  export LIBRARY_PATH="${LIBRARY_PATH}:${HAB_LIBRARY_PATH}"
  build_line "Added habitat libraries to LIBRARY_PATH: ${HAB_LIBRARY_PATH}"

  export PATH="${PATH}:${pkg_prefix}/bin"
  build_line "Added postgresql binaries to PATH: ${pkg_prefix}/bin"

  pushd "$ext_postgis_cache_path" > /dev/null

  build_line "Building ${ext_postgis_dirname}"
  ./configure --prefix="$pkg_prefix"
  make

  build_line "Installing ${ext_postgis_dirname}"
  make install

  popd > /dev/null
}
