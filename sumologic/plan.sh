pkg_name=sumologic
pkg_origin=core
pkg_version="19.209-5"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_source="https://collectors.sumologic.com/rest/download/tar"
pkg_dirname="sumocollector"
pkg_filename="SumoCollector_unix_19_209-5.tar.gz"
pkg_shasum="da0a6a63984ced68f3feaaed50aa01e87110d394b51ff8a6096ac720586c3d2f"
pkg_deps=(core/jre8 core/glibc core/gcc-libs)
pkg_build_deps=(core/patchelf)
pkg_lib_dirs=("${pkg_name}/${pkg_version}/lib" "${pkg_name}/${pkg_version}/bin/native/lib")
pkg_bin_dirs=("${pkg_name}/${pkg_version}/bin")
pkg_description="Sumo Logic’s powerful, scalable SaaS platform analyzes log data and metrics together in real time."
pkg_upstream_url="https://www.sumologic.com"
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
  mv tanuki/linux64/wrapper ./
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
