pkg_name=postfix
pkg_origin=core
pkg_version="3.6.12"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Postfix is a free and open-source mail transfer agent that routes and delivers electronic mail."
pkg_upstream_url="http://www.postfix.org/"
pkg_license=('IPL-1.0')
pkg_source="https://ghostarchive.org/postfix/postfix-release/official/postfix-${pkg_version}.tar.gz"
pkg_shasum="411c29e089e9c8fe93db60c8f36adfe9c62a54f087bb47afdf08b20c6c072f69"
pkg_build_deps=(
  core/make
  core/gcc
  core/sed
  core/gawk
  core/m4
  core/patch
  core/cacerts
)
pkg_deps=(
  # postfix deps
  core/coreutils
  core/cyrus-sasl
  core/db
  core/glibc
  core/libnsl
  core/openssl11
  core/pcre
  core/zlib
  # plan/hook deps
  core/shadow
  core/iana-etc
)
pkg_bin_dirs=(bin sbin)
pkg_svc_user=root

do_prepare() {
	export SSL_CERT_FILE="$(pkg_path_for core/cacerts)/ssl/certs/cacert.pem"
}

do_build() {
  POSTFIX_CCARGS=(
    -DHAS_DB
      -"I$(pkg_path_for db)/include"
    -DHAS_NIS
      -"I$(pkg_path_for core/libnsl)/include"
    -DUSE_TLS
      -"I$(pkg_path_for core/openssl11)/include"
    -DUSE_SASL_AUTH -DUSE_CYRUS_SASL
      -"I$(pkg_path_for core/cyrus-sasl)/include/sasl"
  )
  build_line "Setting POSTFIX_CCARGS=${POSTFIX_CCARGS[*]}"

  POSTFIX_AUXLIBS=(
    -ldb
      -"L$(pkg_path_for core/db)/lib"
    -lnsl
      -"L$(pkg_path_for core/libnsl)/lib"
    -lresolv
      -"L$(pkg_path_for core/glibc)/lib"
    -lssl -lcrypto
      -"L$(pkg_path_for core/openssl11)/lib"
    -lsasl2
      -"L$(pkg_path_for core/cyrus-sasl)/lib"
  )
  build_line "Setting POSTFIX_AUXLIBS=${POSTFIX_AUXLIBS[*]}"

  make makefiles CCARGS="${POSTFIX_CCARGS[*]}" AUXLIBS="${POSTFIX_AUXLIBS[*]}"
  make
}

do_install() {
  # Remove the override to PATH in postfix-install
  sed -i '/^PATH=/c\ ' postfix-install

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
