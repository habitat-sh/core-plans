pkg_name=mssql
pkg_origin=core
pkg_version=14.0.3421.10-2
pkg_license=('MICROSOFT PRE-RELEASE SOFTWARE LICENSE')
pkg_upstream_url=https://www.microsoft.com/en-us/sql-server/sql-server-vnext-including-Linux
pkg_description="Microsoft SQL Server for Linux"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://packages.microsoft.com/ubuntu/16.04/mssql-server-2017/pool/main/m/mssql-server/mssql-server_${pkg_version}_amd64.deb"
pkg_shasum=f9717419f7e7093da4f9ebcaac8a58e30cc8ba5dd0607115c134d1f58600cb5f
pkg_filename="mssql-server_${pkg_version}_amd64.deb"
pkg_svc_user="root"
pkg_svc_group="root"
pkg_deps=(
  core/libcxx
  core/libcxxabi
  core/gcc-libs
  core/glibc
  core/jemalloc
  core/krb5
  core/numactl
  core/openssl
  core/python2
  core/util-linux
)
pkg_build_deps=(
  core/dpkg
  core/patchelf
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_exports=(
  [port]=port
)
pkg_exposes=(port)

do_unpack() {
  dpkg -x "${HAB_CACHE_SRC_PATH}/${pkg_filename}" "${HAB_CACHE_SRC_PATH}/${pkg_dirname}"
}

do_build() {
  return 0
}

do_install() {
  cp -a opt/mssql/bin "${pkg_prefix}"
  cp -a opt/mssql/lib "${pkg_prefix}"

  PYTHONPATH="$(pkg_path_for core/python2)"
  sed -i "s#/usr/bin/python#${PYTHONPATH}/bin/python#" "${pkg_prefix}/lib/mssql-conf/mssql-conf.py"

  elfs_to_patch=(
    "${pkg_prefix}/bin/paldumper"
    "${pkg_prefix}/bin/sqlservr"
  )
  for elf in "${elfs_to_patch[@]}"; do
    patchelf \
      --interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" \
      --set-rpath "${LD_RUN_PATH}" "${elf}"
  done

  find "${pkg_prefix}/lib" -type f -name '*.so*' \
    -exec patchelf --set-rpath "${LD_RUN_PATH}" {} \;
}

do_strip() {
  return 0
}
