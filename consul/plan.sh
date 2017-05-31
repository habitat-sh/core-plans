pkg_origin=core
pkg_name=consul
pkg_version=0.8.2
pkg_maintainer='The Habitat Maintainers <humans@habitat.sh>'
pkg_license=("MPL-2.0")
pkg_description="Consul is a tool for service discovery, monitoring and configuration."
pkg_upstream_url=https://www.consul.io/
pkg_source=https://releases.hashicorp.com/${pkg_name}/${pkg_version}/${pkg_name}_${pkg_version}_linux_amd64.zip
pkg_shasum=6409336d15baea0b9f60abfcf7c28f7db264ba83499aa8e7f608fb0e273514d9
pkg_filename=${pkg_name}-${pkg_version}_linux_amd64.zip

pkg_deps=()
pkg_build_deps=(core/unzip core/cacerts)
pkg_bin_dirs=(bin)
pkg_exports=(
  [port-dns]=ports.dns
  [port-http]=ports.http
  [port-https]=ports.https
  [port-rpc]=ports.rpc
)

pkg_exposes=(port-dns port-http port-rpc)
pkg_svc_user=root
pkg_svc_group=${pkg_svc_user}

do_unpack() {
  cd "${HAB_CACHE_SRC_PATH}" || exit
  unzip ${pkg_filename} -d "${pkg_name}-${pkg_version}"
}

do_build() {
  return 0
}

do_install() {
  install -D consul "${pkg_prefix}/bin/consul"

  mkdir "${pkg_prefix}/cacerts"
  cp "$(pkg_path_for core/cacerts)/ssl/certs/cacert.pem ${pkg_prefix}/cacerts/cacert.pem"
  ls -al "${pkg_prefix}/cacerts"
}
