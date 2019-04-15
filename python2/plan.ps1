$pkg_name="python2"
$pkg_version="2.7.16"
$pkg_origin="core"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_license=@('Python-2.0')
$pkg_description="Python is a programming language that lets you work quickly and integrate systems more effectively."
$pkg_upstream_url="https://www.python.org"
$pkg_source="https://www.python.org/ftp/python/$pkg_version/python-$pkg_version.amd64.msi"
$pkg_shasum="7c0f45993019152d46041a7db4b947b919558fdb7a8f67bcd0535bc98d42b603"
$pkg_build_deps=@("core/lessmsi")
$pkg_bin_dirs=@("bin", "bin/Scripts")

function Invoke-SetupEnvironment {
    Set-RuntimeEnv "PYTHONIOENCODING" "UTF-8"
    Set-BuildtimeEnv "PYTHONIOENCODING" "UTF-8"
}

function Invoke-Unpack {
    mkdir "$HAB_CACHE_SRC_PATH/$pkg_dirname" | Out-Null

    Push-Location "$HAB_CACHE_SRC_PATH/$pkg_dirname"
    try {
      lessmsi x (Resolve-Path "$HAB_CACHE_SRC_PATH/$pkg_filename").Path
    }
    finally { Pop-Location }
  }

function Invoke-Build {
    $getPipScript = "$HAB_CACHE_SRC_PATH/$pkg_dirname/get-pip.py"
    Invoke-WebRequest https://bootstrap.pypa.io/get-pip.py -OutFile $getPipScript
    ."$HAB_CACHE_SRC_PATH/$pkg_dirname/python-$pkg_version.amd64/SourceDir/python.exe" $getPipScript --no-warn-script-location
}

function Invoke-Install {
    Remove-Item "$pkg_prefix/bin/Scripts"

    Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_dirname/python-$pkg_version.amd64/SourceDir/*" "$pkg_prefix/bin" -Recurse
}

function Invoke-Check {
    & "$HAB_CACHE_SRC_PATH/$pkg_dirname/python-$pkg_version.amd64/SourceDir/python" -m pip --version
    if($LASTEXITCODE -ne 0) { Write-Error "Invoke check failed with error code $LASTEXITCODE" }
}
