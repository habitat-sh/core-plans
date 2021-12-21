pkg_name=rabbitmqadmin
pkg_origin=core
pkg_version=3.9.8
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MPL')
pkg_description="Open source multi-protocol messaging broker (Administration CLI)"
pkg_upstream_url="https://www.rabbitmq.com"
pkg_source=https://raw.githubusercontent.com/rabbitmq/rabbitmq-server/v${pkg_version}/deps/rabbitmq_management/bin/rabbitmqadmin
pkg_shasum=c18706fda8de9e547cc882c14ddefe61f32835f7ca219229f7078fca3d17f459
pkg_deps=(
  core/python2
  core/coreutils
)
pkg_bin_dirs=(bin)

do_unpack() {
  pushd "${HAB_CACHE_SRC_PATH}"
  mkdir "${pkg_name}-${pkg_version}"
  mv rabbitmqadmin "${pkg_name}-${pkg_version}/"
  popd
}

do_build() {
  fix_interpreter "rabbitmqadmin" core/coreutils bin/env
}

do_install() {
  install -D rabbitmqadmin "${pkg_prefix}/bin/rabbitmqadmin"
  chmod +x "${pkg_prefix}/bin/rabbitmqadmin"
}
