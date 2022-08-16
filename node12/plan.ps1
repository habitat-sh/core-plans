. "..\node\plan.ps1"

$pkg_name="node12"
$pkg_origin="core"
$pkg_version="12.22.10"
$pkg_description="Node.js® is a JavaScript runtime built on Chrome's V8 JavaScript engine."
$pkg_source="https://nodejs.org/dist/v$pkg_version/node-v$pkg_version-x64.msi"
$pkg_shasum="3fe6f727581c2f46a1ce7f9e2fd79ab16010a49878f1e566cf7fddc2e09a87c8"

function Invoke-Check() {
    (& "$HAB_CACHE_SRC_PATH/$pkg_dirname/node-v$pkg_version-x64/SourceDir/nodejs/node" --version) -eq "v$pkg_version"
}
