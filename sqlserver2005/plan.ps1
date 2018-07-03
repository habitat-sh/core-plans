$pkg_name="sqlserver2005"
$pkg_origin="core"
$pkg_version="9.0.3042"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_license=@("SQL Server 2005 License")
$pkg_source="https://download.microsoft.com/download/1/5/8/15840bb5-30d9-4ba2-b6bd-32424d22f0f9/SQLEXPR_ADV.EXE"
$pkg_shasum="9f333f5e4b501d7a303ea3dfa0afcb88c20d8fb7b10e9c60869830b4c996c444"
$pkg_bin_dirs=@("bin")
$pkg_deps=@("core/dsc-core")
$pkg_exports=@{
  port="port"
  password="app_password"
  username="app_user"
  instance="instance"
}
$pkg_description = "Microsoft SQL Server 2005"
$pkg_upstream_url="https://www.microsoft.com/en-us/sql-server/sql-server-editions-express"

function Invoke-Unpack {
    Start-Process "$HAB_CACHE_SRC_PATH/$pkg_filename" -Wait -ArgumentList "/x:$HAB_CACHE_SRC_PATH/$pkg_dirname /u"
}

function Invoke-Install {
    Copy-Item "$HAB_CACHE_SRC_PATH/$pkg_dirname/*" $pkg_prefix/bin -Recurse
}
