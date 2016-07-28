pkg_origin=origin
pkg_name=rpm2cpio
pkg_version='1.3'
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=('MIT')
pkg_description=('Convert .rpm files for extraction with cpio')
pkg_source='http://svnweb.freebsd.org/ports/head/archivers/rpm2cpio/files/rpm2cpio?revision=259745'
pkg_shasum=09651201a34771774fc4feaf5b409717e4bc052b82a89f3fc17c0cf578f8e608
pkg_filename=${pkg_name}
pkg_deps=(core/perl)
pkg_build_deps=()
pkg_bin_dirs=(bin)

pkg_upstream_url='http://svnweb.freebsd.org/ports/head/archivers/rpm2cpio/pkg-descr?revision=259745&view=markup'

do_unpack() {
  return 0
}

do_build() {
  mv "$HAB_CACHE_SRC_PATH"/"$pkg_filename" "$HAB_CACHE_SRC_PATH"/"$pkg_name"-"$pkg_version"/"$pkg_filename"
}

do_install() {
  mkdir -p "$pkg_prefix"/bin
  cp ./"$pkg_filename" "$pkg_prefix"/bin
  chmod +x "$pkg_prefix"/bin/"$pkg_filename"

  fix_interpreter "$pkg_prefix"/bin/"$pkg_filename" core/perl bin/perl
}
