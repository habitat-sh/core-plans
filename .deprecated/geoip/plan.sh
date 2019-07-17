pkg_origin=core
pkg_name=geoip
pkg_version=1.6.0
pkg_license=('LGPL-2.1')
pkg_dirname=GeoIP-$pkg_version
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source=https://github.com/maxmind/geoip-api-c/releases/download/v${pkg_version}/GeoIP-${pkg_version}.tar.gz
pkg_shasum=443f46b89c3d626ae81463c2aac98300fff1e3b674faf06070843fbefedcf710
pkg_build_deps=(core/gcc core/make core/diffutils core/curl core/gzip)
pkg_deps=(core/glibc)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_upstream_url=https://github.com/maxmind/geoip-api-c
pkg_description="GeoIP Legacy C API"

do_install() {
  do_default_install

  build_line "Downloading GeoIP.dat"
  mkdir -p "${pkg_prefix}/share/GeoIP"
  curl "http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz" | gunzip > "${pkg_prefix}/share/GeoIP/GeoIP.dat"
  echo "This product includes GeoLite data created by MaxMind, available from [http://www.maxmind.com](http://www.maxmind.com)." > "${pkg_prefix}/GEOIP_LICENSE"
}
