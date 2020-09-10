@test "libtool paths are set correctly" {
  deps_path="$(< /hab/pkgs/$TEST_PKG_IDENT/DEPS)"
  grep_ident="$(grep -E "^core/grep/" <<< "$deps_path" )"
  sed_ident="$(grep -E "^core/sed/" <<< "$deps_path" )"

  run hab pkg exec $TEST_PKG_IDENT libtool --config
  grep -qE "^GREP=\"/hab/pkgs/$grep_ident/bin/grep\"" <<< "${output[@]}"
  grep -qE "^SED=\"/hab/pkgs/$sed_ident/bin/sed\"" <<< "${output[@]}"
}

@test "library search paths are empty" {
  run hab pkg exec $TEST_PKG_IDENT libtool --config

  grep -q 'compiler_lib_search_dirs=""' <<< "${output[@]}"
  grep -q 'compiler_lib_search_path=""' <<< "${output[@]}"
  grep -q 'sys_lib_search_path_spec=""' <<< "${output[@]}"
  grep -q 'sys_lib_dlsearch_path_spec=""' <<< "${output[@]}"
}
