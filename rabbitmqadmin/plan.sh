pkg_name=rabbitmqadmin
pkg_origin=core
pkg_version=3.6.10
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MPL')
pkg_description="Open source multi-protocol messaging broker (Administration CLI)"
pkg_upstream_url="https://www.rabbitmq.com"
pkg_source=https://raw.githubusercontent.com/rabbitmq/rabbitmq-management/rabbitmq_v${pkg_version//\./_}/bin/rabbitmqadmin
pkg_shasum=c078627474c80b26c027fc34b833d8f1744ffd0dc779982909a7382d67a344b5
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
