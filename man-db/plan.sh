pkg_origin=core
pkg_name=man-db
pkg_version=2.7.5
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('GPL-2.0')
pkg_description="man-db is an implementation of the standard Unix documentation system accessed using the man command."
pkg_upstream_url=http://man-db.nongnu.org/
pkg_source="http://git.savannah.gnu.org/cgit/man-db.git/snapshot/man-db-${pkg_version}.tar.gz"
pkg_shasum=3a1af4b7f17193e45b5abdb12d935b70a7757dfe7e1a4196f6c00b500c6fca78
pkg_deps=(core/glibc  core/gdbm
          core/gzip   core/groff
          core/libiconv)
pkg_build_deps=(core/gcc      core/coreutils
                core/make     core/diffutils
                core/flex     core/pkg-config
                core/gettext  core/libpipeline)
pkg_bin_dirs=(bin sbin)

do_prepare() {
  export CFLAGS="${CFLAGS} -O2 -fstack-protector-strong -Wformat -Werror=format-security "
  export CXXFLAGS="${CXXFLAGS} -O2 -fstack-protector-strong -Wformat -Werror=format-security "
  export CPPFLAGS="${CPPFLAGS} -Wdate-time"
  export LDFLAGS="${LDFLAGS} -Wl,-Bsymbolic-functions -Wl,-z,relro"
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
  --with-gzip="$(pkg_path_for core/gzip)/bin/gzip" \
  --with-libiconv-prefix="$(pkg_path_for core/libiconv)" \
  --with-systemdtmpfilesdir="${pkg_svc_config_path}/tmpfiles.d"

  make -j "$(nproc)"
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
