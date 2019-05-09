pkg_name=gnatsd
pkg_origin=core
pkg_version=1.4.1
pkg_description="A High Performance NATS Server written in Go."
pkg_upstream_url=https://github.com/nats-io/gnatsd
pkg_license=('MIT')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/nats-io/gnatsd/archive/v${pkg_version}.tar.gz"
pkg_shasum=1d319ec9466d5b4d56b8dc0c059bbb50942a8e988c3dcc155271476c3ae629a1
pkg_deps=(core/glibc)
pkg_build_deps=(core/go core/coreutils core/gcc core/make)
pkg_bin_dirs=(bin)
pkg_svc_run="${pkg_name} -c ${pkg_svc_config_path}/default.conf"
pkg_exports=(
  [port]=gnatsd.port
  [http_port]=gnatsd.http.port
)
pkg_exposes=(port http_port)

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
  cp "${pkg_name}" "${pkg_prefix}/bin/${pkg_name}"
  return $?
}
