pkg_origin=core
pkg_name=stringencoders
pkg_version=3.10.3
pkg_dirname=stringencoders-e0d6a9b294c9ab619c510c1f6317bb9ec7194d77
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('BSD-3-Clause' 'Apache-2.0')
pkg_source=https://github.com/client9/stringencoders/archive/e0d6a9b294c9ab619c510c1f6317bb9ec7194d77.tar.gz
pkg_shasum=6d5bc3eeea1f2a73d35d558746bbb35916f1a159a2b52ed78e9c20a29050607e
pkg_deps=(core/glibc)
pkg_build_deps=(core/gcc core/make core/perl core/patch core/file core/diffutils)
pkg_bin_dirs=(bin)
pkg_include_dirs=(include)
pkg_lib_dirs=(lib)
pkg_upstream_url=https://github.com/client9/stringencoders
pkg_description="Fast c-string transformations"

# The Git hash referenced above is the same as Debian / Ubuntu's 3.10.3 release. Tags seem to have
# been lost after this moved from Google Code to Github.

do_prepare () {
  patch -p1 -i "${PLAN_CONTEXT}/remove-path-for-file.patch"
  patch -p1 -i "${PLAN_CONTEXT}/unused-variable-in-tests.patch"
}

do_check () {
  LD_LIBRARY_PATH=$(pkg_path_for core/gcc-libs)/lib make test
}
