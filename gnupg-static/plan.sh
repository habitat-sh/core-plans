source ../gnupg/plan.sh

pkg_name=gnupg-static
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_version=1.4.23
pkg_license=('GPL-3.0-or-later')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="GnuPG is a complete and free implementation of the OpenPGP standard as defined by RFC4880 (also known as PGP). \
  This is a statically compiled version of GnuPG."
pkg_upstream_url="https://gnupg.org/"
pkg_source=ftp://ftp.gnupg.org/gcrypt/${pkg_distname}/${pkg_distname}-${pkg_version}.tar.bz2
pkg_distname=gnupg
pkg_dirname=${pkg_distname}-${pkg_version}

# Throw the run deps into build deps as this will be static
pkg_build_deps=("${pkg_deps[@]}" "${pkg_build_deps[@]}")
# Empty out the run deps array
pkg_deps=()


do_prepare() {
  LDFLAGS="-static $LDFLAGS"
  build_line "Updating LDFLAGS=$LDFLAGS"
}
