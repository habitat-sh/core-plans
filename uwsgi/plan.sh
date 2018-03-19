pkg_name=uwsgi
pkg_description="uWSGI application server container"
pkg_upstream_url=https://github.com/unbit/uwsgi
# $HAB_ORIGIN overrides pkg_origin.
pkg_origin=origin
pkg_version=2.0.15
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("GPL-2.0")
pkg_source=https://github.com/unbit/${pkg_name}/archive/${pkg_version}.tar.gz
pkg_shasum=251f0670628ce9b9f4c2b4288a7ea921e2ddb3d5e886b6aa2358273573e6fdcf
pkg_dirname=${pkg_name}-${pkg_version}
pkg_deps=(core/pcre core/python)
pkg_build_deps=(core/gcc core/make)
pkg_bin_dirs=(bin)

do_build() {
    make
}

do_install() {
    install -D uwsgi "$pkg_prefix"/bin/uwsgi
}
