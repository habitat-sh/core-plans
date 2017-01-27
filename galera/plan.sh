# This file is the heart of your application's habitat.
# See full docs at https://www.habitat.sh/docs/reference/plan-syntax/

# Required.
# Sets the name of the package. This will be used in along with `pkg_origin`,
# and `pkg_version` to define the fully-qualified package name, which determines
# where the package is installed to on disk, how it is referred to in package
# metadata, and so on.
pkg_name=galera

# Required unless overridden by the `HAB_ORIGIN` environment variable.
# The origin is used to denote a particular upstream of a package.
pkg_origin=core

# Required.
# Sets the version of the package.
pkg_version=25.3.19

# Required.
# A URL that specifies where to download the source from. Any valid wget url
# will work. Typically, the relative path for the URL is partially constructed
# from the pkg_name and pkg_version values; however, this convention is not
# required.
pkg_source=http://github.com/codership/galera/archive/release_${pkg_version}.tar.gz

pkg_upstream_url=https://github.com/codership/galera

# Required if a valid URL is provided for pkg_source or unless do_verify() is overridden.
# The value for pkg_shasum is a sha-256 sum of the downloaded pkg_source. If you
# do not have the checksum, you can easily generate it by downloading the source
# and using the sha256sum or gsha256sum tools. Also, if you do not have
# do_verify() overridden, and you do not have the correct sha-256 sum, then the
# expected value will be shown in the build output of your package.
pkg_shasum=068b074ca5a5c2a5a3f799422650e7c5e5c9012ddfa1c18c30feab7f9aa9611d

# Optional.
# The name and email address of the package maintainer.
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"

# Required for core plans, optional otherwise.
# A short description of the package. It can be a simple string, or you can
# create a multi-line description using markdown to provide a rich description
# of your package.
pkg_description="Galera WSREP plugin"

# Optional.
# An array of valid software licenses that relate to this package.
# Please choose a license from http://spdx.org/licenses/
pkg_license=('GPL-2.0')

# Optional.
# An array of paths, relative to the final install of the software, where
# binaries can be found. Used to populate PATH for software that depends on
# your package.
# pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

# Optional.
# An array of the package dependencies needed only at build time.
pkg_build_deps=(core/scons core/python2 core/gcc core/boost core/check core/openssl)

pkg_dirname="galera-release_${pkg_version}"

do_build() {
    scons strict_build_flags=0 tests=0
}

do_install() {
    mkdir -p "${pkg_prefix}/lib"
    cp libgalera_smm.so "${pkg_prefix}/lib"
}
