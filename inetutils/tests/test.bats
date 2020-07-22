# All commands provided require known state that will differ based on the host
# it's run on (hostname) or external connectivity. While we could exercise the
# latter, it's likely to lead to a number of false failures depending on
# the network it's run from, and the status of the target host.

# For now, we'll exercise the command with --usage to ensure it's runnable .
@test "can run ping --usage" {
  run hab pkg exec $TEST_PKG_IDENT ping --usage
  [ "$status" -eq 0 ]
}
