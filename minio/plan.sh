pkg_name=minio
pkg_origin=core
pkg_version="2023-11-01T01-57-10Z"
pkg_description="Minio is a high performance distributed object storage server, designed for large-scale private cloud infrastructure."
pkg_upstream_url="https://minio.io"
pkg_source="https://dl.minio.io/server/minio/release/linux-amd64/archive/minio.RELEASE.${pkg_version}"
pkg_shasum="7ab9f2e92e7826d8fc58c983414ec01d8c624965471e8b6c2f720dc3ea71ae17"
pkg_license=('Apache-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_bin_dirs=(bin)

do_unpack() {
  return 0
}

do_build() {
  return 0
}

do_install() {
  mkdir -p "${pkg_prefix}/bin"
  cp "../minio.RELEASE.${pkg_version}" "${pkg_prefix}/bin/minio"
  chmod +x "${pkg_prefix}/bin/minio"
}

do_strip() {
  return 0
}
