pkg_name=buildah
pkg_origin=core
pkg_version="1.19.8"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Apache-2.0")
pkg_deps=(
    core/devicemapper
    core/gpgme
    core/libassuan
    core/libgpg-error
    core/libseccomp
    core/runc
    core/shadow
    core/util-linux
)
pkg_build_deps=(
    core/btrfs-progs
    core/bzip2
    core/coreutils
    core/gcc
    core/git
    core/go
    core/make
    core/pkg-config
)
pkg_bin_dirs=(bin)
pkg_description="A tool which facilitates building OCI images"
pkg_upstream_url="https://github.com/containers/buildah"

do_download() {
    repo_path="${HAB_CACHED_SRC_PATH}/${pkg_dirname}"
    rm -Rf "${repo_path}"
    git clone \
        --branch "v${pkg_version}" \
        --single-branch \
        "${pkg_upstream_url}" \
        "${repo_path}"
}

do_prepare() {
    # Buildah has a few accessory scripts that have `#!/usr/bin/env`
    # shebang lines, so we have to make them happy
    if [[ ! -r /usr/bin/env ]]; then
        ln -sv "$(pkg_path_for coreutils)/bin/env" /usr/bin/env
    fi
}

do_build() {
    (
        cd "${HAB_CACHED_SRC_PATH}/${pkg_dirname}"
        export CGO_LDFLAGS="$LDFLAGS"
        export CGO_CFLAGS="$CFLAGS"
        make
    )
}

do_install() {
    cp "${HAB_CACHED_SRC_PATH}/${pkg_dirname}/bin/buildah" "${pkg_prefix}/bin"
}
