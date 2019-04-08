source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(mmdblookup --version | head -2 | tail -n 1 | awk '{print $3}')"
  [ "$result" = "${pkg_version}" ]
}

@test "Help flag works" {
  run mmdblookup --help
  [ $status -eq 0 ]
}

@test "City lookup successful" {
  source results/last_build.env
  run mmdblookup --file $(hab pkg path ${pkg_origin}/libmaxminddb)/share/GeoIP/GeoLite2-City_20190409/GeoLite2-City.mmdb --ip 8.8.8.8
  [ $status -eq 0 ]
}

@test "Country lookup successful" {
  source results/last_build.env
  run mmdblookup --file $(hab pkg path ${pkg_origin}/libmaxminddb)/share/GeoIP/GeoLite2-Country_20190409/GeoLite2-Country.mmdb --ip 8.8.8.8
  [ $status -eq 0 ]
}

@test "ASN lookup successful" {
  source results/last_build.env
  run mmdblookup --file $(hab pkg path ${pkg_origin}/libmaxminddb)/share/GeoIP/GeoLite2-ASN_20190402/GeoLite2-ASN.mmdb --ip 8.8.8.8
  [ $status -eq 0 ]
}
