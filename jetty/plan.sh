pkg_name=jetty
pkg_origin=core
pkg_version=9.4.38
jetty_release=v20210224
pkg_source=https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-distribution/${pkg_version}.${jetty_release}/jetty-distribution-${pkg_version}.${jetty_release}.tar.gz
pkg_upstream_url=https://eclipse.org/jetty
pkg_shasum=579f6496ecf1d2a77cac8a12a0606b37e5098eca95f0c4de74235ddb898eff09
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Jetty webserver and Java container"
pkg_license=('Apache-2.0')
pkg_deps=(core/which core/coreutils core/bash core/openjdk11)

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
