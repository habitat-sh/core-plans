$pkg_name="visual-build-tools-2017"
$pkg_origin="core"
$pkg_version="15.9.45"
$pkg_description="Standalone compiler, libraries and scripts"
$pkg_upstream_url="https://www.visualstudio.com/downloads/#build-tools-for-visual-studio-2017"
$pkg_license=@("Microsoft Software License")
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_source="
https://download.visualstudio.microsoft.com/download/pr/4dfffe3f-2a7e-4dea-922b-62d4beca5e36/e10c2bfb0e7b0358c24bd0df951f3d81897f309a0642a199b93f248db303263c/vs_BuildTools.exe"
$pkg_shasum="e10c2bfb0e7b0358c24bd0df951f3d81897f309a0642a199b93f248db303263c"
$pkg_build_deps=@("core/7zip")

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
    Set-RuntimeEnv "VCToolsVersion" "14.16.27012"
    Set-RuntimeEnv -IsPath "VCToolsInstallDir_160" "$pkg_prefix\Contents\VC\Redist\MSVC\14.16.27012"
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
