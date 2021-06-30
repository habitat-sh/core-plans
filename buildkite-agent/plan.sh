pkg_name=buildkite-agent
pkg_origin=core
pkg_version="3.28.1"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("MIT")
pkg_description="The Buildkite Agent is an open-source toolkit written in Golang for securely running build jobs on any device or network."
pkg_build_deps=(core/go core/coreutils core/gcc)
pkg_deps=(core/glibc)
pkg_source="https://github.com/buildkite/agent/archive/v${pkg_version}.zip"
pkg_filename="${pkg_name}-${pkg_version}.zip"
pkg_shasum=c34c19eef8438d4c527caa50a9c803fb1ab539655584062727daa9bf6fc6154e
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
