$pkg_name="psscriptanalyzer"
$pkg_origin="core"
$pkg_version="1.20.0"
$pkg_license=@('MIT')
$pkg_upstream_url="https://github.com/PowerShell/PSScriptAnalyzer"
$pkg_description="PSScriptAnalyzer is the ubiquitous linter for PowerShell"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://github.com/PowerShell/PSScriptAnalyzer/releases/download/$pkg_version/PSScriptAnalyzer.$pkg_version.nupkg"
$pkg_shasum="52b442c513d327129be228ab031a38a91c26f01187b179e9068d918a2c38a466"

function Invoke-Unpack {
    Expand-Archive -Path "$HAB_CACHE_SRC_PATH/$pkg_filename" -DestinationPath "$HAB_CACHE_SRC_PATH/$pkg_dirname"
}

function Invoke-Install {
    mkdir "$pkg_prefix/module"
    Copy-Item * "$pkg_prefix/module" -Recurse -Force
}

function Invoke-Check() {
    Import-Module "$HAB_CACHE_SRC_PATH/$pkg_dirname/PSScriptAnalyzer.psd1" | Out-Null
    $version = (Get-Command Invoke-ScriptAnalyzer).Version
    $version -eq $pkg_prefix
}
