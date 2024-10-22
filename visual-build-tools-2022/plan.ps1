$pkg_name="visual-build-tools-2022"
$pkg_origin="core"
$pkg_version="17.11.0"
$pkg_description="Standalone compiler, libraries and scripts"
$pkg_upstream_url="https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2022"
# https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2022
$pkg_license=@("Microsoft Software License")
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://aka.ms/vs/17/release/vs_BuildTools.exe"
$pkg_shasum="99c7677154366062a43082921f40f3ce00ef2614dbf94db23b244dd13dc9443d"
$pkg_build_deps=@("core/7zip")

$pkg_bin_dirs=@(
    "Contents\VC\Tools\MSVC\14.41.34120\bin\HostX64\x64",
    "Contents\VC\Redist\MSVC\14.40.33807\x64\Microsoft.VC143.CRT",
    "Contents\MSBuild\Current\Bin"
)
$pkg_lib_dirs=@(
    "Contents\VC\Tools\MSVC\14.41.34120\atlmfc\lib\x64",
    "Contents\VC\Tools\MSVC\14.41.34120\lib\x64"
)
$pkg_include_dirs=@(
    "Contents\VC\Tools\MSVC\14.41.34120\atlmfc\include",
    "Contents\VC\Tools\MSVC\14.41.34120\include"
)

function Invoke-SetupEnvironment {
    Set-RuntimeEnv "DisableRegistryUse" "true"
    Set-RuntimeEnv "UseEnv" "true"
    Set-RuntimeEnv "VCToolsVersion" "14.41.34120"
    Set-RuntimeEnv "VisualStudioVersion" "17.0"
    Set-RuntimeEnv -IsPath "VCToolsInstallDir_170" "$pkg_prefix\Contents\VC\Redist\MSVC\14.41.34120"
}

function Invoke-Unpack {
    # This makes me very sad, but is a necessary evil to get the layout working in docker.
    # In previous VS versions or in a non-docker environment, you should just call the
    # downloaded vs_buildtools.exe with the --layout arguments but that seems to fail
    # in a container. To work around that, we need to extract some data from the installer,
    # download the setup.exe program and then invoke it directly. Note that this will
    # write a 'Unhandled Exception: System.IO.IOException: The parameter is incorrect' error
    # to the console but by this time we have everything we need to proceed.
    7z x "$HAB_CACHE_SRC_PATH/$pkg_filename" -o"$HAB_CACHE_SRC_PATH/$pkg_dirname"
    $opcInstaller = (Get-Content "$HAB_CACHE_SRC_PATH\$pkg_dirname\vs_bootstrapper_d15\vs_setup_bootstrapper.config")[0].Split("=")[-1]
    Invoke-RestMethod $opcInstaller -OutFile "$HAB_CACHE_SRC_PATH/$pkg_dirname/vs_installer.opc"
    Expand-Archive "$HAB_CACHE_SRC_PATH/$pkg_dirname/vs_installer.opc" -DestinationPath "$HAB_CACHE_SRC_PATH\$pkg_dirname"

    $installArgs =  "layout --quiet --layout $HAB_CACHE_SRC_PATH/products --lang en-US --in $HAB_CACHE_SRC_PATH/$pkg_dirname/vs_bootstrapper_d15/vs_setup_bootstrapper.json"
    $components = @(
        "Microsoft.VisualStudio.Workload.MSBuildTools",
        "Microsoft.VisualStudio.Workload.VCTools",
        "Microsoft.VisualStudio.Workload.WebBuildTools",
        "Microsoft.VisualStudio.Component.VC.Tools.x86.x64",
        "Microsoft.VisualStudio.Component.SQL.SSDTBuildSku",
        "Microsoft.VisualStudio.Component.VC.ATLMFC",
        "Microsoft.VisualStudio.Component.NuGet.BuildTools",
        "Microsoft.VisualStudio.Component.VC.CLI.Support",
        "Microsoft.VisualStudio.Component.Windows11SDK.26100",
        "Microsoft.VisualStudio.Component.VC.CMake.Project"
    )
    foreach ($component in $components) {
        $installArgs += " --add $component"
    }

    $setup = "$HAB_CACHE_SRC_PATH/$pkg_dirname/Contents/resources/app/layout/setup.exe"
    Write-Host "Launching $setup with args: $installArgs"
    Start-Process $setup -ArgumentList $installArgs -Wait
    Push-Location $HAB_CACHE_SRC_PATH
    try {
        Get-ChildItem "$HAB_CACHE_SRC_PATH/products" -Include *.vsix -Exclude @('*x64*', '*.arm.*') -Recurse | ForEach-Object {
            Rename-Item $_ "$_.zip"
            Expand-Archive "$_.zip" vst -Force
        }
    } finally { Pop-Location }
}

function Invoke-Install {
    Copy-Item "$HAB_CACHE_SRC_PATH\vst\Contents" $pkg_prefix -Force -Recurse
}
