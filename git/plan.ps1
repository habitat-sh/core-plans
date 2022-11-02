$pkg_name = "git"
$pkg_origin = "core"
$pkg_version = "2.35.1"
$pkg_description = "Git is a free and open source distributed version control
  system designed to handle everything from small to very large projects with
  speed and efficiency."
$pkg_upstream_url = "https://git-scm.com/"
$pkg_maintainer = "The Habitat Maintainers <humans@habitat.sh>"
$pkg_license = @("GPL-2.0")
$pkg_source = "https://github.com/git-for-windows/git/releases/download/v$pkg_version.windows.1/Git-$pkg_version-64-bit.tar.bz2"
$pkg_shasum = "a8dafe3ed839494e8b71212c1027830aa8d6f2f04365f4e523888f793f8e3fd5"
$pkg_bin_dirs = @("bin")
$pkg_build_deps = @("core/7zip")

function Invoke-Unpack {
    Push-Location (Resolve-Path $HAB_CACHE_SRC_PATH).Path
    Try {
        $tar = $pkg_filename.Substring(0, $pkg_filename.LastIndexOf('.'))
        7z x -y (Resolve-Path $HAB_CACHE_SRC_PATH/$pkg_filename).Path
        7z x -y -o"$pkg_dirname" (Resolve-Path $HAB_CACHE_SRC_PATH/$tar).Path
    } finally { Pop-Location }
}

function Invoke-Install {
    mkdir "$pkg_prefix/usr/bin" -Force
    Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_dirname/bin/*" "$pkg_prefix/bin"
    Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_dirname/usr/bin/*" "$pkg_prefix/usr/bin"
    Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_dirname/mingw64" "$pkg_prefix/" -Recurse
}
