pkg_name=apache-tomcat
pkg_description="An open source implementation of the Java Servlet, JavaServer Pages, Java Expression Language and Java WebSocket technologies."
pkg_origin=core
pkg_version=8.5.3
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_upstream_url="http://tomcat.apache.org/"
pkg_source=http://apache.mirrors.pair.com/tomcat/tomcat-8/v${pkg_version}/bin/${pkg_name}-${pkg_version}.tar.gz
pkg_shasum=d70eb2ef9d3c265cd6892bd21b7e56f36162e68fdf4323274cf24045f6d865fc
pkg_deps=(core/jdk8)
pkg_expose=(8080 8443)

pkg_svc_user="root"

# The default implementation extracts your tarball source file into HAB_CACHE_SRC_PATH. The
# supported archives are: .tar, .tar.bz2, .tar.gz, .tar.xz, .rar, .zip, .Z, .7z. If the file
# archive could not be found or was not supported, then a message will be printed to stderr
# with additional information.

do_unpack() {
  local source_dir=$HAB_CACHE_SRC_PATH/${pkg_name}-${pkg_version}
  local unpack_file="$HAB_CACHE_SRC_PATH/$pkg_filename"

  mkdir "$source_dir"
  pushd "$source_dir" >/dev/null
  tar xz --strip-components=1 -f "$unpack_file"

  popd > /dev/null
}

# The default implementation is to update the prefix path for the configure script to
# use $pkg_prefix and then run make to compile the downloaded source. This means the
# script in the default implementation does ./configure --prefix=$pkg_prefix && make. You
# should override this behavior if you have additional configuration changes to make or
# other software to build and install as part of building your package.
do_build() {
    return 0
}

# The default implementation is to run make install on the source files and place the compiled
# binaries or libraries in HAB_CACHE_SRC_PATH/$pkg_dirname, which resolves to a path like
# /hab/cache/src/packagename-version/. It uses this location because of do_build() using the
# --prefix option when calling the configure script. You should override this behavior if you
# need to perform custom installation steps, such as copying files from HAB_CACHE_SRC_PATH
# to specific directories in your package, or installing pre-built binaries into your package.
do_install() {
    build_line "Performing install"
    mkdir -p "${pkg_prefix}/tc"
    cp -vR ./* "${pkg_prefix}/tc"
}
