pkg_name="firejail"
pkg_origin="core"
pkg_version="0.9.72"
pkg_description="Firejail is a SUID sandbox program that reduces the risk of security breaches"
pkg_license=('GPL-2.0')
pkg_upstream_url="https://firejail.wordpress.com/"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/netblue30/firejail/archive/refs/tags/${pkg_version}.tar.gz"
pkg_shasum="fa641abe2f673cef304cee6ef0a8ddb69db7919e0b69752f89762a341a87fabc"

pkg_deps=(
	core/glibc
)
pkg_build_deps=(
	core/make
       	core/gcc
)

pkg_lib_dirs=(lib)
pkg_bin_dirs=(bin)

do_build() {
	./configure --prefix="${pkg_prefix}"
	make all
}

# The default implementation runs nothing during post-compile. An example of a
# command you might use in this callback is make test. To use this callback, two
# conditions must be true. A) do_check() function has been declared, B) DO_CHECK
# environment variable exists and set to true, env DO_CHECK=true.
do_check() {
	make test
}

do_install() {
	make install
}
