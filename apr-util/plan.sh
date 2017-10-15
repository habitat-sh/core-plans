pkg_name=apr-util
pkg_origin=core
pkg_version=1.6.0
pkg_license=('Apache2')
pkg_source=http://www.us.apache.org/dist/apr/${pkg_name}-${pkg_version}.tar.bz2
pkg_shasum=8474c93fa74b56ac6ca87449abe3e155723d5f534727f3f33283f6631a48ca4c
pkg_deps=(core/glibc core/apr core/expat)
pkg_build_deps=(core/gcc core/make)
pkg_bin_dirs=(bin)

do_build() {
  ./configure --prefix="${pkg_prefix}" \
              --with-apr="$(pkg_path_for core/apr)" \
              --with-expat="$(pkg_path_for core/expat)"
  make
}
