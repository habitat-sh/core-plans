pkg_name=rust
pkg_origin=core
pkg_version=1.25.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="\
Rust is a systems programming language that runs blazingly fast, prevents \
segfaults, and guarantees thread safety.\
"
pkg_upstream_url="https://www.rust-lang.org/"
pkg_license=('Apache-2.0' 'MIT')
_url_base="http://static.rust-lang.org/dist"
pkg_source="$_url_base/${pkg_name}-${pkg_version}-x86_64-unknown-linux-gnu.tar.gz"
pkg_shasum="06fb45fb871330a2d1b32a27badfe9085847fe824c189ddc5204acbe27664f5e"
pkg_dirname="${pkg_name}-${pkg_version}-x86_64-unknown-linux-gnu"
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
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

_target_sources=(
  $_url_base/${pkg_name}-std-${pkg_version}-x86_64-unknown-linux-musl.tar.gz
)

_target_shasums=(
  665f631d852f3bdfd941239b7ba69934fff2c20e53580487d4543cb2cb42d338
)

do_download() {
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


# ----------------------------------------------------------------------------
# **NOTICE:** What follows are implementation details required for building a
# first-pass, "stage1" toolchain and environment. It is only used when running
# in a "stage1" Studio and can be safely ignored by almost everyone. Having
# said that, it performs a vital bootstrapping process and cannot be removed or
# significantly altered. Thank you!
# ----------------------------------------------------------------------------
if [[ "$STUDIO_TYPE" = "stage1" ]]; then
  pkg_build_deps=(
    core/patchelf
    core/coreutils
    core/sed
    core/grep
    core/diffutils
    core/findutils
    core/make
    core/patch
  )
fi
