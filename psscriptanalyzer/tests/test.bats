expected_version="$(echo "${TEST_PKG_IDENT}" | cut -d/ -f3)"
@test "psscriptanalyzer matches version ${expected_version}" {
  path_to_module=$(hab pkg path "${TEST_PKG_IDENT}")
  run hab pkg exec "${TEST_PKG_IDENT}" pwsh --command "Import-Module ${path_to_module}/module/PSScriptAnalyzer.psd1 3>\$null; (Get-Command Invoke-ScriptAnalyzer).Version -join ''"
  diff <( echo "${output}" ) <( echo "${expected_version}" )
}
