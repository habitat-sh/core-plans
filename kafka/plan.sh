pkg_name=kafka
pkg_origin=core
pkg_version=0.10.1.0
pkg_source=http://mirrors.gigenet.com/apache/${pkg_name}/${pkg_version}/${pkg_name}_2.11-${pkg_version}.tgz
pkg_shasum=6d9532ae65c9c8126241e7b928b118aaa3a694dab08069471f0e61f4f0329390
pkg_dirname=${pkg_name}_2.11-${pkg_version}
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="A distributed streaming platform"
pkg_license=('Apache-2.0')
pkg_bin_dirs=(bin)
pkg_deps=(core/jre8 core/coreutils core/bash-static)

do_build() {
  fix_interpreter "./bin/*" core/bash-static bin/bash
}

do_install() {
  cp -R libs bin "$pkg_prefix"
}
