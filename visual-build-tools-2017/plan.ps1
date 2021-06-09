$pkg_name="visual-build-tools-2017"
$pkg_origin="core"
$pkg_version="15.9.28307.1525"
$pkg_description="Standalone compiler, libraries and scripts"
$pkg_upstream_url="https://www.visualstudio.com/downloads/#build-tools-for-visual-studio-2017"
$pkg_license=@("Microsoft Software License")
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://download.microsoft.com/download/5/A/8/5A8B8314-CA70-4225-9AF0-9E957C9771F7/vs_BuildTools.exe"
$pkg_shasum="e77d433c44f3d0cbf7a3efa497101de93918c492c2ebcaec79a1faf593d419bc"

$pkg_bin_dirs=@(
    "Contents\VC\Tools\MSVC\14.16.27023\bin\HostX64\x64",
    "Contents\VC\Redist\MSVC\14.16.27012\x64\Microsoft.VC141.CRT",
    "Contents\MSBuild\15.0\Bin\amd64"
)
$pkg_lib_dirs=@(
    "Contents\VC\Tools\MSVC\14.16.27023\atlmfc\lib\x64",
    "Contents\VC\Tools\MSVC\14.16.27023\lib\x64"
)
$pkg_include_dirs=@(
    "Contents\VC\Tools\MSVC\14.16.27023\atlmfc\include",
    "Contents\VC\Tools\MSVC\14.16.27023\include"
)

function Invoke-SetupEnvironment {
    Set-RuntimeEnv "DisableRegistryUse" "true"
    Set-RuntimeEnv "UseEnv" "true"
}

function Invoke-Unpack {
    # This suffers the same issue that the visual-build-tools-2019/plan.ps1 setup does;
    # I believe that previous versions of this file vs_buildtools.exe --layout would work
    # but it unfortunately doesn't anymore. As such we're following what
    # visual-build-tools-2019/plan.ps1 does. Take a look at the Invoke-Unpack function there
    # for a better explanation.
    7z x "$HAB_CACHE_SRC_PATH/$pkg_filename" -o"$HAB_CACHE_SRC_PATH/$pkg_dirname"
    $opcInstaller = (Get-Content "$HAB_CACHE_SRC_PATH\$pkg_dirname\vs_bootstrapper_d15\vs_setup_bootstrapper.config")[0].Split("=")[-1]
    Invoke-WebRequest $opcInstaller -Outfile "$HAB_CACHE_SRC_PATH/$pkg_dirname/vs_installer.opc"
    7z x "$HAB_CACHE_SRC_PATH/$pkg_dirname/vs_installer.opc" -o"$HAB_CACHE_SRC_PATH/$pkg_dirname"

    $installArgs =  "layout --quiet --layout $HAB_CACHE_SRC_PATH/$pkg_dirname --lang en-US --in $HAB_CACHE_SRC_PATH/$pkg_dirname/vs_bootstrapper_d15/vs_setup_bootstrapper.json"
    $components = @(
        "Microsoft.VisualStudio.Workload.MSBuildTools",
        "Microsoft.VisualStudio.Workload.VCTools",
        "Microsoft.VisualStudio.Component.SQL.SSDTBuildSku",
        "Microsoft.VisualStudio.Component.VC.ATLMFC",
        "Microsoft.VisualStudio.Component.NuGet.BuildTools"
    )
    foreach ($component in $components) {
        $installArgs += " --add $component"
    }
    
    $setup = "$HAB_CACHE_SRC_PATH/$pkg_dirname/Contents/resources/app/layout/setup.exe"
    Write-Host "Launching $setup with args: $installArgs"
    & $setup $installArgs.Split(" ")
    Push-Location "$HAB_CACHE_SRC_PATH/$pkg_dirname"
    try {
        Get-ChildItem "$HAB_CACHE_SRC_PATH/$pkg_dirname" -Include *.vsix -Exclude @('*x86*', '*.arm.*') -Recurse | ForEach-Object {
            Rename-Item $_ "$_.zip"
            Expand-Archive "$_.zip" expanded -force
        }
    } finally { Pop-Location }
}

function Invoke-Install {
    Copy-Item "$HAB_CACHE_SRC_PATH\$pkg_dirname\expanded\Contents" $pkg_prefix -Force -Recurse
}
