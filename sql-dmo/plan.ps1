$pkg_name="sql-dmo"
$pkg_origin="core"
$pkg_version="8.05.2004"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_license=@("SQL Server 2005 License")
$pkg_source="http://download.microsoft.com/download/2/7/c/27c60d49-6dbe-423e-9a9e-1c873f269484/SQLServer2005_BC_x64.msi"
$pkg_shasum="6b8d83f50e999a092d77e20486feeac567da7f53db01b6b4935a5cf00f6b461b"
$pkg_description = "Microsoft SQL Server 2005 Distributed Management Objects"
$pkg_upstream_url="https://www.microsoft.com/en-us/download/details.aspx?id=24793"
$pkg_build_deps=@("core/lessmsi")

function Invoke-Unpack() {
    lessmsi x (Resolve-Path "$HAB_CACHE_SRC_PATH/SQLServer2005_BC_x64.msi").Path
    mkdir "$HAB_CACHE_SRC_PATH/$pkg_dirname"
    Move-Item "SQLServer2005_BC_x64" "$HAB_CACHE_SRC_PATH/$pkg_dirname"
}

function Invoke-Install() {
    $resolved = (Resolve-Path "$HAB_CACHE_SRC_PATH/$pkg_dirname/SQLServer2005_BC_x64/SourceDir").Path
    Get-ChildItem "$HAB_CACHE_SRC_PATH/$pkg_dirname/SQLServer2005_BC_x64/SourceDir/*" -Recurse -Include @("*dmo*") | % {
        $newDir = $_.Directory.Fullname.Replace($resolved, $pkg_prefix)
        if(!(Test-Path $newDir)) {
            New-Item -ItemType Directory $newDir
        }
        Copy-Item $_ $newDir
    }
    Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_dirname/SQLServer2005_BC_x64/SourceDir/Program Files (x86)\Microsoft SQL Server\80\Tools\binn\msvcr71.dll" "$pkg_prefix\Program Files (x86)\Microsoft SQL Server\80\Tools\binn"
}
