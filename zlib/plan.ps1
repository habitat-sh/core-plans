$pkg_name="zlib"
$pkg_origin="core"
$pkg_version="1.2.12"
$pkg_file_name=$pkg_name + ($pkg_version).Replace(".", "")
$pkg_description="Compression library implementing the deflate compression method found in gzip and PKZIP."
$pkg_upstream_url="http://www.zlib.net/"
$pkg_license=("zlib")
$pkg_source="http://zlib.net/$pkg_file_name.zip"
$pkg_shasum="173e89893dcb8b4a150d7731cd72f0602f1d6b45e60e2a54efdf7f3fc3325fd7"
$pkg_build_deps=@("core/visual-cpp-build-tools-2015")
$pkg_bin_dirs=@("bin")
$pkg_lib_dirs=@("lib")
$pkg_include_dirs=@("include")

function Invoke-SetupEnvironment {
    . "$(Get-HabPackagePath visual-cpp-build-tools-2015)\setenv.ps1"
}
function Invoke-Build {
    Set-Location "$pkg_name-$pkg_version"

    # This applies the workaround suggested by https://github.com/madler/zlib/issues/631#issuecomment-1097004675
    # Removes the <ClCompile Include="..\..\masmx64\inffas8664.c"> from the project files
    # And builds with ReleaseWithoutAsm
    [xml]$projXml = Get-Content "contrib/vstudio/vc14/zlibvc.vcxproj"
    $child = $projXml.Project.ItemGroup[1].ClCompile[9]
    $projXml.Project.ItemGroup[1].RemoveChild($child) | Out-Null
    $projXml.Save("$pwd/contrib/vstudio/vc14/zlibvc.vcxproj")

    [xml]$projXml = Get-Content "contrib/vstudio/vc14/zlibstat.vcxproj"
    $child = $projXml.Project.ItemGroup[1].ClCompile[9]
    $projXml.Project.ItemGroup[1].RemoveChild($child) | Out-Null
    $projXml.Save("$pwd/contrib/vstudio/vc14/zlibstat.vcxproj")

    [xml]$projXml = Get-Content "contrib/vstudio/vc14/testzlib.vcxproj"
    $child = $projXml.Project.ItemGroup[1].ClCompile[5]
    $projXml.Project.ItemGroup[1].RemoveChild($child) | Out-Null
    $projXml.Save("$pwd/contrib/vstudio/vc14/testzlib.vcxproj")

    msbuild /p:Configuration=ReleaseWithoutAsm /p:Platform=x64 "contrib\vstudio\vc14\zlibvc.sln"
    if($LASTEXITCODE -ne 0) { Write-Error "msbuild failed!" }
}

function Invoke-Install {
    Copy-Item "$HAB_CACHE_SRC_PATH\$pkg_name-$pkg_version\$pkg_name-$pkg_version\contrib\vstudio\vc14\x64\ZlibDllReleaseWithoutAsm\zlibwapi.dll" "$pkg_prefix\bin\" -Force
    Copy-Item "$HAB_CACHE_SRC_PATH\$pkg_name-$pkg_version\$pkg_name-$pkg_version\contrib\vstudio\vc14\x64\ZlibDllReleaseWithoutAsm\zlibwapi.lib" "$pkg_prefix\lib\" -Force
    Copy-Item "$HAB_CACHE_SRC_PATH\$pkg_name-$pkg_version\$pkg_name-$pkg_version\zlib.h" "$pkg_prefix\include\" -Force
    Copy-Item "$HAB_CACHE_SRC_PATH\$pkg_name-$pkg_version\$pkg_name-$pkg_version\zconf.h" "$pkg_prefix\include\" -Force
}
