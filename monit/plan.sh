pkg_name=monit
pkg_origin=core
pkg_version="5.24.0"
pkg_upstream_url="https://mmonit.com/monit"
pkg_description="Monit. Barking at daemons"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('AGPL-3.0')
pkg_source="https://mmonit.com/monit/dist/monit-${pkg_version}.tar.gz"
pkg_shasum="754d1f0e165e5a26d4639a6a83f44ccf839e381f2622e0946d5302fa1f2d2414"
pkg_deps=(core/glibc core/zlib core/openssl core/bash)
pkg_build_deps=(core/make core/gcc)
pkg_bin_dirs=(bin)
pkg_svc_user=root
pkg_svc_group=root

do_build() {
    ./configure --prefix="$pkg_prefix" \
                --without-pam \
                --with-ssl-incl-dir="$(pkg_path_for core/openssl)/include"
    make
}
