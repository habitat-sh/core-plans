. "..\node\plan.ps1"

$pkg_name="node10"
$pkg_origin="core"
$pkg_version="10.24.1"
$pkg_description="Node.js® is a JavaScript runtime built on Chrome's V8 JavaScript engine."
$pkg_source="https://nodejs.org/dist/v$pkg_version/node-v$pkg_version-x64.msi"
$pkg_shasum="dab263436eeda26c9c4809ba4d93e607dcffb3735b9a1866c77afb242a832dbd"

function Invoke-Check() {
    (& "$HAB_CACHE_SRC_PATH/$pkg_dirname/node-v$pkg_version-x64/SourceDir/nodejs/node" --version) -eq "v$pkg_version"
}