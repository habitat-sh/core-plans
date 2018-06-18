$pkg_name="jre8"
$pkg_origin="core"
$pkg_version="8.172.0"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_license=@("Apache-2.0")
$pkg_upstream_version="8u172"
$pkg_source="http://download.oracle.com/otn-pub/java/jdk/$pkg_upstream_version-b11/a58eab1ec242421181065cdc37240b08/jre-$pkg_upstream_version-windows-i586.exe"
$pkg_filename="$pkg_name-$pkg_version.exe"
$pkg_shasum="434d7cbe88e2a28ee37c7345b5d93810c98112908f7dd5a273a0611482898928"
$pkg_bin_dirs=@("bin")

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

function Invoke-Unpack() { }

function Invoke-Install() {
    Write-Host "Installing $HAB_CACHE_SRC_PATH/$pkg_filename to $pkg_prefix"
    rm -Force $pkg_prefix/bin
    Start-Process "$HAB_CACHE_SRC_PATH/$pkg_filename" -Wait -ArgumentList "/s INSTALL_SILENT=1 INSTALLDIR=$pkg_prefix /L $HAB_CACHE_SRC_PATH/jre.log"
    cat $HAB_CACHE_SRC_PATH/jre.log
}
