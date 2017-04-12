pkg_name=crate
pkg_origin=endocode
pkg_version="1.1.2"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_source="https://cdn.crate.io/downloads/releases/crate-1.1.2.tar.gz"
pkg_shasum="8f22b6531b3d1c8602a880779bbe09e5295ef0959a30aff0986575835aadc937"
pkg_deps=(core/jre8)
pkg_bin_dirs=(crate/bin)
pkg_lib_dirs=(crate/lib)
pkg_exports=(
    [http]=network.port
    [transport]=transport.port
    [postgres]=postgres.port
pkg_exposes=(http transport postgres)
pkg_description="CrateDB is an open source SQL database with a ground-breaking distributed design."

do_build() {
    return 0
}

do_install() {
    mkdir -p ${pkg_prefix}/crate
    cp -a bin lib plugins ${pkg_prefix}/crate
    rm ${pkg_prefix}/crate/bin/*.bat
}

do_strip() {
    return 0
}
