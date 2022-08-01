pkg_name="runc"
pkg_origin="core"
pkg_version=1.0.0-rc93
pkg_description="CLI tool for spawning and running containers according to the OCI specification"
pkg_upstream_url="https://www.opencontainers.org/"
pkg_license=('Apache-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/opencontainers/runc"
pkg_bin_dirs=(bin)
pkg_scaffolding=core/scaffolding-go
pkg_build_deps=(core/pkg-config
                core/libseccomp)

# We have to override a handful of callbacks from the go scaffolding
# in order for things to work properly.

# Overridden in order to be able to target a specific release of runc;
# absent this, we build based on whatever is on the master branch at
# the time of the build. Additionally, without this, the defined
# `pkg_version` has no connection at all to the code that is
# ultimately built.
do_download() {
    if [ -d "$scaffolding_go_pkg_path" ]; then
        rm -rf "$scaffolding_go_pkg_path"
    fi
    git clone \
        --branch "v${pkg_version}" \
        --single-branch \
        "${pkg_source}" \
        "${scaffolding_go_pkg_path}"
}

# Overridden to provide a static binary.
do_build() {
  (
      cd "${scaffolding_go_pkg_path}"
      make static
  )
}

# The go scaffolding uses `go install` in this callback, which appears
# to build the binary a second time, but with a different
# configuration as used in `do_build`. This simply copies the binary.
do_install() {
    cp "${scaffolding_go_pkg_path}/runc" "${pkg_prefix}/bin"
}
