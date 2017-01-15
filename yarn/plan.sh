pkg_name=yarn
pkg_origin=core
pkg_version=0.18.1
pkg_source="https://yarnpkg.com/downloads/$pkg_version/yarn-v$pkg_version.tar.gz"
pkg_shasum=7d16699c8690ef145e1732004266fb82a32b0c06210a43c624986d100537b5a8
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
