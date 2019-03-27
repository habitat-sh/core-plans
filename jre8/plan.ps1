$pkg_name="jre8"
$pkg_origin="core"
$pkg_version="8.202.0"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_license=@("Apache-2.0")
$pkg_upstream_version="8u202"
$pkg_source="https://download.oracle.com/otn-pub/java/jdk/$pkg_upstream_version-b08/1961070e4c9b4e26a04e7f5a083f551e/jre-$pkg_upstream_version-windows-x64.exe"
$pkg_filename="$pkg_name-$pkg_version.exe"
$pkg_shasum="039d5b91e9a52335d7d127ba187640b6fba8195a65e73c135be9c000ea91d4bb"
$pkg_build_deps=@("core/7zip")
$pkg_bin_dirs=@("java/bin")

function Invoke-Download() {
     $Cookie  = New-Object -TypeName System.Net.Cookie
     $Cookie.Domain = 'oracle.com'
     $Cookie.Name   = 'oraclelicense'
     $Cookie.Value  = 'accept-securebackup-cookie'
     $Session = New-Object -TypeName Microsoft.PowerShell.Commands.WebRequestSession
     $Session.Cookies.Add($Cookie)
     try {
        Invoke-WebRequest -Uri $pkg_source -WebSession $Session -OutFile $HAB_CACHE_SRC_PATH/$pkg_filename
     } catch {
        $pkg_source = $_.Exception.Response.Headers.Location
        Invoke-WebRequest -Uri $pkg_source -WebSession $Session -OutFile $HAB_CACHE_SRC_PATH/$pkg_filename
     }
}

function Invoke-Unpack() {
    New-Item "$HAB_CACHE_SRC_PATH/$pkg_dirname" -ItemType Directory | Out-Null
    Push-Location "$HAB_CACHE_SRC_PATH/$pkg_dirname"
    try {
        7z x "$HAB_CACHE_SRC_PATH/$pkg_filename"
        7z x data1.cab
        7z x installerexe -ojava

        Get-ChildItem java\lib -Include *.pack -Recurse | % {
            Write-Host "Unpacking $_"
            ."java\bin\unpack200.exe" $_.FullName $_.FullName.Replace(".pack", ".jar")
            Remove-Item $_
        }
    }
    finally { Pop-Location }
}

function Invoke-Install() {
    Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_dirname/java" $pkg_prefix -Recurse -Force
}
