$pkg_name="sqlserver"
$pkg_origin="core"
$pkg_version="14.0.1000"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_license=@("SQL Server 2017 License")
$pkg_source="https://download.microsoft.com/download/5/E/9/5E9B18CC-8FD5-467E-B5BF-BADE39C51F73/SQLServer2017-SSEI-Expr.exe"
$pkg_shasum="d8a5cd8f4380be195af82d0ddc21316713ab2b41ff6c48d86f87c5778de18411"
$pkg_bin_dirs=@("bin")
$pkg_deps=@("core/dsc-core")
$pkg_exports=@{
    port     ="port"
    password ="app_password"
    username ="app_user"
    instance ="instance"
}
$pkg_description = "Microsoft SQL Server"
$pkg_upstream_url="https://www.microsoft.com/en-us/sql-server/sql-server-editions-express"

function Invoke-Unpack {
    Start-Process "$HAB_CACHE_SRC_PATH/$pkg_filename" -Wait -ArgumentList "/ACTION=Download /MEDIAPATH=$HAB_CACHE_SRC_PATH /MEDIATYPE=Core /QUIET"
    Start-Process "$HAB_CACHE_SRC_PATH/SQLEXPR_x64_ENU.exe" -Wait -ArgumentList "/x:$HAB_CACHE_SRC_PATH/$pkg_dirname /u"
}

function Invoke-Install {
    Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_dirname/*" $pkg_prefix/bin -Recurse
}
