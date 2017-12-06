pkg_name=rq
pkg_origin=core
pkg_version=0.10.4
pkg_filename=record-query-v${pkg_version}-x86_64-unknown-linux-gnu.tar.gz
pkg_source=https://github.com/dflemstr/rq/releases/download/v${pkg_version}/${pkg_filename}
pkg_shasum=1b9abedd7acca1269ac1c4765d93bab73777feca9a04358ea4f9c9659bf51e62
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Record Query - A tool for doing record analysis and transformation"
pkg_upstream_url=https://github.com/dflemstr/rq
pkg_license=('Apache-2.0')
pkg_bin_dirs=(bin)
pkg_deps=(core/glibc core/gcc-libs)
pkg_build_deps=(core/patchelf)

do_unpack() {
  do_default_unpack
  # the source tarball contains a cross-compiled binary in a parent directory
  # with a vague name. here we'll rename it to the hab standard pkg_dirname
  # instead of setting pkg_dirname to this vague name.
  mv "${HAB_CACHE_SRC_PATH}/x86_64-unknown-linux-gnu" "${HAB_CACHE_SRC_PATH}/${pkg_dirname}"
}

do_build() {
  return 0
}

do_install() {
  mkdir -pv "$pkg_prefix/bin"
  install -v "rq" "$pkg_prefix/bin/$pkg_name"
}

do_strip() {
  do_default_strip
  # patching the binary after stripping unneeded symbols because strip does not
  # like the modifications patchelf makes
  patchelf --interpreter "$(pkg_path_for core/glibc)/lib/ld-linux-x86-64.so.2" \
           --set-rpath "${LD_RUN_PATH}" \
           "${pkg_prefix}/bin/rq"
}
