pkg_name="btrfs-progs"
pkg_origin="core"
pkg_version="5.15.1"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("GPLv2")
pkg_source="https://git.kernel.org/pub/scm/linux/kernel/git/kdave/btrfs-progs.git/snapshot/${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="6e7f1155ba8b06ee144bf16e07a22bc1b9ea4f70503e7abc6ee174972cae28c4"
pkg_deps=(core/glibc
          core/util-linux
          # NOTE(ssd) 2020-05-11: This dependency must be listed
          # _after_ core/util-linux in the runtime deps even though it
          # only ships static libraries.
          #
          # Both core/util-linux and core/e2fsprogs ship the blkid.h
          # header file, but with incompatible
          # definitions. btrfs-progs requires the one in
          # core/util-linux.
          #
          # When generating CFLAGS hab-plan-build puts all build-time
          # dependencies before any runtime dependencies.
          core/e2fsprogs
          core/lzo
          core/zlib
          core/zstd
          core/systemd)
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
    ./configure --disable-documentation --disable-zoned --prefix="${pkg_prefix}"
    make
}
