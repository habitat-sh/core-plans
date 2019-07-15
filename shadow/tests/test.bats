# shadow provides a number of binaries
# Ref: https://github.com/shadow-maint/shadow/blob/master/doc/HOWTO#L478
# None of them seem to report a version, and only some even support a help flag.
# As a quick build verification check, just test the help flag for one of the programs that supports it.

@test "chage runs" {
  run hab pkg exec $TEST_PKG_IDENT chage -h
  [ $status -eq 0 ]
}
