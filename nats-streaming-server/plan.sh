pkg_name=nats-streaming-server
pkg_origin=core
pkg_version=0.21.1
pkg_description="NATS Streaming is an extremely performant, lightweight reliable streaming platform built on NATS."
pkg_upstream_url=https://github.com/nats-io/nats-streaming-server
pkg_license=('MIT')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://github.com/nats-io/nats-streaming-server/archive/v${pkg_version}.tar.gz
pkg_shasum=69dc0d80d4e494f63b8110cfbd779c3c58f4e4af2c27eb87b8cc8599e43859c9
pkg_deps=(core/glibc)
pkg_build_deps=(core/go core/coreutils core/gcc core/make)
pkg_bin_dirs=(bin)
pkg_svc_run="${pkg_name}"


do_begin() {
  export GOPATH="/hab/cache"
  parent_go_path="${GOPATH}/src/github.com/nats-io"
}

do_clean() {
  do_default_clean
  rm -rf "${parent_go_path}"
  return $?
}

do_prepare() {
  mkdir -p "${parent_go_path}"
  ln -s "${PWD}" "${parent_go_path}/${pkg_name}"
  return $?
}

do_build() {
  pushd "${parent_go_path}/${pkg_name}" > /dev/null
  go build
  local code=$?
  popd > /dev/null

  return $code
}

do_install() {
  mkdir -p "${pkg_prefix}/bin"
  cp  "${pkg_name}" "${pkg_prefix}/bin/${pkg_name}"
  return $?
}
