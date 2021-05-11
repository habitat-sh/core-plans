$pkg_name="innounp"
$pkg_origin="core"
$pkg_version="0.50"
$pkg_license=@("GPL")
$pkg_upstream_url="http://innounp.sourceforge.net/"
$pkg_description="Inno Setup Unpacker"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_filename="innounp$($pkg_version.Replace('.','')).rar"
$pkg_source="https://sourceforge.net/projects/innounp/files/innounp/innounp%20$pkg_version/$pkg_filename"
$pkg_shasum="9b469f2f7ed69451782cb0618b028d0e2f74105218d2e7f79620bfbf0a522f4a"
$pkg_build_deps = @("core/7zip")
$pkg_bin_dirs=@("bin")

function Invoke-Unpack {
    Push-Location (Resolve-Path $HAB_CACHE_SRC_PATH).Path
    Try {
        7z x -y -o"$pkg_dirname" (Resolve-Path $HAB_CACHE_SRC_PATH/$pkg_filename).Path
    } finally { Pop-Location }
}

function Invoke-Install {
    Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_dirname/*.exe" "$pkg_prefix/bin"
}
