$pkg_name="innounp"
$pkg_origin="core"
$pkg_version="0.46"
$pkg_license=@("GPL")
$pkg_upstream_url="http://innounp.sourceforge.net/"
$pkg_description="Inno Setup Unpacker"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_filename="innounp$($pkg_version.Replace('.','')).rar"
$pkg_source="http://sourceforge.net/projects/innounp/files/innounp/innounp%20$pkg_version/$pkg_filename"
$pkg_shasum="3c056e2fc46ca9e92405f13ddf1f250cfe4bd66cb83b6647d87c74bc7242b121"
$pkg_build_deps = @("core/7zip")
$pkg_bin_dirs=@("bin")

function Invoke-Unpack {
  Push-Location (Resolve-Path $HAB_CACHE_SRC_PATH).Path
  Try {
    7z x -y -o"$pkg_dirname" (Resolve-Path $HAB_CACHE_SRC_PATH/$pkg_filename).Path
  }
  Finally { Pop-Location }
}

function Invoke-Install {
  Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_dirname/*.exe" "$pkg_prefix/bin"
}
