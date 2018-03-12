pkg_name=tomcat7
pkg_description="An open source implementation of the Java Servlet, JavaServer Pages, Java Expression Language and Java WebSocket technologies."
pkg_origin=core
pkg_version=7.0.73
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_description="The Apache Tomcat software is an open source implementation of the Java Servlet, JavaServer Pages, Java Expression Language and Java WebSocket technologies."
pkg_upstream_url="http://tomcat.apache.org/"
pkg_filename=apache-tomcat-${pkg_version}.tar.gz
pkg_source=http://archive.apache.org/dist/tomcat/tomcat-7/v${pkg_version}/bin/${pkg_filename}
pkg_dirname=apache-tomcat-${pkg_version}
pkg_shasum=0e814d6ad7d5b90e29c79887137420d3bc413540f9faa60d98f11e6c8a8fea85
pkg_deps=(core/bash core/coreutils core/jdk7)
pkg_exports=(
  [port]=server.port
)
pkg_exposes=(port)


do_build() {
  for file in $(cd $CACHE_PATH/bin; ls *.sh -1)
  do
    build_line "Fixing bash interpreter on $file"
    fix_interpreter "$CACHE_PATH/bin/$file" core/bash bin/bash
  done
  return 0
}

do_install() {
    build_line "Performing install from $CACHE_PATH to ${pkg_prefix}"
    cp -R "$CACHE_PATH" "${pkg_prefix}/tc/"
    # tomcat has a small issue where it uncompresses all the files with 0600 permissions
    chmod -R a+r "${pkg_prefix}/tc/"
    return 0
}
