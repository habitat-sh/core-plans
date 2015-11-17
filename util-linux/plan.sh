pkg_derivation=chef
pkg_name=util-linux
pkg_version=2.27
pkg_license=('GPLv2')
pkg_maintainer="Adam Jacob <adam@chef.io>"
pkg_source=https://www.kernel.org/pub/linux/utils/util-linux/v2.27/util-linux-2.27.tar.gz
pkg_filename=${pkg_name}-${pkg_version}.tar.gz
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_binary_path=(sbin)
pkg_shasum=21ede7eb6c3a2a9c7b13eeee241e82428be4f6d5030ff488f638817f419af093
pkg_gpg_key=3853DA6B
pkg_deps=(chef/glibc)

build() {
  ./configure --without-systemd --without-python --without-slang --prefix=$pkg_prefix
  make
}
