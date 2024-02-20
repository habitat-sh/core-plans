pkg_name=buildkite-agent
pkg_origin=core
pkg_version="3.33.3"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("MIT")
pkg_description="The Buildkite Agent is an open-source toolkit written in Golang for securely running build jobs on any device or network."
pkg_build_deps=(core/go core/coreutils core/gcc core/cacerts)
pkg_deps=(core/glibc)
pkg_source="https://github.com/buildkite/agent/archive/v${pkg_version}.zip"
pkg_filename="${pkg_name}-${pkg_version}.zip"
pkg_shasum=d98c8265923f250686628c416c02e70f7f75ffadb8b8cff1f3c462be1075aa67
pkg_upstream_url="https://buildkite.com"
pkg_bin_dirs=(bin)

do_begin() {
  export GOPATH="/hab/cache"
  parent_go_path="${GOPATH}/src/github.com/buildkite"
}

do_clean() {
  do_default_clean
  rm -rf "${parent_go_path}"
  return $?
}

do_unpack() {
  do_default_unpack
  mv "${HAB_CACHE_SRC_PATH}/agent-${pkg_version}" "${HAB_CACHE_SRC_PATH}/${pkg_name}-${pkg_version}"
  return $?
}

do_prepare() {
  export SSL_CERT_FILE="$(pkg_path_for core/cacerts)/ssl/certs/cacert.pem"
  mkdir -p "${parent_go_path}"
  ln -s "${PWD}" "${parent_go_path}/agent"
  return $?
}

do_build() {
  pushd "${parent_go_path}/agent" > /dev/null
  go install --tags extended
  pushd "${HAB_CACHE_SRC_PATH}/${pkg_name}-${pkg_version}" > /dev/null
    go mod tidy
    go mod vendor
  popd > /dev/null
  go build -o buildkite-agent main.go
  local code=$?
  popd > /dev/null

  return $code
}

do_install() {
  mkdir -p "${pkg_prefix}/bin"
  cp "${pkg_name}" "${pkg_prefix}/bin/${pkg_name}"
  return $?
}
