pkg_name=minio
pkg_origin=core
pkg_version="2018-10-05T01-03-03Z"
pkg_description="Minio is a high performance distributed object storage server, designed for large-scale private cloud infrastructure."
pkg_upstream_url="https://minio.io"
pkg_source="https://dl.minio.io/server/minio/release/linux-amd64/archive/minio.RELEASE.${pkg_version}"
pkg_shasum="dd5a89b17bdba7bfb508d6734e7879101204052f01eeb5cb8845eb76b011351e"
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
