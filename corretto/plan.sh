pkg_origin=core
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_name=corretto
# NOTE: Retrieve download link from here: https://github.com/corretto/corretto-11/releases
# More in-depth changelogs and download page is here: https://docs.aws.amazon.com/corretto/latest/corretto-11-ug/downloads-list.html
pkg_version=11.0.8.10.1
pkg_source="https://corretto.aws/downloads/resources/${pkg_version}/amazon-corretto-${pkg_version}-linux-x64.tar.gz"
pkg_shasum=dbbf98ca93b44a0c81df5a3a4f2cebf467ec5c30e28c359e26615ffbed0b454f
pkg_filename="corretto-${pkg_version}_linux-x64_bin.tar.gz"
pkg_dirname="amazon-corretto-${pkg_version}-linux-x64"
pkg_license=("GPL-2.0-only WITH Classpath-exception-2.0")
pkg_description=('Corretto is a build of the Open Java Development Kit (OpenJDK) with long-term support from Amazon.')
pkg_upstream_url=https://aws.amazon.com/corretto/
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
pkg_build_deps=(
  core/patchelf
  core/rsync
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

source_dir="${HAB_CACHE_SRC_PATH}/${pkg_dirname}"

do_setup_environment() {
 set_runtime_env JAVA_HOME "${pkg_prefix}"
}

do_build() {
  return 0
}

do_install() {
  pushd "${pkg_prefix}" || exit 1
  rsync -avz "${source_dir}/" .

  export LD_RUN_PATH="${LD_RUN_PATH}:${pkg_prefix}/lib/jli:${pkg_prefix}/lib/server:${pkg_prefix}/lib"

  build_line "Setting interpreter for all executables to '$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2'"
  build_line "Setting rpath for all libraries to '${LD_RUN_PATH}'"

  find "${pkg_prefix}"/bin -type f -executable \
    -exec sh -c 'file -i "$1" | grep -q "x-executable; charset=binary"' _ {} \; \
    -exec patchelf --set-interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" --set-rpath "${LD_RUN_PATH}" {} \;

  find "${pkg_prefix}/lib" -type f -name "*.so" \
    -exec patchelf --set-rpath "${LD_RUN_PATH}" {} \;

  popd || exit 1
}

do_strip() {
  return 0
}
