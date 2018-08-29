pkg_name=libsasl2
pkg_distname=cyrus-sasl
pkg_origin=core
pkg_version="2.1.26"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Apache-2.0")
pkg_source="ftp://ftp.cyrusimap.org/cyrus-sasl/${pkg_distname}-${pkg_version}.tar.gz"
pkg_dirname="${pkg_distname}-${pkg_version}"
pkg_shasum="8fbc5136512b59bb793657f36fadda6359cae3b08f01fd16b3d406f1345b7bc3"
pkg_deps=(core/glibc core/openssl)
pkg_build_deps=(core/make core/gcc)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)
pkg_description="Simple Authentication and Security Layer library."
pkg_upstream_url="https://www.cyrusimap.org/sasl/index.html"

