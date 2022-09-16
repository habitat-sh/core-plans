$pkg_name="protobuf"
$pkg_origin="core"
$pkg_version="3.19.4"
$pkg_file_name=$pkg_name + ($pkg_version).Replace(".", "")
$pkg_description="Protocol buffers are a language-neutral, platform-neutral extensible mechanism for serializing structured data."
$pkg_upstream_url="https://developers.google.com/protocol-buffers/"
$pkg_license=("BSD")
$pkg_source="https://github.com/google/${pkg_name}/releases/download/v${pkg_version}/${pkg_name}-all-${pkg_version}.zip"
$pkg_shasum="aabe421c26836c520256cafaee0fca2ba7b02759c60ef1174a96a531c2d75f75"
$pkg_deps=@(
    "core/zlib"
)
$pkg_build_deps=@(
    "core/visual-cpp-build-tools-2015",
    "core/cmake"
)
$pkg_bin_dirs=@("bin")
$pkg_lib_dirs=@("lib")
$pkg_include_dirs=@("include")

function Invoke-SetupEnvironment {
    . "$(Get-HabPackagePath visual-cpp-build-tools-2015)\setenv.ps1"
}

function Invoke-Build {
    Set-Location "$pkg_name-$pkg_version\cmake"

    $zlib_libdir = "$(Get-HabPackagePath zlib)\lib\zlibwapi.lib"
    $zlib_includedir = "$(Get-HabPackagePath zlib)\include"

    mkdir build
    Set-Location build
    cmake -G "Visual Studio 14 2015 Win64" -T "v140" -DCMAKE_SYSTEM_VERSION="8.1" -DCMAKE_INSTALL_PREFIX=../../../../install -DZLIB_LIBRARY_RELEASE="${zlib_libdir}" -DZLIB_INCLUDE_DIR="${zlib_includedir}" ..
    # We'll build the required parts here
    msbuild /p:Configuration=Release /p:Platform=x64 "INSTALL.vcxproj"
    if($LASTEXITCODE -ne 0) { Write-Error "msbuild failed!" }

    .\extract_includes.bat
}

function Invoke-Install {
    Copy-Item "$HAB_CACHE_SRC_PATH\$pkg_name-$pkg_version\$pkg_name-$pkg_version\cmake\build\Release\protoc.exe" "$pkg_prefix\bin\" -Force
    Copy-Item "$HAB_CACHE_SRC_PATH\$pkg_name-$pkg_version\$pkg_name-$pkg_version\cmake\build\Release\*.lib" "$pkg_prefix\lib\" -Force
    Copy-Item "$HAB_CACHE_SRC_PATH\$pkg_name-$pkg_version\$pkg_name-$pkg_version\cmake\build\include\*" "$pkg_prefix\include\" -Force -Recurse
}
