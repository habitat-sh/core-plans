# This file is the heart of your application's habitat.
# See full docs at https://www.habitat.sh/docs/reference/plan-syntax/

# Required.
# Sets the name of the package. This will be used in along with `pkg_origin`,
# and `pkg_version` to define the fully-qualified package name, which determines
# where the package is installed to on disk, how it is referred to in package
# metadata, and so on.
pkg_name=percona-xtrabackup

# Required unless overridden by the `HAB_ORIGIN` environment variable.
# The origin is used to denote a particular upstream of a package.
pkg_origin=core

# Required.
# Sets the version of the package.
pkg_version=2.3.5

# Required.
# A URL that specifies where to download the source from. Any valid wget url
# will work. Typically, the relative path for the URL is partially constructed
# from the pkg_name and pkg_version values; however, this convention is not
# required.
pkg_source=http://github.com/percona/percona-xtrabackup/archive/${pkg_name}-${pkg_version}.tar.gz

pkg_upstream_url=https://www.percona.com/software/mysql-database/percona-xtrabackup

# Required if a valid URL is provided for pkg_source or unless do_verify() is overridden.
# The value for pkg_shasum is a sha-256 sum of the downloaded pkg_source. If you
# do not have the checksum, you can easily generate it by downloading the source
# and using the sha256sum or gsha256sum tools. Also, if you do not have
# do_verify() overridden, and you do not have the correct sha-256 sum, then the
# expected value will be shown in the build output of your package.
pkg_shasum=5a68dfa4a4010f73cfe0887f2218a09e329be8fb4cb0f65f08f6b88125adcea7

# Optional.
# The name and email address of the package maintainer.
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"

# Required for core plans, optional otherwise.
# A short description of the package. It can be a simple string, or you can
# create a multi-line description using markdown to provide a rich description
# of your package.
pkg_description="Percona xtrabackup utilities"

# Optional.
# An array of valid software licenses that relate to this package.
# Please choose a license from http://spdx.org/licenses/
pkg_license=('GPL-2.0')

# Optional.
# An array of paths, relative to the final install of the software, where
# binaries can be found. Used to populate PATH for software that depends on
# your package.
pkg_bin_dirs=(bin)

# Optional.
# An array of the package dependencies needed only at build time.
pkg_build_deps=(core/m4 core/make core/gcc core/bison core/cmake core/mysql core/libaio core/boost159)

# Optional.
# An array of package dependencies needed at runtime. You can refer to packages
# at three levels of specificity: `origin/package`, `origin/package/version`, or
# `origin/package/version/release`.
pkg_deps=(core/bash core/iproute2 core/gnupg core/pkg-config core/glibc core/gcc-libs core/ncurses core/vim core/curl core/libev core/openssl core/zlib core/libgcrypt core/libgpg-error core/libtool)
pkg_dirname=percona-xtrabackup-percona-xtrabackup-${pkg_version}

do_prepare() {
    if [ -f CMakeCache.txt ]; then
        rm CMakeCache.txt
    fi
    sed -i 's/^.*abi_check.*$/#/' CMakeLists.txt
    export CXXFLAGS="$CFLAGS"
}

do_build() {
    export LD_LIBRARY_PATH GCRYPT_INCLUDE_DIR GCRYPT_LIB
    LD_LIBRARY_PATH="$(pkg_path_for core/libgcrypt)/lib"
    GCRYPT_INCLUDE_DIR=$(pkg_path_for core/libgcrypt)/lib
    GCRYPT_LIB=$(pkg_path_for core/libgcrypt)
    cmake . -DCMAKE_PREFIX_PATH="$(pkg_path_for core/ncurses)" -DCMAKE_INSTALL_PREFIX="$pkg_prefix" \
	    -DBUILD_CONFIG=xtrabackup_release -DWITH_MAN_PAGES=OFF -DWITH_BOOST="$(pkg_path_for core/boost159)/include" \
	    -DCURL_LIBRARY="$(pkg_path_for core/curl)/lib/libcurl.so" -DCURL_INCLUDE_DIR="$(pkg_path_for core/curl)/include" \
	    -DLIBEV_INCLUDE_DIRS="$(pkg_path_for core/libev)/include"	-DGCRYPT_LIB="$(pkg_path_for core/libgcrypt)/lib/libgcrypt.so" \
	    -DGCRYPT_INCLUDE_DIR="$(pkg_path_for core/libgcrypt)/include" -DGPG_ERROR_LIB="$(pkg_path_for core/libgpg-error)/lib/libgpg-error.so" \
	    -DLIBEV_LIB="$(pkg_path_for core/libev)/lib/libev.so"
    make
}

do_install() {
    make install
}
