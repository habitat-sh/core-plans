pkg_name=gnatsd
pkg_origin=core
pkg_version=0.9.4
pkg_description="A High Performance NATS Server written in Go."
pkg_upstream_url=https://github.com/nats-io/gnatsd
pkg_license=('MIT')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://github.com/nats-io/gnatsd/archive/v0.9.4.tar.gz
pkg_shasum=6465161c52e3e703f88cfe37182904d956234c4346f9ad6eb74903eff0190c98
pkg_dirname=${pkg_name}-${pkg_version}
pkg_filename=${pkg_name}-${pkg_version}.tar.gz
pkg_deps=(core/go)
pkg_build_deps=(core/go core/coreutils core/gcc core/make)
pkg_bin_dirs=(bin)
pkg_svc_run="${pkg_name}-${pkg_version}"

do_build() {
  export GOPATH=/hab/cache/src/gnatsd-0.9.4
  mkdir -p ./src/github.com/nats-io/gnatsd

  cp -r auth ./src/github.com/nats-io/gnatsd
  cp -r server ./src/github.com/nats-io/gnatsd
  cp -r logger ./src/github.com/nats-io/gnatsd
  cp -r conf ./src/github.com/nats-io/gnatsd
  cp -r util ./src/github.com/nats-io/gnatsd
  cp -r vendor ./src/github.com/nats-io/gnatsd
  go build
}


do_install() {
  mkdir -p "${pkg_prefix}/bin"
  cp -R . "${pkg_prefix}"
  ln -s "${pkg_prefix}/${pkg_name}-${pkg_version}" "${pkg_prefix}/bin/${pkg_name}-${pkg_version}"
}
