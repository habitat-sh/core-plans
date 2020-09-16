pkg_name=tzdata
pkg_origin=core
pkg_version=2018g
pkg_description="Sources for time zone and daylight saving time data"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('gpl')
pkg_source=https://www.iana.org/time-zones/repository/releases/${pkg_name}${pkg_version}.tar.gz
pkg_shasum=02dfde534872f6513ae4553a3388fdae579441e31b862ea99170dfc447f46a16
pkg_upstream_url=http://www.iana.org/time-zones

timezones=(
  'africa'
  'antarctica'
  'asia'
  'australasia'
  'europe'
  'northamerica'
  'southamerica'
  'pacificnew'
  'etcetera'
  'backward'
  'systemv'
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
