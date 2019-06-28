pkg_name=atlantis
pkg_origin=core
pkg_version=0.8.2
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Apache-2.0")
pkg_source=https://github.com/runatlantis/${pkg_name}/releases/download/v${pkg_version}/atlantis_linux_amd64.zip
pkg_shasum="efb57e8def4e5622d25cc21ce930aeefa471517f4f0af61ce77c59d3fb5f57be"
pkg_deps=(core/terraform)
pkg_build_deps=(core/unzip)
pkg_svc_run="atlantis server --config ${pkg_svc_config_path}/atlantis.yaml"
pkg_exposes=(port)
pkg_exports=(
  [port]=http.port
)
pkg_bin_dirs=(bin)
pkg_upstream_url=https://runatlantis.io
pkg_description="A self-hosted golang application that listens for Terraform pull request events via webhooks."

do_unpack() {
  cd "${HAB_CACHE_SRC_PATH}" || exit
  unzip "${pkg_filename}" -d "${pkg_dirname}"
}

do_build() {
  return 0
}

do_install() {
  install -D atlantis "${pkg_prefix}/bin/atlantis"
}
