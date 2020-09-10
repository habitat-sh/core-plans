pkg_name=minio
pkg_origin=core
pkg_version="2020-06-01T17-28-03Z"
pkg_description="Minio is a high performance distributed object storage server, designed for large-scale private cloud infrastructure."
pkg_upstream_url="https://minio.io"
pkg_source="https://dl.minio.io/server/minio/release/linux-amd64/archive/minio.RELEASE.${pkg_version}"
pkg_shasum=540a434b605b67913da2d83db6057cac98f303bbbe8f829ab5c6d5b58157c6c7
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
