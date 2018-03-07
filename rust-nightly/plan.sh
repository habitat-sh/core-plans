pkg_name=rust-nightly
_distname=rust
pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
Rust is a systems programming language that runs blazingly fast, prevents \
segfaults, and guarantees thread safety.\
"
pkg_upstream_url="https://www.rust-lang.org/"
pkg_license=('Apache-2.0' 'MIT')
_url_base="http://static.rust-lang.org/dist"
pkg_source="$_url_base/${_distname}-nightly-x86_64-unknown-linux-gnu.tar.gz"
pkg_dirname="${_distname}-nightly-x86_64-unknown-linux-gnu"
pkg_deps=(
  core/glibc
  core/gcc-libs
  core/zlib
  core/gcc
  core/cacerts
  core/busybox-static
)
pkg_build_deps=(
  core/patchelf
  core/findutils
  core/coreutils
  core/sed
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

_target_sources=(
  $_url_base/${_distname}-std-nightly-x86_64-unknown-linux-musl.tar.gz
)

# Will be populated in `_download_shasums()`
_target_shasums=()

pkg_version() {
  # Takes the contents of the version file which looks like:
  #     1.24.0-nightly (560a5da9f 2017-11-27)
  # and produces a version string like:
  #     1.24.0-2017-11-27
  local v
  v="$(cat "$CACHE_PATH/version")"
  echo "$(\
    echo "$v" | cut -d ' ' -f 1 | sed 's,-nightly$,,')-$(\
    echo "$v" | cut -d ' ' -f 3 | sed 's,)$,,')"
}

do_download() {
  _download_shasums

  do_default_download

  # Download all target sources, providing the corresponding shasums so we can
  # skip re-downloading if already present and verified
  for i in $(seq 0 $((${#_target_sources[@]} - 1))); do
    p="${_target_sources[$i]}"
    download_file "$p" "$(basename "$p")" "${_target_shasums[$i]}"
  done; unset i p
}

do_verify() {
  do_default_verify

  # Verify all target sources against their shasums
  for i in $(seq 0 $((${#_target_sources[@]} - 1))); do
    verify_file "$(basename "${_target_sources[$i]}")" "${_target_shasums[$i]}"
  done; unset i
}

do_unpack() {
  do_default_unpack

  pushd "$HAB_CACHE_SRC_PATH/$pkg_dirname" > /dev/null
    # Unpack all targets inside the main source directory
    for i in $(seq 0 $((${#_target_sources[@]} - 1))); do
      tar xf "$HAB_CACHE_SRC_PATH/$(basename "${_target_sources[$i]}")"
    done; unset i
  popd > /dev/null

  update_pkg_version
}

do_build() {
  return 0
}

do_install() {
  ./install.sh --prefix="$pkg_prefix" --disable-ldconfig

  # Update the dynamic linker & set `RUNPATH` for all ELF binaries under `bin/`
  for b in rustc cargo rustdoc; do
    patchelf \
      --interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" \
      --set-rpath "$LD_RUN_PATH" \
      "$pkg_prefix/bin/$b"
  done; unset b

  # Going to want to write a cargo wrapper
  #    SSL_CERT_FILE=$(pkg_path_for cacerts)/ssl/cert.pem \

    # Set `RUNPATH` for all shared libraries under `lib/`
  find "$pkg_prefix/lib" -name "*.so" -print0 \
    | xargs -0 -I '%' patchelf \
      --set-rpath "$LD_RUN_PATH" \
      %

  # Install all targets
  local dir
  for i in $(seq 0 $((${#_target_sources[@]} - 1))); do
    dir="$(basename "${_target_sources[$i]/%.tar.gz/}")"
    pushd "$HAB_CACHE_SRC_PATH/$pkg_dirname/$dir" > /dev/null
      build_line "Installing $dir target for Rust"
      ./install.sh --prefix="$("$pkg_prefix/bin/rustc" --print sysroot)"
    popd > /dev/null
  done; unset i

  # Add a wrapper for cargo to properly set SSL certificates
  wrap_with_cert_path cargo
}

wrap_with_cert_path() {
  local bin="$pkg_prefix/bin/$1"
  build_line "Adding wrapper $bin to ${bin}.real"
  mv -v "$bin" "${bin}.real"
  cat <<EOF > "$bin"
#!$(pkg_path_for busybox-static)/bin/sh
set -e
export SSL_CERT_FILE="$(pkg_path_for cacerts)/ssl/cert.pem"
exec ${bin}.real \$@
EOF
  chmod -v 755 "$bin"
}

do_strip() {
  return 0
}

# Downloads the sha256 checksum for the current nightly and update the value of
# `$pkg_shasum` for download verification.
_download_shasums() {
  local shasum shasum_file
  shasum_file="$(basename "${pkg_source}.sha256")"
  # Remove any pre-existing files
  rm -f "$HAB_CACHE_SRC_PATH/$shasum_file"
  download_file "${pkg_source}.sha256" "$shasum_file"

  pkg_shasum="$(cut -d ' ' -f 1 < "$HAB_CACHE_SRC_PATH/$shasum_file")"
  build_line "Updating pkg_shasum=$pkg_shasum"

  for i in "${_target_sources[@]}"; do
    shasum_file="$(basename "${i}.sha256")"
    rm -f "$HAB_CACHE_SRC_PATH/$shasum_file"
    download_file "${i}.sha256" "$shasum_file"
    shasum="$(cut -d ' ' -f 1 < "$HAB_CACHE_SRC_PATH/$shasum_file")"
    _target_shasums+=("$shasum")
  done
}
