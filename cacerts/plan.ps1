$pkg_name="cacerts"
$pkg_origin="core"
$pkg_version="_set_from_downloaded_cacerts_file_"
$pkg_license=@('MPL-2.0')
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="http://curl.haxx.se/ca/cacert.pem"
$pkg_shasum="nopenopebucketofnope"

function Invoke-Verify { }
function Invoke-Build { }

function Invoke-Unpack {
  Set-PackageVersion
  mkdir "$HAB_CACHE_SRC_PATH/$pkg_dirname" -Force
  Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_filename" "$HAB_CACHE_SRC_PATH/$pkg_dirname" -Force
}

function Invoke-Install {
  mkdir "$pkg_prefix/ssl/certs"
  Copy-Item "$pkg_filename" "$pkg_prefix/ssl/certs" -Force
  Copy-Item "$pkg_filename" "$pkg_prefix/ssl/cert.pem" -Force
}

function Set-PackageVersion {
  # Extract the build date of the certificates file
  $datePrefix = "## Certificate data from Mozilla as of: "
  $dateLine = Get-Content "$HAB_CACHE_SRC_PATH/$pkg_filename" | ? {
    $_.StartsWith($datePrefix)
  }
  $buildDate = $dateLine.Substring($datePrefix.Length)

  # Update the `$pkg_version` value with the build date
  $script:pkg_version=[datetime]::ParseExact($buildDate, "ddd MMM dd HH:mm:ss yyyy GMT", $null).ToString("yyyy.MM.dd")
  Write-BuildLine "Version updated to $pkg_version from CA Certs file"

  # Several metadata values get their defaults from the value of `$pkg_version`
  # so we must update these as well
  $script:pkg_dirname="$pkg_name-$pkg_version"
  $script:pkg_prefix="$HAB_PKG_PATH/$pkg_origin/$pkg_name/$pkg_version/$pkg_release"
  $script:pkg_artifact="$HAB_CACHE_ARTIFACT_PATH/$pkg_origin-$pkg_name-$pkg_version-$pkg_release-$pkg_target.$_artifact_ext"
}
