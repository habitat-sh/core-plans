pkg_name=postfix
pkg_origin=core
pkg_version="3.2.4"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Postfix is a free and open-source mail transfer agent that routes and delivers electronic mail."
pkg_upstream_url="http://www.postfix.org/"
pkg_license=('IPL-1.0')
pkg_source="http://cdn.postfix.johnriley.me/mirrors/${pkg_name}-release/official/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="ec55ebaa2aa464792af8d5ee103eb68b27a42dc2b36a02fee42dafbf9740c7f6"

pkg_build_deps=(
  core/make
  core/gcc
  core/sed
  core/gawk
)

pkg_deps=(
  # postfix deps
  core/coreutils
  core/cyrus-sasl
  core/db
  core/glibc
  core/libnsl
  core/openssl
  core/pcre
  core/zlib

  # plan/hook deps
  core/shadow
  core/iana-etc
)

pkg_bin_dirs=(bin sbin)

pkg_svc_user=root


do_build() {
  POSTFIX_CCARGS=(
    -DHAS_DB
      -I$(pkg_path_for db)/include
    -DHAS_NIS
      -I$(pkg_path_for core/libnsl)/include
    -DUSE_TLS
      -I$(pkg_path_for core/openssl)/include
    -DUSE_SASL_AUTH -DUSE_CYRUS_SASL
      -I$(pkg_path_for core/cyrus-sasl)/include/sasl
  )
  build_line "Setting POSTFIX_CCARGS=${POSTFIX_CCARGS[*]}"

  POSTFIX_AUXLIBS=(
    -ldb
      -L$(pkg_path_for core/db)/lib
    -lnsl
      -L$(pkg_path_for core/libnsl)/lib
    -lresolv
      -L$(pkg_path_for core/glibc)/lib
    -lssl -lcrypto
      -L$(pkg_path_for core/openssl)/lib
    -lsasl2
      -L$(pkg_path_for core/cyrus-sasl)/lib
  )
  build_line "Setting POSTFIX_AUXLIBS=${POSTFIX_AUXLIBS[*]}"

  make makefiles CCARGS="${POSTFIX_CCARGS[*]}" AUXLIBS="${POSTFIX_AUXLIBS[*]}"
  make
}

do_install() {

  # because postfix-install ignores PATH
  hab pkg binlink core/coreutils -d /bin uname
  hab pkg binlink core/coreutils -d /bin rm
  hab pkg binlink core/coreutils -d /bin touch
  hab pkg binlink core/coreutils -d /bin mkdir
  hab pkg binlink core/coreutils -d /bin chmod
  hab pkg binlink core/coreutils -d /bin cp
  hab pkg binlink core/coreutils -d /bin mv
  hab pkg binlink core/coreutils -d /bin ln
  hab pkg binlink core/sed -d /bin sed
  hab pkg binlink core/gawk -d /bin awk


  make non-interactive-package \
    install_root="${pkg_prefix}" \
    daemon_directory="/sbin" \
    command_directory="/bin" \
    mailq_path="/bin/mailq" \
    sendmail_path="/bin/sendmail" \
    newaliases_path="/bin/newaliases" \
    shlib_directory="/lib" \
    meta_directory="/meta" \
    manpage_directory="/man" \
    config_directory="/config" \
    data_directory="/data/postfix" \
    mail_spool_directory="/data/spool" \
    queue_directory="/data/queue"

  # delete .default files that contain template-looking syntax
  rm "${pkg_prefix}/config/main.cf.default"
}
