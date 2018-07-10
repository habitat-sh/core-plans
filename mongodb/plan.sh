pkg_name=mongodb
pkg_origin=core
pkg_version=3.6.4
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="High-performance, schema-free, document-oriented database"
pkg_license=('AGPL-3.0')
pkg_source=https://fastdl.mongodb.org/src/mongodb-src-r3.6.4.tar.gz
pkg_shasum=1a9697c3ad2f5545b5160d5e32d5f3c0f6f0a3371ceb9fa85961aec513acd7ac
pkg_upstream_url=https://www.mongodb.com/
pkg_filename=${pkg_name}-src-r${pkg_version}.tar.gz
pkg_dirname=${pkg_name}-src-r${pkg_version}
pkg_deps=(
  core/coreutils
  core/gcc-libs
  core/glibc
  core/openssl
)
pkg_build_deps=(
  core/gcc
  core/glibc
  core/python2
  core/scons/2.5.1
  core/openssl
  core/patchelf
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_svc_run="mongod --config ${pkg_svc_config_path}/mongod.conf"
pkg_exports=(
  [port]=mongod.net.port
)
pkg_exposes=(port)

do_prepare() {
  CC="$(pkg_path_for core/gcc)/bin/gcc"
  CXX="$(pkg_path_for core/gcc)/bin/g++"
  export CC
  export CXX

  # create variables for our include and library pathes in a scons friendly format
  # shellcheck disable=SC2001
  INCPATH="$(echo "${CFLAGS}" | sed -e "s@-I@@g")"
  # shellcheck disable=SC2001
  INCPATH="$(echo "${INCPATH}" | sed -e "s@ @', '@g")"
  # shellcheck disable=SC2001
  LIBPATH="$(echo "${LDFLAGS}" | sed -e "s@-L@@g")"
  # shellcheck disable=SC2001
  LIBPATH="$(echo "${LIBPATH}" | sed -e "s@ @', '@g")"
  export LIBPATH
  export INCPATH

  # because scons dislikes saving our variables, we will save our
  # variables within the construct ourselves
  sed -i "891s@**envDict@ENV = os.environ, CPPPATH = ['$INCPATH'], LIBPATH = ['$LIBPATH'], CFLAGS = os.environ['CFLAGS'], CXXFLAGS = os.environ['CXXFLAGS'], LINKFLAGS = os.environ['LDFLAGS'], CC = os.environ['CC'], CXX = os.environ['CXX'], PATH = os.environ['PATH'], **envDict@g" SConstruct
}

do_build() {
  # This is currently necessary because MongoDB still uses Python 2.x
  # When it supports Python 3.x, this line will be unnecessary
  pip install typing pyyaml cheetah3

  scons core --disable-warnings-as-errors --prefix="${pkg_prefix}" --ssl -j"$(nproc)"
}

do_install() {
  scons install --disable-warnings-as-errors --prefix="${pkg_prefix}" --ssl
  patchelf --set-rpath "${LD_RUN_PATH}" "${pkg_prefix}/bin/mongod"
  patchelf --set-rpath "${LD_RUN_PATH}" "${pkg_prefix}/bin/mongo"
  patchelf --set-rpath "${LD_RUN_PATH}" "${pkg_prefix}/bin/mongoperf"
  patchelf --set-rpath "${LD_RUN_PATH}" "${pkg_prefix}/bin/mongos"
  fix_interpreter "${pkg_prefix}/bin/install_compass" core/coreutils bin/env
}

do_strip() {
  return 0
}
