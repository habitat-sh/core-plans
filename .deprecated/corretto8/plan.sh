source "../corretto/plan.sh"

pkg_origin=core
pkg_name=corretto8
pkg_version=8.202.08.2
pkg_description=('Corretto is a build of the Open Java Development Kit (OpenJDK) with long-term support from Amazon.')
pkg_license=("GPL-2.0-only")
pkg_upstream_url=https://aws.amazon.com/corretto/
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://d2znqt9b1bc64u.cloudfront.net/amazon-corretto-${pkg_version}-linux-x64.tar.gz"
pkg_shasum=c19a928687479e1036ff1d6e023975402d2f027d9b3e4d64cfaf0c9f35bf9669
pkg_filename="corretto-${pkg_version}_linux-x64_bin.tar.gz"
pkg_dirname="amazon-corretto-${pkg_version}-linux-x64"

do_setup_environment() {
 set_runtime_env JAVA_HOME "${pkg_prefix}"
}

do_build() {
  return 0
}

do_install() {
  pushd "${pkg_prefix}" || exit 1
  rsync -avz "${HAB_CACHE_SRC_PATH}/${pkg_dirname}/" .

  LD_RUN_PATH="${LD_RUN_PATH}:${pkg_prefix}/lib/amd64/jli"
  LD_RUN_PATH="${LD_RUN_PATH}:${pkg_prefix}/lib/server"
  LD_RUN_PATH="${LD_RUN_PATH}:${pkg_prefix}/lib/amd64"
  LD_RUN_PATH="${LD_RUN_PATH}:${pkg_prefix}/jre/lib/amd64"
  LD_RUN_PATH="${LD_RUN_PATH}:${pkg_prefix}/jre/lib/amd64/server"
  export LD_RUN_PATH

  build_line "Setting interpreter for all executables to '$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2'"
  build_line "Setting rpath for all libraries to '${LD_RUN_PATH}'"

  find "${pkg_prefix}"/bin -type f -executable \
    -exec sh -c 'file -i "$1" | grep -q "x-executable; charset=binary"' _ {} \; \
    -exec patchelf --set-interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" --set-rpath "${LD_RUN_PATH}" {} \;

  find "${pkg_prefix}"/jre/bin -type f -executable \
    -exec sh -c 'file -i "$1" | grep -q "x-executable; charset=binary"' _ {} \; \
    -exec patchelf --set-interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" --set-rpath "${LD_RUN_PATH}" {} \;

  find "${pkg_prefix}/lib" -type f -name "*.so" \
    -exec patchelf --set-rpath "${LD_RUN_PATH}" {} \;

  find "${pkg_prefix}/jre/lib" -type f -name "*.so" \
    -exec patchelf --set-rpath "${LD_RUN_PATH}" {} \;

  popd || exit 1
}

do_strip() {
  return 0
}
