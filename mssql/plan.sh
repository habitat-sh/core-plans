pkg_name=mssql
pkg_origin=core
pkg_version=14.0.1.246-6
pkg_license=('MICROSOFT PRE-RELEASE SOFTWARE LICENSE')
pkg_upstream_url=https://www.microsoft.com/en-us/sql-server/sql-server-vnext-including-Linux
pkg_description="Microsoft SQL Server for Linux"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://packages.microsoft.com/ubuntu/16.04/mssql-server/pool/main/m/mssql-server/mssql-server_${pkg_version}_amd64.deb"
pkg_shasum=508557ba5aaa76a99d3218dd0d74f69aae36cc508bd79e06fbc2e38126a69b2c
pkg_filename="mssql-server_${pkg_version}_amd64.deb"
pkg_svc_user="root"
pkg_svc_group="root"
pkg_expose=(1433)

pkg_deps=(
  core/libcxx
  core/gcc-libs
  core/glibc
  core/jemalloc
  core/openssl
  core/python2
)

pkg_build_deps=(
  core/dpkg
  core/patchelf
)

pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

do_unpack() {
  dpkg -x "$HAB_CACHE_SRC_PATH/$pkg_filename" "$HAB_CACHE_SRC_PATH/$pkg_dirname"
}

do_build() {
  return 0
}

do_install() {
  cp -a opt/mssql/bin "$pkg_prefix"
  cp -a opt/mssql/lib "$pkg_prefix"

  PYTHONPATH="$(pkg_path_for core/python2)"
  sed -i "s#/usr/bin/python#$PYTHONPATH/bin/python#" "$pkg_prefix/lib/mssql-conf/mssql-conf.py"

  find "$pkg_prefix/bin" -type f -name '*' \
    -exec patchelf --interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" --set-rpath "$LD_RUN_PATH" {} \;
  find "$pkg_prefix/lib" -type f -name '*.so*' \
    -exec patchelf --set-rpath "$LD_RUN_PATH" {} \;
}

do_strip() {
  return 0
}
