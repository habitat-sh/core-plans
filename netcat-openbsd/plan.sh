pkg_name=netcat-openbsd
pkg_origin=core
pkg_version=1.218
pkg_description="TCP/IP swiss army knife, OpenBSD variant"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_upstream_url=https://tracker.debian.org/pkg/netcat
pkg_license=('BSD-3-Clause')
pkg_source=http://ftp.debian.org/debian/pool/main/n/${pkg_name}/${pkg_name}_${pkg_version}.orig.tar.gz
pkg_shasum=a28a5d39abaf481747b1e78b4b50e96d0cdab0ffef289cba156dc11941c64857
pkg_deps=(core/glibc core/libbsd)
pkg_build_deps=(
  core/gcc
  core/make
  core/patch
  core/pkg-config
)
pkg_bin_dirs=(bin)

do_download() {
  do_default_download

  # Download patches to apply on top of the BSD code
  build_line "Downloading patches series file..."
  local patch_base_url=https://sources.debian.net/data/main/n/${pkg_name}/${pkg_version}-3/debian/patches

  download_file $patch_base_url/series series

  # Use the series file to download the patches themselves
  while read -r patchline
  do
    download_file "$patch_base_url/$patchline" "$patchline"
  done <"$HAB_CACHE_SRC_PATH/series"
}

do_prepare() {
  while read -r patchfile
  do
    build_line "Applying patch: $patchfile"
    patch -i "$HAB_CACHE_SRC_PATH/$patchfile"
  done <"$HAB_CACHE_SRC_PATH/series"
}

do_build() {
  make CFLAGS="$CFLAGS -g -O2" LDFLAGS="$LDFLAGS -Wl,--no-add-needed,--as-needed"
}

do_install() {
  mkdir -p "$pkg_prefix/bin"
  install nc "$pkg_prefix/bin/"
}
