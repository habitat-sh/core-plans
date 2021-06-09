$pkg_name="visual-build-tools-2019"
$pkg_origin="core"
$pkg_version="16.8.1"
$pkg_description="Standalone compiler, libraries and scripts"
$pkg_upstream_url="https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2019"
$pkg_license=@("Microsoft Software License")
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="https://download.visualstudio.microsoft.com/download/pr/44fbb1ed-c06e-41c9-bc39-3d7f2083d61b/d3ffaa4ec21a06d29b773e544c0c613df65b270ad30c036b623188a8b12dd745/vs_BuildTools.exe"
$pkg_shasum="d3ffaa4ec21a06d29b773e544c0c613df65b270ad30c036b623188a8b12dd745"
$pkg_build_deps=@("core/7zip")

$pkg_bin_dirs=@(
    "Contents\VC\Tools\MSVC\14.28.29333\bin\HostX64\x64",
    "Contents\VC\Redist\MSVC\14.28.29325\x64\Microsoft.VC142.CRT",
    "Contents\MSBuild\Current\Bin\amd64"
)
$pkg_lib_dirs=@(
    "Contents\VC\Tools\MSVC\14.28.29333\atlmfc\lib\x64",
    "Contents\VC\Tools\MSVC\14.28.29333\lib\x64"
)
$pkg_include_dirs=@(
    "Contents\VC\Tools\MSVC\14.28.29333\atlmfc\include",
    "Contents\VC\Tools\MSVC\14.28.29333\include"
)

function Invoke-SetupEnvironment {
    Set-RuntimeEnv "DisableRegistryUse" "true"
    Set-RuntimeEnv "UseEnv" "true"
    Set-RuntimeEnv "VCToolsVersion" "14.28.29325"
    Set-RuntimeEnv -IsPath "VCToolsInstallDir_160" "$pkg_prefix\Contents\VC\Redist\MSVC\14.28.29325"
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
    Invoke-WebRequest $opcInstaller -Outfile "$HAB_CACHE_SRC_PATH/$pkg_dirname/vs_installer.opc"
    7z x "$HAB_CACHE_SRC_PATH/$pkg_dirname/vs_installer.opc" -o"$HAB_CACHE_SRC_PATH/$pkg_dirname"

    $installArgs =  "layout --quiet --layout $HAB_CACHE_SRC_PATH/$pkg_dirname --lang en-US --in $HAB_CACHE_SRC_PATH/$pkg_dirname/vs_bootstrapper_d15/vs_setup_bootstrapper.json"
    $components = @(
        "Microsoft.VisualStudio.Workload.MSBuildTools",
        "Microsoft.VisualStudio.Workload.VCTools",
        "Microsoft.VisualStudio.Workload.WebBuildTools",
        "Microsoft.VisualStudio.Component.VC.Tools.x86.x64",
        "Microsoft.VisualStudio.Component.SQL.SSDTBuildSku",
        "Microsoft.VisualStudio.Component.VC.ATLMFC",
        "Microsoft.VisualStudio.Component.NuGet.BuildTools",
        "Microsoft.VisualStudio.Component.VC.CLI.Support"
    )
    foreach ($component in $components) {
        $installArgs += " --add $component"
    }

    $setup = "$HAB_CACHE_SRC_PATH/$pkg_dirname/Contents/resources/app/layout/setup.exe"
    Write-Host "Launching $setup with args: $installArgs"
    Start-Process -FilePath $setup -ArgumentList $installArgs.Split(" ") -Wait
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
