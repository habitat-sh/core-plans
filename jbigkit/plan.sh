pkg_name=jbigkit
pkg_origin=core
pkg_version=2.1
pkg_description="An implementation of the JBIG1 data compression standard"
pkg_upstream_url=http://www.cl.cam.ac.uk/~mgk25/jbigkit/
pkg_license=('GPL-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="http://www.cl.cam.ac.uk/~mgk25/jbigkit/download/jbigkit-${pkg_version}.tar.gz"
pkg_shasum=de7106b6bfaf495d6865c7dd7ac6ca1381bd12e0d81405ea81e7f2167263d932
pkg_deps=(core/glibc)
pkg_build_deps=(core/gcc core/make core/patch core/coreutils core/diffutils)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)

do_prepare() {
    patch -p1 -i "${PLAN_CONTEXT}/libjbig-shared-library.patch"
}

do_build() {
    make
}

do_check() {
    make test
}

do_install() {
    _lib_dir="${pkg_prefix}/lib"
    _include_dir="${pkg_prefix}/include"
    _bin_dir="${pkg_prefix}/bin"
    _binaries="jbgtopbm jbgtopbm85 pbmtojbg pbmtojbg85"

    mkdir -p "${_lib_dir}"
    mkdir -p "${_include_dir}"
    mkdir -p "${_bin_dir}"

    install -p -m0755 "libjbig/libjbig.so.${pkg_version}" "${_lib_dir}"
    install -p -m0755 "libjbig/libjbig85.so.${pkg_version}" "${_lib_dir}"
    ln -sf "libjbig.so.${pkg_version}" "${_lib_dir}/libjbig.so"
    ln -sf "libjbig85.so.${pkg_version}" "${_lib_dir}/libjbig85.so"
    install -p -m0644 libjbig/jbig.h "${_include_dir}"
    install -p -m0644 libjbig/jbig85.h "${_include_dir}"
    install -p -m0644 libjbig/jbig_ar.h "${_include_dir}"
    for b in $_binaries; do
        install -p -m0755 "pbmtools/$b" "${_bin_dir}"
    done
}
