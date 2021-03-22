pkg_name="img"
pkg_origin="core"
pkg_version=0.5.11
pkg_description="Standalone, daemon-less, unprivileged Dockerfile and OCI compatible container image builder."
pkg_upstream_url="https://github.com/genuinetools/img"
pkg_license=('MIT')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/genuinetools/img"
pkg_bin_dirs=(bin)
pkg_deps=(
  core/git
  core/pkg-config
  core/libseccomp
)
pkg_build_deps=(
  core/go
  core/git
  core/dep
  core/make
  core/gcc
)

export GOPATH="${HAB_CACHE_SRC_PATH}/go"
export workspace_src="${GOPATH}/src"
export base_path="github.com/genuinetools"
export pkg_cache_path="${workspace_src}/${base_path}/${pkg_name}"

do_before() {
  rm -rf "${pkg_cache_path}"
  mkdir -p "${pkg_cache_path}"
}

do_download() {
  git clone https://github.com/genuinetools/img "${pkg_cache_path}"
}

do_verify() {
  return 0
}

do_unpack() {
  return 0
}

do_prepare() {
  # This changes the version of containerd that is added to fix invalid pseudo version caused by version in go.mod file.
  # This should be fixed with the next release.
  pushd "${pkg_cache_path}" >/dev/null
    go mod edit -replace github.com/containerd/containerd@3a3f0aac8819=github.com/containerd/containerd@814b795
    go get github.com/go-bindata/go-bindata/go-bindata
  popd >/dev/null
}

do_build() {
  export PATH="$PATH:${GOPATH}/bin"
  pushd "${pkg_cache_path}" >/dev/null
  make static
  popd >/dev/null
}

do_install() {
  cp -r "${pkg_cache_path}/img" "${pkg_prefix}/bin/${bin}"
}
