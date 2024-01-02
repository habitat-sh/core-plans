pkg_name=coredns
pkg_origin=core
pkg_version=1.8.6
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Apache-2.0")
pkg_description="CoreDNS is a DNS server/forwarder, written in Go, that chains plugins."
pkg_upstream_url=https://coredns.io/
pkg_source="https://github.com/coredns/coredns/archive/v${pkg_version}.tar.gz"
pkg_shasum=cbe3764afe2148b8047ea7e5cbba5108c298dee3a9a0391028e2980e35beaa2b
pkg_deps=(
  core/glibc
  core/coreutils
)
pkg_build_deps=(
  core/make
  core/go
  core/git
  core/cacerts
)
pkg_bin_dirs=(bin)
pkg_svc_run="coredns -conf ${pkg_svc_config_path}/Corefile"
pkg_exports=(
  [port]=port
)
pkg_exposes=(port)
pkg_svc_user="root"
pkg_svc_group="${pkg_svc_user}"

do_prepare() {
	export SSL_CERT_FILE="$(pkg_path_for core/cacerts)/ssl/certs/cacert.pem"
}

do_build() {
  fix_interpreter ".presubmit/*" core/coreutils bin/env
  make
}

do_install() {
  install -m755 coredns "${pkg_prefix}/bin/coredns"
}
