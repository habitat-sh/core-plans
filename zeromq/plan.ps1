$pkg_name="zeromq"
$pkg_origin="core"
$pkg_version="4.3.1"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_description="ZeroMQ core engine in C++, implements ZMTP/3.1"
$pkg_upstream_url="http://zeromq.org"
$pkg_license=("LGPL-3.0-only")
$pkg_source="https://github.com/zeromq/libzmq/archive/v$pkg_version.zip"
$pkg_shasum="7bd60654ad122cff5c217a83442c1e1748a86b08e53cd96f6242404cb571ede8"
$pkg_deps=("core/libsodium")
$pkg_build_deps=("core/visual-cpp-build-tools-2015", "core/cmake")
$pkg_bin_dirs=("bin")
$pkg_include_dirs=("include")
$pkg_lib_dirs=("lib")

function Invoke-SetupEnvironment {
    . "$(Get-HabPackagePath visual-cpp-build-tools-2015)\setenv.ps1"
}

function Invoke-Build {
    cd "libzmq-$pkg_version"

    $sodium_includedir = "$(Get-HabPackagePath libsodium)\include"

    mkdir cmake-build
    cd cmake-build
    cmake -G "Visual Studio 14 2015 Win64" -T "v140" -DCMAKE_SYSTEM_VERSION="8.1" -DCMAKE_INSTALL_PREFIX="${prefix_path}\zeromq" -DWITH_LIBSODIUM="true" -DSODIUM_INCLUDE_DIRS="${sodium_includedir}" -DENABLE_CURVE="false" ..

    msbuild /p:Configuration=Release /p:Platform=x64 "ZeroMQ.sln"
    if($LASTEXITCODE -ne 0) { Write-Error "msbuild failed!" }
}

function Invoke-Install {
    Copy-Item "$HAB_CACHE_SRC_PATH\$pkg_name-$pkg_version\libzmq-$pkg_version\cmake-build\bin\Release\libzmq-v140-mt-4_3_1.dll" "$pkg_prefix\bin\" -Force
    Copy-Item "$HAB_CACHE_SRC_PATH\$pkg_name-$pkg_version\libzmq-$pkg_version\cmake-build\bin\Release\libzmq-v140-mt-4_3_1.dll" "$pkg_prefix\bin\zmq.dll" -Force
    Copy-Item "$HAB_CACHE_SRC_PATH\$pkg_name-$pkg_version\libzmq-$pkg_version\cmake-build\lib\Release\*.lib" "$pkg_prefix\lib\" -Force
    Copy-Item "$HAB_CACHE_SRC_PATH\$pkg_name-$pkg_version\libzmq-$pkg_version\cmake-build\lib\Release\libzmq-v140-mt-4_3_1.lib" "$pkg_prefix\lib\zmq.lib" -Force
    Copy-Item "$HAB_CACHE_SRC_PATH\$pkg_name-$pkg_version\libzmq-$pkg_version\include\*" "$pkg_prefix\include\" -Force
}
