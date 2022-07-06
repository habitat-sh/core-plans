$pkg_name="raml2html"
$pkg_origin="core"
$pkg_version="6.7.0"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_license=@('MIT')
$pkg_deps=@('core/node')
$pkg_description="RAML to HTML documentation generator."
$pkg_upstream_url="https://github.com/raml2html/raml2html"
$pkg_bin_dirs=@('bin')

function Invoke-Build {
    npm i -g "${pkg_name}@$pkg_version" --prefix "$HAB_CACHE_SRC_PATH/$pkg_dirname"
}

function Invoke-Install() {
    Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_dirname/node_modules/$pkg_name/*" $pkg_prefix -Recurse -Force
    Copy-Item "$PLAN_CONTEXT\raml2html.bat" "$pkg_prefix\bin"
}
