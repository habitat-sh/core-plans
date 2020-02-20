$pkg_name="libsodium"
$pkg_origin="core"
$pkg_version="1.0.18"
$_pkg_version_text=($pkg_version).Replace(".", "_")
$pkg_description="Sodium is a new, easy-to-use software library for encryption, decryption, signatures, password hashing and more. It is a portable, cross-compilable, installable, packageable fork of NaCl, with a compatible API, and an extended API to improve usability even further."
$pkg_upstream_url="https://github.com/jedisct1/libsodium"
$pkg_license=@("ISC")
$pkg_source="https://github.com/jedisct1/libsodium/archive/$pkg_version.zip"
$pkg_shasum="1b72c0cdbc535ce42e14ac15e8fc7c089a3ee9ffe5183399fd77f0f3746ea794"
$pkg_build_deps=@("core/visual-cpp-build-tools-2015")
$pkg_bin_dirs=@("bin")
$pkg_lib_dirs=@("lib")
$pkg_include_dirs=@("include")

function Invoke-SetupEnvironment {
    . "$(Get-HabPackagePath visual-cpp-build-tools-2015)\setenv.ps1"
}

function Invoke-Build {
    Set-Location "$pkg_name-$pkg_version"
    msbuild.exe /m /p:Configuration=DynRelease /p:Platform=x64 builds/msvc/vs2015/libsodium.sln
    if($LASTEXITCODE -ne 0) { Write-Error "msbuild failed!" }
}

function Invoke-Install {
    $build_path = "$HAB_CACHE_SRC_PATH\$pkg_name-$pkg_version\$pkg_name-$pkg_version"

    Copy-Item "$build_path\bin\x64\Release\v140\dynamic\libsodium.dll" "$pkg_prefix\bin\" -Force
    Copy-Item "$build_path\bin\x64\Release\v140\dynamic\libsodium.lib" "$pkg_prefix\lib\" -Force
    Copy-Item "$build_path\bin\x64\Release\v140\dynamic\libsodium.lib" "$pkg_prefix\lib\sodium.lib" -Force
    Copy-Item "$build_path\src\$pkg_name\include\*.h" "$pkg_prefix\include\" -Force
    mkdir "$pkg_prefix\include\sodium\"
    Copy-Item "$build_path\src\$pkg_name\include\sodium\*.h" "$pkg_prefix\include\sodium\" -Force
}
