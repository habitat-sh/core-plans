$pkg_name="jre8"
$pkg_origin="core"
$pkg_version="8.172.0"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_license=@("Apache-2.0")
$pkg_upstream_version="8u172"
$pkg_source="http://download.oracle.com/otn-pub/java/jdk/$pkg_upstream_version-b11/a58eab1ec242421181065cdc37240b08/jre-$pkg_upstream_version-windows-x64.exe"
$pkg_filename="$pkg_name-$pkg_version.exe"
$pkg_shasum="580bd9a6da5640661c4dc6ebdb3eac451dbc49f23635728116d90a4d164d3a0f"
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
