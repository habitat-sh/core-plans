pkg_name="7zip"
pkg_origin="core"
pkg_version="16.02"
pkg_license=("LGPL-2.1" "unRAR restriction")
pkg_upstream_url="https://sourceforge.net/projects/p7zip/"
pkg_description="7-Zip is a file archiver with a high compression ratio"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_filename="p7zip_${pkg_version}_src_all.tar.bz2"
pkg_source="https://downloads.sourceforge.net/project/p7zip/p7zip/${pkg_version}/${pkg_filename}"
pkg_shasum="5eb20ac0e2944f6cb9c2d51dd6c4518941c185347d4089ea89087ffdd6e2341f"
pkg_bin_dirs=("bin")
pkg_lib_dirs=("lib" "lib/Codecs")
pkg_build_deps=("core/coreutils" "core/make" "core/gcc")
pkg_deps=("core/glibc" "core/gcc-libs")
pkg_dirname="p7zip_${pkg_version}"

do_build() {
  JOBS=$(getconf _NPROCESSORS_ONLN)

  # Build for AMD64 without native yasm.
  cp "${HAB_CACHE_SRC_PATH}/${pkg_dirname}/makefile.linux_amd64" "${HAB_CACHE_SRC_PATH}/${pkg_dirname}/makefile.machine"
  # Set correct install path per docs.
  make clean && make OPTFLAGS="-O3 -mtune=nocona" -j "${JOBS}" all4
}

do_install() {
  mv "${HAB_CACHE_SRC_PATH}/${pkg_dirname}/bin/7z.so" "${HAB_CACHE_SRC_PATH}/${pkg_dirname}/bin/Codecs" "$pkg_prefix/lib/"
  cp -r "${HAB_CACHE_SRC_PATH}/${pkg_dirname}/bin" "$pkg_prefix/"
}
