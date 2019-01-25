pkg_name=google-cloud-sdk
pkg_description="Google Cloud SDK is a set of tools that you can use to manage resources and applications hosted on Google Cloud Platform."
pkg_upstream="https://cloud.google.com/sdk/"
pkg_origin=core
pkg_version="231.0.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Apache-2.0")
pkg_source="https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/${pkg_name}-${pkg_version}-linux-x86_64.tar.gz"
pkg_shasum="7f1a5ca6e521fb3b4a17c557d0107a032f3f486b7071ee4895ded1077ffda49e"
pkg_deps=(core/python2)
pkg_bin_dirs=(bin)

do_build() {
  return 0
}

do_install() {
  bash $HAB_CACHE_SRC_PATH/$pkg_name/install.sh --quiet
  mkdir -p $pkg_prefix/lib
  cp -r $HAB_CACHE_SRC_PATH/$pkg_name/lib $pkg_prefix/
  mkdir -p $pkg_prefix/bin
  cp -r $HAB_CACHE_SRC_PATH/$pkg_name/bin/* $pkg_prefix/bin/
  hab pkg binlink core/python2
}

