pkg_name=nmap
pkg_origin=core
pkg_version=7.91
pkg_description="nmap is a free security scanner for network exploration and security audits"
pkg_upstream_url="https://nmap.org/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0')
pkg_source="https://nmap.org/dist/${pkg_name}-${pkg_version}.tar.bz2"
pkg_shasum=18cc4b5070511c51eb243cdd2b0b30ff9b2c4dc4544c6312f75ce3a67a593300
pkg_deps=(
  core/glibc
  core/gcc-libs
  core/libpcap
  core/libssh2
  core/openssl
  core/pcre
  core/zlib
)
pkg_build_deps=(
  core/bzip2
  core/coreutils
  core/diffutils
  core/file
  core/gcc
  core/inetutils
  core/lua
  core/make
  core/openssh
  core/pkg-config
  core/readline
  core/which
)

pkg_bin_dirs=(bin)

do_prepare() {
  export CFLAGS="${CFLAGS} -O2 -Wcpp"
  export CXXFLAGS="${CXXFLAGS} -O2 -Wcpp"

  if [[ ! -r /usr/bin/file ]]; then
    ln -sv "$(pkg_path_for file)/bin/file" /usr/bin/file
    _clean_file=true
  fi
}

do_build() {
  ./configure --prefix="${pkg_prefix}" \
    --without-zenmap \
    --with-libdnet=included \
    --with-liblinear=included \
    --with-liblua="$(pkg_path_for "core/lua")" \
    --with-libpcre="$(pkg_path_for "core/pcre")" \
    --with-libssh2="$(pkg_path_for "core/libssh2")" \
    --with-libz="$(pkg_path_for "core/zlib")"
  make
}

do_check() {
  make check
}

do_end() {
  if [[ -n "$_clean_file" ]]; then
    rm -fv /usr/bin/file
  fi
}
