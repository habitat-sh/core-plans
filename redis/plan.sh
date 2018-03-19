pkg_name=redis
pkg_origin=core
pkg_version=3.2.8
pkg_description="Persistent key-value database, with built-in net interface"
pkg_upstream_url=http://redis.io/
pkg_license=('BSD-3-Clause')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=http://download.redis.io/releases/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=61b373c23d18e6cc752a69d5ab7f676c6216dc2853e46750a8c4ed791d68482c
pkg_bin_dirs=(bin)
pkg_build_deps=(core/make core/gcc)
pkg_deps=(core/shield-agent core/jq-static core/glibc)
pkg_exports=(
  [port]=port
  [password]=password
  [shield_agent_port]=shield_agent_port
)
pkg_exposes=(port shield_agent_port)
pkg_binds_optional=(
  [shield]="port provisioning_key"
)

pkg_svc_user="root"
pkg_svc_group="$pkg_svc_user"

do_build() {
  make
}
