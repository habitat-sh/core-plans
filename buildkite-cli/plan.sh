pkg_name=buildkite-cli
pkg_origin=core
pkg_version="0.5.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("MIT")
pkg_description="A command line interface for Buildkite"
pkg_build_deps=(core/go core/coreutils core/gcc core/cacerts)
pkg_deps=(core/glibc core/git core/buildkite-agent)
pkg_source="https://github.com/buildkite/cli/archive/v${pkg_version}.tar.gz"
pkg_filename="${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum=52ae1d2fd8af526d9314abc2d95e41e4e8318bb60a51a61979dd3d382999215d
pkg_upstream_url="https://buildkite.com"
pkg_bin_dirs=(bin)

do_begin() {
  export GOPATH="/hab/cache"
  export GO111MODULE=on
  parent_go_path="${GOPATH}/src/github.com/buildkite"
}

do_clean() {
  do_default_clean
  rm -rf "${parent_go_path}"
  return $?
}

do_unpack() {
  do_default_unpack
  mv "${HAB_CACHE_SRC_PATH}/cli-${pkg_version}" "${HAB_CACHE_SRC_PATH}/${pkg_name}-${pkg_version}"
  return $?
}

do_prepare() {
  export SSL_CERT_FILE="$(pkg_path_for core/cacerts)/ssl/certs/cacert.pem"
  mkdir -p "${parent_go_path}"
  ln -s "${PWD}" "${parent_go_path}/cli"
  return $?
}

do_build() {
  pushd "${parent_go_path}/cli" > /dev/null
  go install --tags extended
  go build -o bk ./cmd/bk/main.go
  local code=$?
  popd > /dev/null

  return $code
}

do_install() {
  mkdir -p "${pkg_prefix}/bin"
  cp bk "${pkg_prefix}/bin/bk"
  return $?
}
