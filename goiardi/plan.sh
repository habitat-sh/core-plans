pkg_name=goiardi
pkg_origin=core
pkg_version=0.11.10
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Apache-2.0")
pkg_description="A Chef server written in Go"
pkg_upstream_url="http://goiardi.gl"
pkg_source="https://github.com/ctdk/goiardi/archive/v${pkg_version}.tar.gz"
pkg_shasum=74bb265eaef7d9d470a8ccce7bef651aaff41e314cd177a11ad6493ff0179345
pkg_deps=(
  core/glibc
)
pkg_build_deps=(
  core/go
  core/git
)
pkg_bin_dirs=(bin)

do_build() {
  local build_dir="${HAB_CACHE_SRC_PATH}/goiardi-${pkg_version}"
  mkdir -p "${build_dir}"
  pushd "${build_dir}" > /dev/null
  go mod init
  go build
  popd > /dev/null
}

do_install() {
  install -D "${pkg_name}" "${pkg_prefix}/bin/${pkg_name}"
}
