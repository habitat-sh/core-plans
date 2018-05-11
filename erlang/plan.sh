pkg_name=erlang
pkg_origin=core
pkg_version=20.0
pkg_description="A programming language for massively scalable soft real-time systems."
pkg_upstream_url="http://www.erlang.org/"
pkg_dirname=otp_src_${pkg_version}
pkg_license=('Apache-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=http://www.erlang.org/download/otp_src_${pkg_version}.tar.gz
pkg_filename=otp_src_${pkg_version}.tar.gz
pkg_shasum=fe80e1e14a2772901be717694bb30ac4e9a07eee0cc7a28988724cbd21476811
pkg_deps=(core/glibc core/zlib core/ncurses core/openssl core/sed)
pkg_build_deps=(core/coreutils core/gcc core/make core/openssl core/perl core/m4)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)

do_prepare() {
  # The `/bin/pwd` path is hardcoded, so we'll add a symlink if needed.
  if [[ ! -r /bin/pwd ]]; then
    ln -sv "$(pkg_path_for coreutils)/bin/pwd" /bin/pwd
    _clean_pwd=true
  fi

  if [[ ! -r /bin/rm ]]; then
    ln -sv "$(pkg_path_for coreutils)/bin/rm" /bin/rm
    _clean_rm=true
  fi
}

do_build() {
  sed -i 's/std_ssl_locations=.*/std_ssl_locations=""/' erts/configure.in
  sed -i 's/std_ssl_locations=.*/std_ssl_locations=""/' erts/configure
  ./configure --prefix="${pkg_prefix}" \
              --enable-threads \
              --enable-smp-support \
              --enable-kernel-poll \
              --enable-dynamic-ssl-lib \
              --enable-shared-zlib \
              --enable-hipe \
              --with-ssl="$(pkg_path_for openssl)" \
              --with-ssl-include="$(pkg_path_for openssl)/include" \
              --without-javac
  make
}

do_end() {
  # Clean up the `pwd` link, if we set it up.
  if [[ -n "$_clean_pwd" ]]; then
    rm -fv /bin/pwd
  fi

  if [[ -n "$_clean_rm" ]]; then
    rm -fv /bin/rm
  fi
}
