pkg_name="btrfs-progs"
pkg_origin="core"
pkg_version="5.6.1"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("GPLv2")
pkg_source="https://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git/snapshot/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="1b13aa66f7dbf409a61a2e18533e5455daa0116cbd78f4e9676ceb71cab9d002"
pkg_deps=(core/glibc
          core/util-linux
          core/lzo
          core/zlib
          core/zstd)
pkg_build_deps=(core/make
                core/gcc
                core/autoconf
                core/automake
                core/pkg-config
                core/python)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_bin_dirs=(bin)
pkg_description="Btrfs is a modern copy on write (CoW) filesystem for Linux aimed at implementing advanced features while also focusing on fault tolerance, repair and easy administration."
pkg_upstream_url="https://btrfs.wiki.kernel.org/index.php/Main_Page"

do_build() {
    AL_OPTS="-I $(pkg_path_for core/pkg-config)/share/aclocal -I$(pkg_path_for core/automake)/share/aclocal-1.16"
    export AL_OPTS
    ./autogen.sh
    ./configure --disable-documentation --prefix="${pkg_prefix}"
    make
}
