pkg_name=rpm2cpio
pkg_origin=core
pkg_version="1.3"
pkg_maintainer="Stephen Nelson-Smith <stephen@atalanta-systems.com>"
pkg_license=("BSD")
pkg_source="https://svnweb.freebsd.org/ports/head/archivers/rpm2cpio/files/rpm2cpio?revision=340851"
pkg_filename="${pkg_name}-${pkg_version}.pl"
pkg_shasum="09651201a34771774fc4feaf5b409717e4bc052b82a89f3fc17c0cf578f8e608"
pkg_description="Simple Perl-based rpm2cpio utility"
pkg_upstream_url="https://svnweb.freebsd.org/ports/head/archivers/rpm2cpio/"

pkg_deps=(core/perl core/gzip core/xz core/bzip2)
pkg_build_deps=(core/patch core/sed)
pkg_bin_dirs=(bin)

do_unpack() {
  return 0
}

do_prepare() {
  cp ../"${pkg_filename}" rpm2cpio
  sed -e "s,%%gzip%%,$(pkg_path_for gzip)/bin/gzip,g" \
    -e "s,%%xz%%,$(pkg_path_for xz)/bin/xz,g" \
    -e "s,%%bzip2%%,$(pkg_path_for bzip2)/bin/bzip2,g" \
    -e "s,%%lzma%%,$(pkg_path_for xz)/bin/lzma,g" \
    "$PLAN_CONTEXT/hab-path.patch" \
    | patch -p0
  fix_interpreter rpm2cpio core/perl bin/perl
}

do_build() {
  return 0
}

do_install() {
  install -v -D -m 0755 rpm2cpio "$pkg_prefix/bin/rpm2cpio"
}
