pkg_name=msodbcsql17
pkg_origin=core
pkg_version=17.2.0.1-1
pkg_license=('MICROSOFT SOFTWARE LICENSE')
pkg_upstream_url="https://docs.microsoft.com/en-us/sql/connect/odbc/download-odbc-driver-for-sql-server?view=sql-server-2017"
pkg_description="ODBC driver for SQL server"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://packages.microsoft.com/ubuntu/18.04/prod/pool/main/m/${pkg_name}/${pkg_name}_${pkg_version}_amd64.deb"
pkg_shasum="dea625abe078bee2431bc3438e8cfb93fb224176a332308eb974855ae716eb9e"

pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

pkg_deps=(
  core/gcc-libs
  core/glibc
  core/libtool
  core/krb5
  core/openssl
  core/unixodbc
  core/util-linux
  core/zlib
)

pkg_build_deps=(
  core/binutils
  core/dpkg
  core/patchelf
)

do_unpack() {
  dpkg -x "$HAB_CACHE_SRC_PATH/$pkg_filename" "$HAB_CACHE_SRC_PATH/$pkg_dirname"
}

do_build() {
  build_line "Fixing rpath for lib:"

  find . -type f -executable \
    -exec sh -c 'file -i "$1" | grep -q "x-sharedlib; charset=binary"' _ {} \; \
    -print \
    -exec patchelf --set-rpath "${LD_RUN_PATH}" {} \;
}

do_install() {
  pushd "opt/microsoft/${pkg_name}"
  cp -vr include "${pkg_prefix}"
  cp -vr lib64/* "${pkg_prefix}/lib/"
  cp -vr share "${pkg_prefix}"
  popd
}

do_strip() {
  return 0
}
