pkg_origin=core
pkg_name=libmaxminddb
pkg_version=1.3.2
pkg_license=('Apache-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/maxmind/libmaxminddb/releases/download/${pkg_version}/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="e6f881aa6bd8cfa154a44d965450620df1f714c6dc9dd9971ad98f6e04f6c0f0"
pkg_upstream_url="https://github.com/maxmind/libmaxminddb"
pkg_description="C library for the MaxMind DB file format"
pkg_build_deps=(
  core/coreutils
  core/diffutils
  core/file
  core/gcc
  core/make
  core/perl
  )
pkg_deps=(
  core/gcc-libs
  core/glibc
)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

geolite_city_filename="GeoLite2-City.tar.gz"
geolite_city_archive="https://geolite.maxmind.com/download/geoip/database/${geolite_city_filename}"
geolite_city_sha256sum="589b8603a6cd98cf134f96de24618ba1d986a954e40409a67f398eb1edbf6084"

geolite_country_filename="GeoLite2-Country.tar.gz"
geolite_country_archive="https://geolite.maxmind.com/download/geoip/database/${geolite_country_filename}"
geolite_country_sha256sum="1b627bd7a575500cbf9e675630ab2c9b1632c3727f3eab29a06e50568341bdfa"

geolite_asn_filename="GeoLite2-ASN.tar.gz"
geolite_asn_archive="https://geolite.maxmind.com/download/geoip/database/${geolite_asn_filename}"
geolite_asn_sha256sum="6fc0855cdc3514c5b7cf19fe1a2681c5b1bbc5009c3a89b1453b64c8c235ba2a"

do_check() {
  make check
}

do_prepare() {
  if [[ ! -r /usr/bin/file ]]; then
    ln -sv "$(pkg_path_for file)/bin/file" /usr/bin/file
    _clean_file=true
  fi

  interpreter_old="/usr/bin/env"
  interpreter_new="$(pkg_path_for coreutils)/bin/env"

  grep -nrlI '\#\!/usr/bin/env' "$HAB_CACHE_SRC_PATH/${pkg_dirname}/t" | while read -r fileToFix; do
    build_line "Setting interpreter for ${fileToFix} to ${interpreter_new}"
    sed -e "s|#!${interpreter_old}|#!${interpreter_new}|" -i "$fileToFix"
  done
}

do_install() {
  do_default_install

  local geoip_install_path="${pkg_prefix}/share/GeoIP"

  mkdir -p "${geoip_install_path}"
  cd "${geoip_install_path}"

  build_line "Installing GeoIP City Files"
  download_file $geolite_city_archive "${geoip_install_path}/${geolite_city_filename}" $geolite_city_sha256sum
  tar -xf ${geolite_city_filename}
  rm ${geolite_city_filename}

  build_line "Installing GeoIP Country Files"
  mkdir -p "${geoip_install_path}"
  download_file $geolite_country_archive "${geoip_install_path}/${geolite_country_filename}" $geolite_country_sha256sum
  tar -xf ${geolite_country_filename}
  rm ${geolite_country_filename}

  build_line "Installing GeoIP ASN Files"
  mkdir -p "${geoip_install_path}"
  download_file $geolite_asn_archive "${geoip_install_path}/${geolite_asn_filename}" $geolite_asn_sha256sum
  tar -xf ${geolite_asn_filename}
  rm ${geolite_asn_filename}
}

do_end() {
  if [[ -n "$_clean_file" ]]; then
    rm -fv /usr/bin/file
  fi
}
