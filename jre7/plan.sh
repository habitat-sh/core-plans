pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_name=jre7
pkg_version=7u80
pkg_source=https://www.dropbox.com/s/77b7n7wkjzpzhfd/jre-${pkg_version}-linux-x64.tar.gz
pkg_shasum=4c01efd0d8e80bb6e2f324ec3408ce64f066d4506c7ec93a491f615a4523f4f3
pkg_filename=jre-${pkg_version}-linux-x64.tar.gz
pkg_license=('Oracle Binary Code License Agreement for the Java SE Platform Products and JavaFX')
pkg_description=('Oracle Java Runtime Environment. This package is made available to you to allow you to run your applications as provided in and subject to the terms of the Oracle Binary Code License Agreement for the Java SE Platform Products and JavaFX, found at http://www.oracle.com/technetwork/java/javase/terms/license/index.html')
pkg_upstream_url=http://www.oracle.com/technetwork/java/javase/overview/index.html
pkg_deps=(core/glibc core/gcc-libs)
pkg_build_deps=(core/patchelf)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

source_dir=$HAB_CACHE_SRC_PATH/${pkg_name}-${pkg_version}

do_unpack() {
  local unpack_file="$HAB_CACHE_SRC_PATH/$pkg_filename"
  mkdir "$source_dir"
  pushd "$source_dir" >/dev/null
  tar xz --strip-components=1 -f "$unpack_file"

  popd > /dev/null
  return 0
}

do_build() {
  return 0
}

do_install() {
  cd "$source_dir" || exit
  cp -r ./* "$pkg_prefix"

  build_line "Setting interpreter for '${pkg_prefix}/bin/java' '$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2'"
  build_line "Setting rpath for '${pkg_prefix}/bin/java' to '$LD_RUN_PATH'"

  export LD_RUN_PATH=$LD_RUN_PATH:$pkg_prefix/lib/amd64/jli:$pkg_prefix/lib/amd64/server:$pkg_prefix/lib/amd64

  find "$pkg_prefix"/bin -type f -executable \
    -exec sh -c 'file -i "$1" | grep -q "x-executable; charset=binary"' _ {} \; \
    -exec patchelf --interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" --set-rpath "${LD_RUN_PATH}" {} \;

  find "$pkg_prefix/lib/amd64" -name '*.so' -type f \
    -exec patchelf --set-rpath "${LD_RUN_PATH}" {} \;
}

do_strip() {
  return 0
}
