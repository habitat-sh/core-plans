pkg_name=mention-bot
pkg_origin=core
pkg_version=3.0.1
pkg_description="Automatically mention potential reviewers on pull requests."
pkg_upstream_url=https://github.com/facebook/mention-bot
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('BSD-3-Clause')
pkg_source=https://github.com/facebook/mention-bot/archive/de2a15da302aad07fb246c2f5c4be85fbf2e65dd.tar.gz
pkg_shasum=2aae8e7b0b2e5e0695ec6a88a6f5ae6b3c3badae94fe49e6c9c637164e3f4df3
pkg_dirname=mention-bot-de2a15da302aad07fb246c2f5c4be85fbf2e65dd
pkg_deps=(
  core/elfutils
  core/node
)
pkg_build_deps=(
  core/glibc
  core/node
  core/patchelf
)
pkg_expose=(5000)

do_prepare() {
  npm config set spin=false
}

do_build() {
  return 0
}

do_install() {
  cp -a . "$pkg_prefix"
  cd "$pkg_prefix" || exit

  # The Flow program is shipped as a binary that hard-codes the links to GLIBC.
  # It needs to be patched so the install will work.
  npm install flow-bin
  patchelf --interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" \
    --set-rpath "$LD_RUN_PATH" \
    ./node_modules/flow-bin/vendor/flow

  npm install
  npm shrinkwrap
}
