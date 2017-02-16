pkg_name=aspnet-sample
pkg_origin=core
pkg_version=0.1.9
pkg_source=https://github.com/mwrock/habitat-${pkg_name}/archive/v${pkg_version}.tar.gz
pkg_shasum=50ffcbe1c0b49acb84365c2157445047b360345c7361e67827093f962852de4d
pkg_upstream_url=https://github.com/mwrock/habitat-aspnet-sample
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_description="A sample ASP.NET Core app for Linux"
pkg_exports=(
  [port]=port
)
pkg_exposes=(port)
pkg_deps=(core/dotnet-core)
pkg_build_deps=(core/node core/patchelf)

do_prepare() {
  rm -rf "${HAB_CACHE_SRC_PATH:?}/${pkg_dirname:?}"
  mv "$HAB_CACHE_SRC_PATH/habitat-$pkg_dirname" "$HAB_CACHE_SRC_PATH/$pkg_dirname"

  pushd "$HAB_CACHE_SRC_PATH/$pkg_dirname"
  npm install gulp
  npm install bower
  export PATH="$PATH:$HAB_CACHE_SRC_PATH/$pkg_dirname/node_modules/.bin"

  dotnet restore
  find /root/.nuget -type f -name '*.so*' \
    -exec patchelf --set-rpath "$LD_RUN_PATH" {} \;
  popd
}

do_build() {
  dotnet build
}

do_install() {
  dotnet publish --output "$pkg_prefix/www"
  find "$pkg_prefix/www" -type f -name '*.so*' \
    -exec patchelf --set-rpath "$LD_RUN_PATH" {} \;
}

do_strip() {
  return 0
}
