pkg_name=mysql
pkg_origin=core
pkg_version=5.7.14
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=('GPL-2.0')
pkg_source=http://dev.mysql.com/get/Downloads/MySQL-5.7/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=f7415bdac2ca8bbccd77d4f22d8a0bdd7280b065bd646a71a506b77c7a8bd169

pkg_upstream_url=https://www.mysql.com/
pkg_description=$(cat << EOF
Starts MySQL with a basic configuration. Configurable at run time:

* root_password: the password for the mysql root user, empty by default
* app_username: the username for an application that will connect to the database server, false by default
* app_password: the password for the app user
* bind: the bind address to listen for connections, default 127.0.0.1

Set the app_username and app_password at runtime to have that user created, it won't be otherwise.
EOF
)

pkg_deps=(
  core/glibc
  core/gcc-libs
  core/coreutils
  core/sed
  core/gawk
  core/grep
  core/pcre
  core/procps-ng
  core/inetutils
  core/ncurses
  core/openssl
)

pkg_build_deps=(
  core/cmake
  core/coreutils
  core/diffutils
  core/patch
  core/make
  core/gcc
  # -- MySQL currently requires boost_1_59_0
  core/boost159
)

pkg_svc_user="hab"
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_build() {
  cmake . -DLOCAL_BOOST_DIR="$(pkg_path_for core/boost159)" \
          -DBOOST_INCLUDE_DIR="$(pkg_path_for core/boost159)"/include \
          -DWITH_BOOST="$(pkg_path_for core/boost159)" \
          -DWITH_SSL=yes \
          -DCMAKE_INSTALL_PREFIX="$pkg_prefix"
  make
}

do_check() {
  ctest
}
