source "${BATS_TEST_DIRNAME}/../plan.sh"

@test "Version matches" {
  result="$(erl -eval '{ok, Version} = file:read_file(filename:join([code:root_dir(), "releases", erlang:system_info(otp_release), "OTP_VERSION"])), io:fwrite(Version), halt().' -noshell)"
  [ "$result" = "${pkg_version}" ]
}
