pkg_name=nats-top
pkg_origin=core
pkg_version=0.4.0
pkg_description="Top like program monitor for NATS."
pkg_upstream_url=https://github.com/nats-io/nats-top
pkg_license=('MIT')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://github.com/nats-io/nats-top/archive/v${pkg_version}.tar.gz
pkg_shasum=62e544bf83afb51764edc255dfa421d81da43450266ebec37a7a21925c38b5c7
pkg_deps=(core/glibc)
pkg_build_deps=(
  core/go
  core/coreutils
  core/gcc
  core/make
  core/cacerts
)
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
  export SSL_CERT_FILE="$(pkg_path_for core/cacerts)/ssl/certs/cacert.pem"
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
