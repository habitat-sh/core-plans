pkg_origin=core
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_name=openjdk13
pkg_build_version=33
pkg_build_ref=5b8a42f3905b406298b72d750b6919f6
pkg_version=13.0.0
pkg_filename=openjdk-13_linux-x64_bin.tar.gz
pkg_source="https://download.java.net/java/GA/jdk13/${pkg_build_ref}/${pkg_build_version}/GPL/${pkg_filename}"
pkg_shasum=5f547b8f0ffa7da517223f6f929a5055d749776b1878ccedbd6cc1334f4d6f4d
pkg_dirname='jdk-13'
pkg_license=('GPL-2.0-with-classpath-exception')
pkg_description=('GNU General Public License, version 2, with the Classpath Exception build of OpenJDK13')
pkg_upstream_url='https://jdk.java.net/13/'
pkg_deps=(
  core/alsa-lib
  core/freetype
  core/gcc-libs
  core/glibc
  core/libxext
  core/libxi
  core/libxrender
  core/libxtst
  core/xlib
  core/zlib
)
pkg_build_deps=(core/patchelf core/rsync)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

source_dir=$HAB_CACHE_SRC_PATH/${pkg_dirname}

do_setup_environment() {
 set_runtime_env JAVA_HOME "$pkg_prefix"
}

do_build() {
  return 0
}

do_install() {
  pushd "${pkg_prefix}" || exit 1
  rsync -avz "${source_dir}/" .

  export LD_RUN_PATH="${LD_RUN_PATH}:${pkg_prefix}/lib/server:${pkg_prefix}/lib"

  build_line "Setting interpreter for all executables to '$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2'"
  build_line "Setting rpath for all libraries to '$LD_RUN_PATH'"

  find "$pkg_prefix"/{lib,bin} -type f -executable \
    -exec sh -c 'file -i "$1" | grep -q "x-executable; charset=binary"' _ {} \; \
    -exec patchelf --interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" --set-rpath "${LD_RUN_PATH}" {} \;

  find "$pkg_prefix/lib" -type f -name "*.so" \
    -exec patchelf --set-rpath "${LD_RUN_PATH}" {} \;

  popd || exit 1
}

do_strip() {
  return 0
}
