expected_version="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"

@test "Encodes successfully" {
  actual="$(echo "a_byte_character" | hab pkg exec "${TEST_PKG_IDENT}" bssl sha256sum | cut -d' ' -f1)"
  diff <( echo "$actual" ) <( echo "606ce9d59be5ad79105843d3497122b53bf0b890c1f70776e3be8bc5117e8bb2" )
}
