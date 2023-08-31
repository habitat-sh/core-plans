pkg_name=mongodb
pkg_origin=core
pkg_version=3.6.23
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="High-performance, schema-free, document-oriented database"
pkg_license=('AGPL-3.0')
pkg_source="https://fastdl.mongodb.org/src/mongodb-src-r${pkg_version}.tar.gz"
pkg_shasum=109a487ab5b8cdc189bc77ea27ae5f1bcc8db0b465527464bd87c2fa3928149e
pkg_upstream_url=https://www.mongodb.com/
pkg_filename="${pkg_name}-src-r${pkg_version}.tar.gz"
pkg_dirname="${pkg_name}-src-r${pkg_version}"
pkg_deps=(
  core/coreutils
  core/gcc-libs
  core/glibc
  core/openssl
)
pkg_build_deps=(
  core/patch
  core/coreutils
  core/binutils
  core/gcc
  core/glibc
  core/python2
  core/scons
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

  # Revert https://github.com/mongodb/mongo/commit/64d7779bdbc5b8e491a0916c92c55d162cbe8745
  # This allows us to pass in our (already sanitized) PATH/ENV
  patch SConstruct < "${PLAN_CONTEXT}"/patches/000-propagate-shell-environment.patch
}

do_build() {
  # This is currently necessary because MongoDB still uses Python 2.x
  # When it supports Python 3.x, this line will be unnecessary
  pip install typing==3.10.0.0 pyyaml==5.3.1 cheetah3==3.2.6

  scons CC="${CC}" CXX="${CXX}" CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" CPPPATH="${CFLAGS}" LINKFLAGS="${LDFLAGS}" LIBPATH="${LDFLAGS}" core --propagate-shell-environment --disable-warnings-as-errors --prefix="${pkg_prefix}" --ssl -j"$(nproc)"
}

do_install() {
  scons CC="${CC}" CXX="${CXX}" CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" CPPPATH="${CFLAGS}" LINKFLAGS="${LDFLAGS}" LIBPATH="${LDFLAGS}" install --propagate-shell-environment --disable-warnings-as-errors --prefix="${pkg_prefix}" --ssl
  patchelf --set-rpath "${LD_RUN_PATH}" "${pkg_prefix}/bin/mongod"
  patchelf --set-rpath "${LD_RUN_PATH}" "${pkg_prefix}/bin/mongo"
  patchelf --set-rpath "${LD_RUN_PATH}" "${pkg_prefix}/bin/mongoperf"
  patchelf --set-rpath "${LD_RUN_PATH}" "${pkg_prefix}/bin/mongos"
  fix_interpreter "${pkg_prefix}/bin/install_compass" core/coreutils bin/env
}

do_strip() {
  return 0
}
