pkg_name=clang
pkg_origin=core
pkg_version=7.1.0
pkg_license=('NCSA')
pkg_description="LLVM native C/C++/Objective-C compiler"
pkg_upstream_url="http://clang.llvm.org/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_filename="cfe-${pkg_version}.src.tar.xz"
pkg_source="http://llvm.org/releases/${pkg_version}/cfe-${pkg_version}.src.tar.xz"
pkg_shasum="e97dc472aae52197a4d5e0185eb8f9e04d7575d2dc2b12194ddc768e0f8a846d"
clang_tools_extra_shasum="1ce0042c48ecea839ce67b87e9739cf18e7a5c2b3b9a36d177d00979609b6451"
pkg_deps=(
  core/coreutils
  core/gcc-libs
  core/glibc
  core/python
  core/zlib
  core/perl
  core/gcc
)
pkg_build_deps=(
  core/llvm
  core/perl
  core/cmake
  core/diffutils
  core/ninja
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)

do_begin() {
  export HAB_ENV_CMAKE_FIND_ROOT_PATH_SEPARATOR=";"
  export HAB_ENV_CMAKE_FIND_ROOT_PATH_TYPE="aggregate"
}

do_setup_environment() {
  set_buildtime_env BUILD_DIR "_build"

  # this allows cmake users to utilize `CMAKE_FIND_ROOT_PATH` to find various cmake configs
  push_runtime_env CMAKE_FIND_ROOT_PATH "${pkg_prefix}/lib/cmake/clang"
}

do_unpack() {
  # The tarball's structure has `.src` as part of the base directory.
  # This reimplements a large portion of the default unpack, only to
  # add `--strip` to the tar command.
  # There may be some more awesome way to do this - I don't know that yet.
  build_line "Unpacking $pkg_filename to custom cache dir"
  local source_file="$HAB_CACHE_SRC_PATH/$pkg_filename"
  local unpack_dir="$HAB_CACHE_SRC_PATH/${pkg_name}-${pkg_version}"
  mkdir -p "$unpack_dir"
  pushd "$unpack_dir" > /dev/null || exit
  # Per tar's help output:
  #
  #   --no-same-owner        extract files as yourself (default for ordinary users)
  #
  # The llvm package has some files owned by specific UIDs that we
  # can't be sure exist on the builder or target system.
  tar xf "${source_file}" --strip 1 --no-same-owner
  popd > /dev/null || exit 1

  # Download clang-tools-extra (intended to be built together with clang)
  download_file http://llvm.org/releases/$pkg_version/clang-tools-extra-$pkg_version.src.tar.xz \
    clang-tools-extra-$pkg_version.src.tar.xz \
    "${clang_tools_extra_shasum}"
  build_line "Unpacking clang-tools-extra to custom cache dir"
  local clang_tools_extra_src_dir="$unpack_dir/tools/extra"
  mkdir -p "$clang_tools_extra_src_dir"
  pushd "$clang_tools_extra_src_dir" > /dev/null || exit 1
  tar xf "$HAB_CACHE_SRC_PATH/clang-tools-extra-$pkg_version.src.tar.xz" --strip 1 --no-same-owner
  popd > /dev/null || exit 1
}

do_prepare() {
  mkdir -p "${BUILD_DIR}"

  _fix_interpreter_in_path "${HAB_CACHE_SRC_PATH}/${pkg_dirname}" '*.py' core/python bin/python
  _fix_interpreter_in_path "${HAB_CACHE_SRC_PATH}/${pkg_dirname}" '*.py' core/coreutils bin/env
  _fix_interpreter_in_path "${HAB_CACHE_SRC_PATH}/${pkg_dirname}" '*.sh' core/coreutils bin/env
}

do_build() {
  pushd "${BUILD_DIR}" || exit 1
  cmake \
    -DCMAKE_INSTALL_PREFIX="${pkg_prefix}" \
    -DCLANG_BUILD_EXAMPLES=ON \
    -DLLVM_ENABLE_RTTI=ON \
    -DCMAKE_BUILD_TYPE=Release \
    -G "Ninja" \
    ..

  # ninja defaults to using 8 jobs. on machines with limited resources this becomes
  # problematic causing things not to be built and run.
  ninja -j"$(nproc --ignore=1)"
  popd || exit 1
}

do_check() {
  pushd "${BUILD_DIR}" || exit 1

  # ninja defaults to using 8 jobs. on machines with limited resources this becomes
  # problematic causing things not to be built and run.
  ninja -j"$(nproc --ignore=1)" check-clang
  popd || exit 1
}

do_install() {
  pushd "${BUILD_DIR}" || exit 1
  ninja install
  popd || exit 1

  fix_interpreter "${pkg_prefix}/bin/git-clang-format" core/coreutils bin/env
  fix_interpreter "${pkg_prefix}/bin/hmaptool" core/coreutils bin/env
  fix_interpreter "${pkg_prefix}/bin/scan-build" core/coreutils bin/env
  fix_interpreter "${pkg_prefix}/bin/scan-view" core/coreutils bin/env
  fix_interpreter "${pkg_prefix}/libexec/c++-analyzer" core/coreutils bin/env
  fix_interpreter "${pkg_prefix}/libexec/ccc-analyzer" core/coreutils bin/env
}

# private #
_fix_interpreter_in_path() {
  local path=$1
  local fileending=$2
  local pkg=$3
  local int=$4

  # shellcheck disable=SC2016
  # I need these to be evaluated at exec time
  find "${path}" -name "${fileending}" -type f \
    -exec grep -Iq . {} \; \
    -exec sh -c 'head -n 1 "$1" | grep -q "$2"' _ {} "${int}" \; \
    -exec sh -c 'echo "$1"' _ {} \; > /tmp/fix_interpreter_in_path_list

  grep -v '^ *#' < /tmp/fix_interpreter_in_path_list | while IFS= read -r line
  do
    fix_interpreter "${line}" "${pkg}" "${int}"
  done
  rm -rf /tmp/fix_interpreter_in_path_list
}
