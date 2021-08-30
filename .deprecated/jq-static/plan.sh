pkg_name=jq-static
pkg_distname=jq
pkg_origin=core
pkg_version=1.6
pkg_license=('MIT')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/stedolan/$pkg_distname/releases/download/${pkg_distname}-${pkg_version}/jq-linux64"
pkg_upstream_url="https://stedolan.github.io/jq/"
pkg_description="jq is a lightweight and flexible command-line JSON processor."
pkg_shasum=af986793a515d500ab2d35f8d2aecd656e764504b789b66d7e1a0b727a124c44
pkg_deps=()
pkg_build_deps=(
  core/coreutils
  core/wget
)
pkg_bin_dirs=(bin)

do_unpack() {
  return 0
}

do_build() {
  return 0
}

do_install() {
  install -D "$HAB_CACHE_SRC_PATH"/"$pkg_filename" "$pkg_prefix"/bin/jq
}
