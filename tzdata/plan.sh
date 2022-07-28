pkg_name=tzdata
pkg_origin=core
pkg_version=2021e
pkg_description="Sources for time zone and daylight saving time data"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('gpl')
pkg_source=https://www.iana.org/time-zones/repository/releases/${pkg_name}${pkg_version}.tar.gz
pkg_shasum=07ec42b737d0d3c6be9c337f8abb5f00554a0f9cc4fcf01a703d69403b6bb2b1
pkg_upstream_url=http://www.iana.org/time-zones
pkg_dirname="${pkg_name}-${pkg_version}"

timezones=(
  'africa'
  'antarctica'
  'asia'
  'australasia'
  'europe'
  'northamerica'
  'southamerica'
  'etcetera'
  'backward'
  'factory'
)

do_unpack() {
  mkdir -p "$HAB_CACHE_SRC_PATH/$pkg_dirname"
  pushd "$HAB_CACHE_SRC_PATH/$pkg_dirname" > /dev/null
    tar xf "$HAB_CACHE_SRC_PATH/$pkg_filename"
  popd > /dev/null
}

do_build() {
  return 0
}

do_install() {
  zic -y ./yearistype -d "$pkg_prefix/share/zoneinfo" "${timezones[@]}"
  zic -y ./yearistype -d "$pkg_prefix/share/zoneinfo/posix" "${timezones[@]}"
  zic -y ./yearistype -d "$pkg_prefix/share/zoneinfo/right" -L leapseconds "${timezones[@]}"

  zic -y ./yearistype -d "$pkg_prefix/share/zoneinfo" -p America/New_York
  install -m444 -t "$pkg_prefix/share/zoneinfo" -v iso3166.tab zone1970.tab zone.tab
}
