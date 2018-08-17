pkg_name=watchman
pkg_origin=core
pkg_version="4.9.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Apache-2.0")
pkg_description="Watchman exists to watch files and record when they change. It can also trigger actions (such as rebuilding assets) when matching files change."
pkg_upstream_url="https://facebook.github.io/watchman/"
pkg_source="https://github.com/facebook/${pkg_name}/archive/v${pkg_version}.tar.gz"
pkg_shasum="1f6402dc70b1d056fffc3748f2fdcecff730d8843bb6936de395b3443ce05322"


pkg_build_deps=(
  core/autoconf
  core/autogen
  core/automake
  core/diffutils
  core/gcc
  core/pkg-config
  core/make
)


pkg_deps=(
  core/gcc-libs
  core/glibc
  core/openssl
  core/pcre
  core/python2
  core/zlib
)


pkg_bin_dirs=(bin)


do_setup_environment() {
  push_runtime_env PYTHONPATH "${pkg_prefix}/lib/python2.7/site-packages"
}

do_build() {
  ACLOCAL_PATH="$(pkg_path_for core/pkg-config)/share/aclocal" ./autogen.sh

  ./configure \
    --prefix="${pkg_prefix}" \
    --enable-conffile="${pkg_svc_config_path}/watchman.json" \
    --enable-statedir="${pkg_svc_var_path}" \
    --with-pcre \
    --with-python

  make
}
