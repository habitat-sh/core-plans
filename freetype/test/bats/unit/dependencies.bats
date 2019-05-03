@test "core/zlib must be installed"  {
  # match anything <word>/zlib: core/zlib, test/zlib, etc
  regex="[^/]*/zlib"
  result=$( find /hab/pkgs -maxdepth 2 -type d -name zlib | grep -E $regex || echo "core/zlib not installed" )

  # diff will fail for anything NOT equal to <word>/zlib:
  diff -I $regex <( echo "core/zlib") <( echo "${result}" )
}

@test "core/libpng must be installed"  {
  # match anything <word>/libpng: core/libpng, test/libpng, etc
  regex="[^/]*/libpng"
  result=$( find /hab/pkgs -maxdepth 2 -type d -name libpng | grep -E $regex || echo "core/libpng not installed" )

  # diff will fail for anything NOT equal to <word>/libpng:
  diff -I $regex <( echo "core/libpng") <( echo "${result}" )
}