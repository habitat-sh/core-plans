# This file is the heart of your application's habitat.
# See full docs at https://www.habitat.sh/docs/reference/plan-syntax/

# Required.
# Sets the name of the package. This will be used in along with `pkg_origin`,
# and `pkg_version` to define the fully-qualified package name, which determines
# where the package is installed to on disk, how it is referred to in package
# metadata, and so on.
pkg_name=jetty

# Required unless overridden by the `HAB_ORIGIN` environment variable.
# The origin is used to denote a particular upstream of a package.
pkg_origin=core

# Required.
# Sets the version of the package.
pkg_version=9.1.5
jetty_release=v20140505

# Required.
# A URL that specifies where to download the source from. Any valid wget url
# will work. Typically, the relative path for the URL is partially constructed
# from the pkg_name and pkg_version values; however, this convention is not
# required.
pkg_source=http://repo1.maven.org/maven2/org/eclipse/jetty/jetty-distribution/${pkg_version}.${jetty_release}/jetty-distribution-${pkg_version}.${jetty_release}.tar.gz

pkg_upstream_url=https://eclipse.org/jetty

# Required if a valid URL is provided for pkg_source or unless do_verify() is overridden.
# The value for pkg_shasum is a sha-256 sum of the downloaded pkg_source. If you
# do not have the checksum, you can easily generate it by downloading the source
# and using the sha256sum or gsha256sum tools. Also, if you do not have
# do_verify() overridden, and you do not have the correct sha-256 sum, then the
# expected value will be shown in the build output of your package.
pkg_shasum=3fbce5530d8d9a66f43034782b0f249df3d98e3e97ef849e7f740eab612b963f

# Optional.
# The name and email address of the package maintainer.
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"

# Required for core plans, optional otherwise.
# A short description of the package. It can be a simple string, or you can
# create a multi-line description using markdown to provide a rich description
# of your package.
pkg_description="Jetty webserver and Java container"

# Optional.
# An array of valid software licenses that relate to this package.
# Please choose a license from http://spdx.org/licenses/
pkg_license=('Apache-2.0')

# Optional.
# An array of paths, relative to the final install of the software, where
# binaries can be found. Used to populate PATH for software that depends on
# your package.
# pkg_bin_dirs=(bin)

# Optional.
# An array of the package dependencies needed only at build time.
# pkg_build_deps=(core/make core/gcc)

# Optional.
# An array of package dependencies needed at runtime. You can refer to packages
# at three levels of specificity: `origin/package`, `origin/package/version`, or
# `origin/package/version/release`.
pkg_deps=(core/which core/coreutils core/bash core/jdk7)

do_unpack() {
    local source_dir=$HAB_CACHE_SRC_PATH/${pkg_name}-${pkg_version}
    local unpack_file="$HAB_CACHE_SRC_PATH/$pkg_filename"

    mkdir "$source_dir"
    pushd "$source_dir" >/dev/null
    tar xz --strip-components=1 -f "$unpack_file"

    popd > /dev/null
}

do_build() {
    return 0
}

do_install() {
    mkdir -p "${pkg_prefix}/jetty"
    cp -vR ./* "${pkg_prefix}/jetty"

    # default permissions included in the tarball don't give any world access
    find "${pkg_prefix}/jetty" -type d -exec chmod -v 755 {} +
    find "${pkg_prefix}/jetty" -type f -exec chmod -v 644 {} +
    find "${pkg_prefix}/jetty" -type f -name '*.sh' -exec chmod -v 755 {} +

    # fix interpreter for jetty startup script
    fix_interpreter "${pkg_prefix}/jetty/bin/jetty.sh" core/coreutils bin/env
}
