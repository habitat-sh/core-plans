pkg_name=yarn
pkg_origin=core
pkg_version=0.22.0
pkg_source="https://yarnpkg.com/downloads/$pkg_version/yarn-v$pkg_version.tar.gz"
pkg_shasum=e295042279b644f2bc3ea3407a2b2fb417a200d35590b0ec535422d21cf19a09
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Yarn is a package manager for your code. It allows you to use and share code with other developers from around the world. Yarn does this quickly, securely, and reliably so you don’t ever have to worry."
pkg_upstream_url=https://yarnpkg.com/
pkg_license=('BSD-2-Clause')
pkg_bin_dirs=(bin)
pkg_build_deps=(
  core/rsync
)
pkg_deps=(
  core/coreutils
  core/node
  core/sed
)

# Yarn unpacks into dist, so fix that
do_unpack() {
  build_line "Unpacking $pkg_filename"
  pushd "$HAB_CACHE_SRC_PATH" > /dev/null
    mkdir -pv "$pkg_dirname"
    tar --strip-components=1 --directory="$pkg_dirname" -xf "$pkg_filename"
  popd > /dev/null
}

do_build() {
  return 0
}

do_install() {
  rsync --archive --relative \
    --exclude bin/node-gyp \
    --exclude bin/yarnpkg \
    --exclude bin/yarn.cmd \
    --exclude end_to_end_tests \
    . "$pkg_prefix"
}
