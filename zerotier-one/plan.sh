pkg_name=zerotier-one
pkg_origin=core
pkg_version="1.2.12"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("GPL-3.0")
pkg_description="A Smart Ethernet Switch for Earth"
pkg_upstream_url="https://github.com/zerotier/ZeroTierOne"
pkg_source="https://github.com/zerotier/ZeroTierOne/archive/${pkg_version}.tar.gz"
pkg_shasum="212799bfaeb5e7dff20f2cd83f15742c8e13b8e9535606cfb85abcfb5fb6fed4"
pkg_dirname="ZeroTierOne-${pkg_version}"

pkg_build_deps=(
  core/gcc
  core/make
  core/patch
)


pkg_deps=(
  core/glibc
  core/gcc-libs
)

pkg_bin_dirs=(bin)
pkg_svc_user="root"
pkg_svc_run="zerotier-one"


do_build() {
  build_line "Patching default home directory"
  patch -p0 -i "${PLAN_CONTEXT}/default-home-path.patch"

  export CFLAGS+=" -fPIC"
  export CXXFLAGS+=" -fPIC"
  build_line "Running make"
  make
}

do_install() {
  cp -v ./zerotier-one "${pkg_prefix}/bin/"
  ln -s "${pkg_prefix}/bin/zerotier-one" "${pkg_prefix}/bin/zerotier-cli"
  ln -s "${pkg_prefix}/bin/zerotier-one" "${pkg_prefix}/bin/zerotier-idtool"
}
