pkg_name=crate
pkg_origin=core
pkg_version="1.1.6"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_source="https://cdn.crate.io/downloads/releases/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum=fbf993a779467c722e548b4282efcfae65fd669c746d2fa228e70813a7f4b4a2
pkg_build_deps=(core/gnupg)
pkg_deps=(core/corretto8 core/curl core/busybox-static)
pkg_bin_dirs=(crate/bin)
pkg_lib_dirs=(crate/lib)
pkg_exports=(
    [http]=http.port
    [transport]=transport.tcp.port
    [postgres]=psql.port
)
pkg_exposes=(http transport postgres)
pkg_upstream_url="https://crate.io"
pkg_description="CrateDB is an open source SQL database with a ground-breaking distributed design."

do_download() {
    # Download the source file, as usual
    do_default_download

    # Now also grab the signature for the source
    # Provide the checksum so that file does not get downloaded with every build
    download_file "https://cdn.crate.io/downloads/releases/${pkg_name}-${pkg_version}.tar.gz.asc" \
		  "${pkg_name}-${pkg_version}.tar.gz.asc" \
		  "4e6007a35b99c0da75356cb6cd7aeafd7d380e1a5f5fa26b79a0dfa0a9898924"
}

do_verify() {
    # Firstly perform the standard checksum-based verification
    do_default_verify

    # Now verify the signature file
    verify_file "${pkg_name}-${pkg_version}.tar.gz.asc" \
    		"4e6007a35b99c0da75356cb6cd7aeafd7d380e1a5f5fa26b79a0dfa0a9898924"

    # Now do the GPG-based verification
    build_line "Verifying crate-${pkg_version}.tar.gz signature"
    GNUPGHOME=$(mktemp -d -p "$HAB_CACHE_SRC_PATH")
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys 90C23FC6585BC0717F8FBFC37FAAE51A06F6EAEB
    gpg --batch --verify "${HAB_CACHE_SRC_PATH}"/${pkg_name}-${pkg_version}.tar.gz.asc \
	"${HAB_CACHE_SRC_PATH}"/${pkg_name}-${pkg_version}.tar.gz
    rm -r "$GNUPGHOME"
    build_line "Signature verified for ${pkg_name}-${pkg_version}.tar.gz"
}

do_build() {
    return 0
}

do_install() {
    cd "${HAB_CACHE_SRC_PATH}"/${pkg_name}-${pkg_version} || exit
    install -vDm644 README.rst "${pkg_prefix}"/README.rst
    install -vDm644 LICENSE.txt "${pkg_prefix}"/LICENSE.txt
    install -vDm644 NOTICE "${pkg_prefix}"/NOTICE
    install -vDm644 CHANGES.txt "${pkg_prefix}"/CHANGES.txt

    mkdir -p "${pkg_prefix}"/crate
    cp -a bin lib plugins "${pkg_prefix}"/crate
    rm "${pkg_prefix}"/crate/bin/*.bat
}

do_strip() {
    return 0
}
