$pkg_name="python"
$pkg_version="3.9.5"
$pkg_origin="core"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_license=@('Python-2.0')
$pkg_description="Python is a programming language that lets you work quickly and integrate systems more effectively."
$pkg_upstream_url="https://www.python.org"
$pkg_build_deps=@("core/nuget")
$pkg_bin_dirs=@("bin", "bin/Scripts")

function Invoke-Build {
    nuget install python -version $pkg_version -ExcludeVersion -OutputDirectory "$HAB_CACHE_SRC_PATH/$pkg_dirname"
}

function Invoke-Install {
    Remove-Item "$pkg_prefix/bin/Scripts"
    Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_dirname/python/tools/*" "$pkg_prefix/bin" -Recurse
}

function Invoke-Check {
    & "$HAB_CACHE_SRC_PATH/$pkg_dirname/python/tools/python" -m pip --version
    if($LASTEXITCODE -ne 0) { Write-Error "Invoke check failed with error code $LASTEXITCODE" }
}
