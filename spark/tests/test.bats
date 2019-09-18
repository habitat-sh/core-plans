@test "spark service is running" {
  [ "$(hab svc status | grep "spark\.default" | awk '{print $4}' | grep up)" ]
}

# NOTE: 'spark-submit --version' produces a 'Spark' header below plus other information.
# the version is extracted from the header
#
#   Welcome to
#         ____              __
#        / __/__  ___ _____/ /__
#       _\ \/ _ \/ _ `/ __/  '_/
#      /___/ .__/\_,_/_/ /_/\_\   version 2.1.2
#         /_/
expected_version="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"
@test "spark-submit matches version ${expected_version}" {
  #actual_version="$(hab pkg exec core/spark spark-submit --version 2>&1 | grep "version")"
  actual_version="$(hab pkg exec core/spark spark-submit --version 2>&1 )"
  diff <(echo "$actual_version") <(echo "${expected_version}")
}
