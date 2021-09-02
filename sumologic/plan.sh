pkg_name=sumologic
pkg_origin=core
pkg_version="19.319-4"
pkg_license=('Apache-2.0')
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="Sumo Logic’s powerful, scalable SaaS platform analyzes log data and metrics together in real time."
pkg_upstream_url="https://www.sumologic.com"
pkg_source="https://collectors.sumologic.com/rest/download/tar?version=${pkg_version}"
pkg_shasum="21a1cc412cbf31939fa4d7de16a8c36fcfd25df025e8549418d89d561a3af0a0"
pkg_dirname="sumocollector"
pkg_filename="SumoCollector_unix_${pkg_version/./_}.tar.gz"
pkg_deps=(
  core/gcc-libs
  core/glibc
  core/openjdk11
)
pkg_build_deps=(
  core/patchelf
)
pkg_lib_dirs=("${pkg_name}/${pkg_version}/lib" "${pkg_name}/${pkg_version}/bin/native/lib")
pkg_bin_dirs=("${pkg_name}/${pkg_version}/bin" "${pkg_name}")
pkg_svc_user="root"
pkg_svc_group="root"

do_build() {
  return 0
}

do_install() {
  # Remove unnecessary OS support
  find . -name "*.bat" -type f -delete
  find . -name "*.dll" -type f -delete
  find . -name "*.cmd" -type f -delete

  # Move the linux wrapper into place
  # https://help.sumologic.com/Send-Data/Collector-FAQs/How-do-I-use-the-binary-package-to-install-a-Collector-on-Windows-or-MacOS
  mv tanuki/linux64/wrapper ./wrapper
  #chmod: cannot access 'VERSION/bin/collector': No such file or directory caused by not latest version
  chmod +x wrapper "${pkg_version}/bin/collector"
  mv "tanuki/linux64/libwrapper.so" "${pkg_version}/bin/native/lib/"

  rm -r powershell tanuki SumoEtw.man collector config \
    "${pkg_version}/bin/native/lib/libsigar-universal64-macosx.dylib" \
    "${pkg_version}/bin/native/lib/libsigar-x86-linux.so"

  patchelf --interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" --set-rpath "$LD_RUN_PATH" wrapper

  cp -a . "${pkg_prefix}/${pkg_name}"
}

do_strip() {
  return 0
}
