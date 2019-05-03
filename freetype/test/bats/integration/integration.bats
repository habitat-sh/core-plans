@test "core/freetype must be installed"  {
  # match anything <word>/freetype: core/freetype, test/freetype, etc
  regex="[^/]*/freetype"
  result=$( find /hab/pkgs -maxdepth 2 -type d -name freetype | grep -E $regex || echo "core/freetype not installed" )

  # diff will fail for anything NOT equal to <word>/freetype:
  diff -I $regex <( echo "core/freetype") <( echo "${result}" )
}

@test "core/freetype must be included in the \$pkg_deps so that it is added to \$PKG_CONFIG_PATH"  {
  regex="/hab/pkgs/[^/]*/freetype/"
  result=$( echo "${PKG_CONFIG_PATH}" | grep -E $regex || echo "PKG_CONFIG_PATH didn't contain ${regex}lib/pkconfig" )
  diff <( echo "${PKG_CONFIG_PATH}" ) <( echo "${result}" )
}

@test "if PKG_CONFIG_PATH is set, 'freetype-config --prefix' should return the \$pkg_prefix for freetype" {
  result=$( hab pkg exec $HAB_ORIGIN/freetype freetype-config --prefix )
  diff <( echo "$( hab pkg path $HAB_ORIGIN/freetype )" ) <( echo "${result}" )
}
