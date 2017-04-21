pkg_name=broken-python
pkg_description="Example of broken thread usage in core/python."
# $HAB_ORIGIN overrides pkg_origin.
pkg_origin=origin
pkg_version=0.1.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Apache-2.0")
pkg_source=https://github.com/habitat-sh/core-plans
pkg_deps=(core/python)

do_download() {
    return 0
}

do_verify() {
    return 0
}

do_unpack() {
    return 0
}

do_prepare() {
    cp $PLAN_CONTEXT/*.py $HAB_CACHE_SRC_PATH/$pkg_dirname
}

do_build() {
    return 0
}

do_install() {
    cp *.py $pkg_prefix
}
