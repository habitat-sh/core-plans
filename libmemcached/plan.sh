pkg_origin=core
pkg_name=libmemcached
pkg_version=1.0.18
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Distributed memory object caching system"
pkg_upstream_url="https://libmemcached.org/"
pkg_license=('BSD')
pkg_source="https://launchpad.net/libmemcached/1.0/${pkg_version}/+download/libmemcached-${pkg_version}.tar.gz"
pkg_shasum="e22c0bb032fde08f53de9ffbc5a128233041d9f33b5de022c0978a2149885f82"
pkg_deps=(
  core/cyrus-sasl
  core/gcc-libs
  core/glibc
)
pkg_build_deps=(
  core/coreutils
  core/diffutils
  core/gcc
  core/file
  core/make
  core/patch
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_prepare() {
  # Can be removed once https://bugs.launchpad.net/libmemcached/+bug/1663985 is fixed upstream
  patch -p1 < "${PLAN_CONTEXT}/patches/gcc7-build.patch"

  if [[ ! -r /usr/bin/file ]]; then
    ln -sv "$(pkg_path_for "core/file")/bin/file" /usr/bin/file
    _clean_file=true
  fi
}

do_build() {
  export LDFLAGS
  LDFLAGS="-L$(pkg_path_for "core/gcc-libs")/lib ${LDFLAGS}"
  do_default_build
}

do_check() {
  if [[ ! -r /bin/echo ]]; then
    ln -sv "$(pkg_path_for "core/coreutils")/bin/echo" /bin/echo
    _clean_echo=true
  fi

  make check LDFLAGS="$LDFLAGS -lstdc++"

  if [[ -n "$_clean_echo" ]]; then
    rm -fv /bin/echo
  fi
}

do_end() {
  if [[ -n "$_clean_file" ]]; then
    rm -fv /usr/bin/file
  fi
}
