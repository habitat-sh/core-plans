pkg_name=llvm
pkg_origin=core
pkg_version=5.0.1
pkg_license=('NCSA')
pkg_description="Next-gen compiler infrastructure"
pkg_upstream_url="http://llvm.org/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_filename="${pkg_name}-${pkg_version}.src.tar.xz"
pkg_source="http://llvm.org/releases/${pkg_version}/${pkg_name}-${pkg_version}.src.tar.xz"
pkg_shasum="5fa7489fc0225b11821cab0362f5813a05f2bcf2533e8a4ea9c9c860168807b0"
pkg_deps=(
  core/coreutils
  core/gcc-libs
  core/glibc
  core/python2
  core/zlib
)
pkg_build_deps=(
  core/cmake
  core/diffutils
  core/gcc
  core/make
)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)

do_unpack() {
  # The tarball's structure has `.src` as part of the base directory.
  # This reimplements a large portion of the default unpack, only to
  # add `--strip` to the tar command.
  # There may be some more awesome way to do this - I don't know that yet.
  build_line "Unpacking $pkg_filename to custom cache dir"
  local source_file=$HAB_CACHE_SRC_PATH/$pkg_filename
  # we want to keep the src as some later dependencies require it
  local unpack_dir="${pkg_prefix}/src"
  mkdir -p "$unpack_dir"
  pushd "$unpack_dir" > /dev/null || exit
  # Per tar's help output:
  #
  #   --no-same-owner        extract files as yourself (default for ordinary users)
  #
  # The llvm package has some files owned by specific UIDs that we
  # can't be sure exist on the builder or target system.
  tar xf "$source_file" --strip 1 --no-same-owner
  popd > /dev/null || exit
}

do_build() {
  mkdir -p build
  cd build || exit
  cmake \
    -DCMAKE_INSTALL_PREFIX:PATH="$pkg_prefix" \
    -DCMAKE_BUILD_TYPE=Release \
    -G "Unix Makefiles" "${pkg_prefix}/src"
  make
}

do_check() {
  cd build || exit
  make test
}

do_install() {
  cd build || exit
  make install

  # fix the interpreters in the `src`
  _fix_interpreter_in_path "$pkg_prefix/src" '*.py' core/python2 bin/python
  _fix_interpreter_in_path "$pkg_prefix/src" '*.py' core/coreutils bin/env
  _fix_interpreter_in_path "$pkg_prefix/src" '*.sh' core/coreutils bin/env
}

do_strip() {
  build_line "Stripping unneeded symbols from binaries and libraries"
  # we need to skip the src folder
  for folder in bin include lib; do
    find "$pkg_prefix/$folder" -type f -perm -u+w -print0 2> /dev/null \
      | while read -rd '' f; do
        case "$(file -bi "$f")" in
          *application/x-executable*) strip --strip-all "$f";;
          *application/x-sharedlib*) strip --strip-unneeded "$f";;
          *application/x-archive*) strip --strip-debug "$f";;
          *) continue;;
          esac
      done
  done
}

# private #
_fix_interpreter_in_path() {
  local path=$1
  local fileending=$2
  local pkg=$3
  local int=$4

  # shellcheck disable=SC2016
  # I need these to be evaluated at exec time
  find "$path" -name "$fileending" -type f \
    -exec grep -Iq . {} \; \
    -exec sh -c 'head -n 1 "$1" | grep -q "$2"' _ {} "$int" \; \
    -exec sh -c 'echo "$1"' _ {} \; > /tmp/fix_interpreter_in_path_list

  grep -v '^ *#' < /tmp/fix_interpreter_in_path_list | while IFS= read -r line
  do
    fix_interpreter "$line" "$pkg" "$int"
  done
  rm -rf /tmp/fix_interpreter_in_path_list
}
