pkg_name=mksh
pkg_origin=smacfarlane
pkg_version="R56c"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Apache-2.0")
pkg_source="https://www.mirbsd.org/MirOS/dist/mir/mksh/$pkg_name-$pkg_version.tgz"
# pkg_filename="${pkg_name}-${pkg_version}.tar.gz"
pkg_shasum="dd86ebc421215a7b44095dc13b056921ba81e61b9f6f4cdab08ca135d02afb77"
pkg_dirname="mksh"
pkg_deps=(core/glibc)
pkg_build_deps=(core/make core/gcc core/gawk core/wget)
# pkg_lib_dirs=(lib)
# pkg_include_dirs=(include)
pkg_bin_dirs=(bin)
# pkg_pconfig_dirs=(lib/pconfig)
# pkg_svc_run="haproxy -f $pkg_svc_config_path/haproxy.conf"
pkg_interpreters=(bin/ksh bin/mksh)
# pkg_svc_user="hab"
# pkg_svc_group="$pkg_svc_user"
# pkg_description="Some description."
# pkg_upstream_url="http://example.com/project-name"

do_build() {
  sh Build.sh -r
}

do_install() {
  install -D -m 755 mksh "${pkg_prefix}/bin/mksh"
  pushd ${pkg_prefix}/bin
  ln -s mksh ksh
  popd
  mkdir -p ${pkg_prefix}/share
  
  wget https://www.mirbsd.org/TaC-mksh.txt -O "${pkg_prefix}/share/TaC-mksh.txt"
}
