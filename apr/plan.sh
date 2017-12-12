pkg_name=apr
pkg_origin=core
pkg_version=1.6.3
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Apache Portable Runtime"
pkg_upstream_url="https://apr.apache.org/"
pkg_license=('Apache-2.0')
pkg_source=https://archive.apache.org/dist/apr/${pkg_name}-${pkg_version}.tar.bz2
pkg_shasum=131f06d16d7aabd097fa992a33eec2b6af3962f93e6d570a9bd4d85e95993172
pkg_deps=(
  core/gcc-libs
  core/glibc
)
pkg_build_deps=(
  core/diffutils
  core/file
  core/gcc
  core/iana-etc
  core/libossp-uuid
  core/make
)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_pconfig_dirs=(lib/pkgconfig)

do_prepare() {
  export LDFLAGS="-lgcc_s ${LDFLAGS}"

  if [[ ! -r /usr/bin/file ]]; then
    ln -sv "$(pkg_path_for file)/bin/file" /usr/bin/file
    _clean_file=true
  fi
}

do_check() {
  # If `/etc/services` does not exist, make temporary version from the
  # `iana-etc` package. This is needed for the testsock tests to pass.
  if [[ ! -f /etc/services ]]; then
    cp -v "$(pkg_path_for iana-etc)/etc/services" /etc/services
    local clean_services=true
  fi

  make test

  if [[ -n "$clean_services" ]]; then
    rm -fv /etc/services
  fi
}

do_end() {
  if [[ -n "$_clean_file" ]]; then
    rm -fv /usr/bin/file
  fi
}
