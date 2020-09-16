pkg_name=postgresql-client
pkg_version=9.6.11
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="PostgreSQL is a powerful, open source object-relational database system."
pkg_upstream_url="https://www.postgresql.org/"
pkg_license=('PostgreSQL')
pkg_dirname="postgresql-${pkg_version}"
pkg_source="https://ftp.postgresql.org/pub/source/v${pkg_version}/${pkg_dirname}.tar.bz2"
pkg_shasum="38250adc69a1e8613fb926c894cda1d01031391a03648894b9a6e13ff354a530"

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

# These commands only make sense for if there's a postgres server
# running locally, and in that case can use the versions that came
# with that install

server_execs=(
    ecpg
    initdb
    pg_archivecleanup
    pg_controldata
    pg_resetxlog
    pg_rewind
    pg_test_fsync
    pg_test_timing
    pg_upgrade
    pg_xlogdump
)

server_includes=(
    postgresql/informix
    postgresql/server
)

ext_postgis_version=2.4.2
ext_postgis_source=http://download.osgeo.org/postgis/source/postgis-${ext_postgis_version}.tar.gz
ext_postgis_filename=postgis-${ext_postgis_version}.tar.gz
ext_postgis_shasum=23625bc99ed440d53a20225721095a3f5c653b62421c4d597c8038f0d7a321d9

do_before() {
  ext_postgis_dirname="postgis-${ext_postgis_version}"
  ext_postgis_cache_path="$HAB_CACHE_SRC_PATH/${ext_postgis_dirname}"
}

# Unset copy of service files
do_begin() {
  return 0
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
	make -C src/bin install
	make -C src/include install
	make -C src/interfaces install

	# Clean up files needed only for server installs
    # this shrinks the package by about 60%
    echo "Purging unneeded execs"
    for unneeded in "${server_execs[@]}"
    do
       target="$pkg_prefix/bin/${unneeded}"
       echo "rm -f ${target}"
       rm -f "${target}"
    done
    echo "Purging unneeded includes"
    for unneeded in "${server_includes[@]}"
    do
       target="$pkg_prefix/include/${unneeded}"
       echo "rm -rf ${target}"
       rm -rf "${target}"
    done
}
