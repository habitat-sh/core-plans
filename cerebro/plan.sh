pkg_name=cerebro
pkg_origin=core
pkg_version="0.8.1"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Apache-2.0")
pkg_filename="${pkg_name}-${pkg_version}.tgz"
pkg_source="https://github.com/lmenezes/cerebro/releases/download/v${pkg_version}/${pkg_filename}"
pkg_shasum="11451e6a8253556d0b9118bb54e2d5f989038180daad99154a8081a835d22224"
pkg_deps=(core/coreutils core/jre8)
pkg_bin_dirs=(bin)
pkg_exports=(
  [port]=port
)
pkg_exposes=(port)
pkg_svc_user="hab"
pkg_svc_group="$pkg_svc_user"
pkg_description="Cerebro: Elasticsearch Administration"
pkg_upstream_url="https://github.com/lmenezes/cerebro"

do_build() {
	return 0
}

do_install() {
	cp -r ./* "${pkg_prefix}/"
	mkdir -p "${pkg_prefix}/logs"
	fix_interpreter "${pkg_prefix}/bin/*" core/coreutils bin/env
}
