@test "PKG_CONFIG_PATH must be set and not be empty" {
  test "${PKG_CONFIG_PATH}" != ""
}

@test "core/zlib must be included in the \$pkg_deps so that it is added to PKG_CONFIG_PATH"  {
  regex="/hab/pkgs/core/zlib/"
  result=$( echo "${PKG_CONFIG_PATH}" | grep -E $regex || echo "didn't contain $regex" )
  diff <( echo "${PKG_CONFIG_PATH}" ) <( echo "${result}" )
}

@test "core/libpng must be included in the \$pkg_deps so that it is added to PKG_CONFIG_PATH"  {
  regex="/hab/pkgs/core/libpng/"
  result=$( echo "${PKG_CONFIG_PATH}" | grep -E $regex || echo "didn't contain $regex" )
  diff <( echo "${PKG_CONFIG_PATH}" ) <( echo "${result}" )
}