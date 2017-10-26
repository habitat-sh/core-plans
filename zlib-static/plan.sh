pkg_name=zlib-static
pkg_origin=core
pkg_version=1.2.8
pkg_description="Zlib static library"
pkg_upstream_url="http://zlib.net/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('zlib')
pkg_source=http://zlib.net/fossils/zlib-${pkg_version}.tar.gz
pkg_shasum=36658cb768a54c1d4dec43c3116c27ed893e88b02ecfcb44f2166f9c0b7f2a0d
pkg_dirname=zlib-${pkg_version}
pkg_build_deps=(core/make core/gcc)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)

do_build() {
    pushd "$HAB_CACHE_SRC_PATH/$pkg_dirname"
        ./configure --static
        make
    popd
}

do_install() {
    cp "$HAB_CACHE_SRC_PATH/$pkg_dirname/libz.a" "$pkg_prefix/lib/"
    cp "$HAB_CACHE_SRC_PATH/$pkg_dirname/*.h" "$pkg_prefix/include/"
}
