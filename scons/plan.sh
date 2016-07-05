pkg_name=scons
pkg_distname=$pkg_name
pkg_origin=core
pkg_version=2.5.0
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('MIT')
pkg_upstream_url=http://www.scons.org/
pkg_description="Substitute for classic 'make' tool with autoconf/automake functionality"
pkg_source=https://downloads.sourceforge.net/project/$pkg_distname/$pkg_distname/${pkg_version}/$pkg_distname-${pkg_version}.tar.gz
pkg_shasum=eb296b47f23c20aec7d87d35cfa386d3508e01d1caa3040ea6f5bbab2292ace9
pkg_deps=(core/coreutils core/python2)
pkg_bin_dirs=(bin)
pkg_lib_dirs=(lib)

do_build() {
  return 0
}

do_install() {
  python setup.py install --prefix="$pkg_prefix" --no-version-script --no-install-bat --no-install-man

  for binary in scons scons-time sconsign
  do
    fix_interpreter "$pkg_prefix/bin/$binary" core/coreutils bin/env
  done
}
