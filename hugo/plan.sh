pkg_name=hugo
pkg_origin=core
pkg_version=0.59.1
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Apache-2.0")
pkg_description="Hugo is one of the most popular open-source static site generators."
pkg_build_deps=(
  core/gcc
  core/git
  core/go
)
pkg_deps=(
  core/gcc-libs
  core/glibc
)
pkg_bin_dirs=(bin)
pkg_repository="https://github.com/gohugoio/hugo.git"
pkg_upstream_url="https://gohugo.io"

do_build() {
  local hugo_dir="${HAB_CACHE_SRC_PATH}/hugo-${pkg_version}"
  git clone \
    --depth 1 \
    --branch "v${pkg_version}" \
    --config advice.detachedHead=false \
    "${pkg_repository}" \
    "${hugo_dir}"

  pushd "${hugo_dir}" > /dev/null
  go install -tags extended
  local build_date
  build_date=$(date -Iseconds -u)
  go build -o hugo -ldflags "-X github.com/gohugoio/hugo/common/hugo.buildDate=${build_date}" -tags extended main.go
  popd > /dev/null
}

do_install() {
  install -D "${HAB_CACHE_SRC_PATH}/hugo-${pkg_version}/${pkg_name}" "${pkg_prefix}/bin/${pkg_name}"
}
