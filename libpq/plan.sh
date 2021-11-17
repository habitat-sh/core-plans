pkg_name=libpq
pkg_origin=core
pkg_version=9.6.24
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="LibPQ is the client side library for PostgreSQL, a powerful, open source object-relational database system."
pkg_upstream_url="https://www.postgresql.org/"
pkg_license=('PostgreSQL')
pkg_source="https://ftp.postgresql.org/pub/source/v${pkg_version}/postgresql-${pkg_version}.tar.bz2"
pkg_dirname="postgresql-${pkg_version}"
pkg_shasum="aeb7a196be3ebed1a7476ef565f39722187c108dd47da7489be9c4fcae982ace"

pkg_deps=(
  core/glibc
  core/openssl
  core/readline
  core/zlib
  core/libossp-uuid
)

pkg_build_deps=(
  core/coreutils
  core/gcc
  core/make
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
    pg_config
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
              --localstatedir="$pkg_svc_var_path" \
              --without-tcl --without-perl --without-python
    # making everything and throwing away all but the client side is a
    # little bit slow, but seems to be the simplest way to go
    make
}

do_install() {
    # This is straight out of the 'client-only installation' section of:
    # https://www.postgresql.org/docs/9.6/static/install-procedure.html#INSTALL
    # we could delete everthing but psql and be fine, but that is messy
    make -C src/bin install
    # not all of the include files are needed for client side, but for simplicit's sake we install them all.
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
