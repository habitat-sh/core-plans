pkg_origin=core
pkg_name=man-db
pkg_version=2.7.5
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0')
pkg_description="man-db is an implementation of the standard Unix documentation system accessed using the man command."
pkg_upstream_url=http://man-db.nongnu.org/
pkg_source="http://git.savannah.gnu.org/cgit/man-db.git/snapshot/man-db-${pkg_version}.tar.gz"
pkg_shasum=3a1af4b7f17193e45b5abdb12d935b70a7757dfe7e1a4196f6c00b500c6fca78
pkg_deps=(
  core/gdbm
  core/glibc
  core/groff
  core/gzip
  core/libiconv
)
pkg_build_deps=(
  core/coreutils
  core/diffutils
  core/flex
  core/gcc
  core/gettext
  core/libpipeline
  core/make
  core/m4
  core/pkg-config
)
pkg_bin_dirs=(bin sbin)
pkg_lib_dirs=(lib/man-db)

do_prepare() {
  export CFLAGS="${CFLAGS} -O2 -fstack-protector-strong -Wformat -Werror=format-security "
  build_line "Setting CFLAGS=$CFLAGS"
  export CXXFLAGS="${CXXFLAGS} -O2 -fstack-protector-strong -Wformat -Werror=format-security "
  build_line "Setting CXXFLAGS=$CXXFLAGS"
  export CPPFLAGS="${CPPFLAGS} -Wdate-time"
  build_line "Setting CPPFLAGS=$CPPFLAGS"
  export LDFLAGS="${LDFLAGS} -Wl,-Bsymbolic-functions -Wl,-z,relro"
  build_line "Setting LDFLAGS=$LDFLAGS"
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

do_prepare() {
  # /var/cache/man is hard-coded in a few places. We should replace this with
  # /hab/svc/man-db/var/cache/man. Since man-db isn't run as a service, this
  # directory won't actually exist unless created manually, but it will keep us out
  # of the filesystem and in the /hab directory.
  #
  # The file that gets generated here gets written to
  # $pkg_prefix/etc/man_db.conf.
  sed -i'' -e "s#/var/#$pkg_svc_var_path/#g" "$CACHE_PATH/src/man_db.conf.in"
}

do_check() {
  make check
}

do_install() {
  do_default_install

  # Removing reference to non-existent user(--disable-setuid), inspired from Linux From Scratch:
  # http://www.linuxfromscratch.org/lfs/view/development/chapter06/man-db.html
  sed -i'' "s:man root:root root:g" "${pkg_svc_config_path}/tmpfiles.d/man-db.conf"
}
