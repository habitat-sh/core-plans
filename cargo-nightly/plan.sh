pkg_name=cargo-nightly
pkg_origin=core
pkg_description="The Rust package manager"
pkg_version=_set_from_downloaded_tar_file_
pkg_license=('Apache-2.0' 'MIT')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
_url_base=https://static.rust-lang.org/cargo-dist
pkg_source=$_url_base/${pkg_name}-x86_64-unknown-linux-gnu.tar.gz
pkg_upstream_url=https://github.com/rust-lang/cargo
pkg_dirname=${pkg_name}-x86_64-unknown-linux-gnu
pkg_bin_dirs=(bin)
pkg_deps=(core/glibc core/gcc-libs core/zlib core/gcc core/cacerts)
pkg_build_deps=(core/patchelf core/coreutils)

do_download() {
  download_file $pkg_source "$pkg_filename"
  download_file ${pkg_source}.sha256 "${pkg_filename}.sha256"
  pkg_shasum="$(cut -d ' ' -f 1 "$HAB_CACHE_SRC_PATH/${pkg_filename}.sha256")"
  build_line "Setting pkg_shasum=$pkg_shasum from ${pkg_source}.sha256"
}

do_unpack() {
  do_default_unpack
  update_pkg_version
}

do_build() {
  return 0
}

do_install() {
  ./install.sh --prefix="$pkg_prefix" --disable-ldconfig
  # Update the dynamic linker & set `RUNPATH` for all ELF binaries under `bin/`
  patchelf \
    --interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" \
    --set-rpath "$LD_RUN_PATH" \
    "$pkg_prefix/bin/cargo"
}

do_strip() {
  return 0
}

update_pkg_version() {
  # Find the version in the extracted src directory in the `version` file
  pkg_version=$(cut -d '-' -f 1 "$HAB_CACHE_SRC_PATH/$pkg_dirname/version")
  build_line "Version updated to $pkg_version from extracted distribution"
  # Several metadata values get their defaults from the value of `$pkg_version`
  # so we must update these as well
  pkg_prefix=$HAB_PKG_PATH/${pkg_origin}/${pkg_name}/${pkg_version}/${pkg_release}
  pkg_artifact="$HAB_CACHE_ARTIFACT_PATH/${pkg_origin}-${pkg_name}-${pkg_version}-${pkg_release}-${pkg_target}.${_artifact_ext}"
}
