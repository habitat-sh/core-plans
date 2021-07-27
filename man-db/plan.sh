pkg_origin=core
pkg_name=man-db
pkg_version=2.9.4
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0')
pkg_description="man-db is an implementation of the standard Unix documentation system accessed using the man command."
pkg_upstream_url=http://man-db.nongnu.org/
pkg_source="http://git.savannah.gnu.org/cgit/man-db.git/snapshot/man-db-${pkg_version}.tar.gz"
pkg_shasum=069dce8dc428ebd71d677d96033cd259aad43b6a5a86c580dfaa209e015eb304
pkg_deps=(
  core/gdbm
  core/glibc
  core/groff
  core/gzip
  core/libiconv
  core/libpipeline
  core/libtool
)
pkg_build_deps=(
  core/autoconf
  core/automake
  core/coreutils
  core/diffutils
  core/flex
  core/gcc
  core/gettext
  core/git
  core/libpipeline
  core/make
  core/m4
  core/pkg-config
)
pkg_bin_dirs=(bin sbin)
pkg_lib_dirs=(lib/man-db)

do_prepare() {
  CFLAGS="${CFLAGS} -O2 -fstack-protector-strong -Wformat -Werror=format-security "
  export CFLAGS
  build_line "Setting CFLAGS=$CFLAGS"
  CXXFLAGS="${CXXFLAGS} -O2 -fstack-protector-strong -Wformat -Werror=format-security "
  export CXXFLAGS
  build_line "Setting CXXFLAGS=$CXXFLAGS"
  CPPFLAGS="${CPPFLAGS} -Wdate-time"
  export CPPFLAGS
  build_line "Setting CPPFLAGS=$CPPFLAGS"
  LDFLAGS="${LDFLAGS} -Wl,-Bsymbolic-functions -Wl,-z,relro"
  export LDFLAGS
  build_line "Setting LDFLAGS=$LDFLAGS"

  # /var/cache/man is hard-coded in a few places. We should replace this with
  # /hab/svc/man-db/var/cache/man. Since man-db isn't run as a service, this
  # directory won't actually exist unless created manually, but it will keep us out
  # of the filesystem and in the /hab directory.
  #
  # The file that gets generated here gets written to
  # $pkg_prefix/etc/man_db.conf.
  sed -i -e "s#/var/#$pkg_svc_var_path/#g" "$CACHE_PATH/src/man_db.conf.in"

  ./bootstrap
}

do_build() {
  ./configure \
    --prefix="${pkg_prefix}" \
    --disable-setuid \
    --disable-silent-rules \
    --enable-automatic-create \
    --enable-mandirs=GNU \
    --enable-threads=posix \
    --enable-mb-groff \
    --with-gzip="$(pkg_path_for gzip)/bin/gzip" \
    --with-libiconv-prefix="$(pkg_path_for libiconv)" \
    --with-systemdtmpfilesdir="${pkg_svc_config_path}/tmpfiles.d"

  make
}

do_check() {
  make check
}

do_install() {
  do_default_install

  # Removing reference to non-existent user(--disable-setuid), inspired from Linux From Scratch:
  # http://www.linuxfromscratch.org/lfs/view/development/chapter06/man-db.html
  sed -i "s:man root:root root:g" "${pkg_svc_config_path}/tmpfiles.d/man-db.conf"
}
