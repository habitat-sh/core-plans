pkg_name="powershell"
pkg_origin="core"
pkg_version="7.1.3"
pkg_license=("MIT")
pkg_upstream_url="https://msdn.microsoft.com/powershell"
pkg_description="PowerShell is a cross-platform (Windows, Linux, and macOS) automation and configuration tool/framework that works well with your existing tools and is optimized for dealing with structured data (e.g. JSON, CSV, XML, etc.), REST APIs, and object models. It includes a command-line shell, an associated scripting language and a framework for processing cmdlets."
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/PowerShell/PowerShell/releases/download/v$pkg_version/PowerShell-$pkg_version-linux-x64.tar.gz"
pkg_shasum="9f853fb8f7c7719005bd1054fa13ca4d925c519b893f439dd2574e84503e6a85"
pkg_filename="powershell-$pkg_version-linux-x64.tar.gz"
pkg_bin_dirs=("bin")
pkg_deps=("core/icu" "core/openssl" "core/glibc" "core/gcc-libs")
pkg_build_deps=("core/patchelf")

do_unpack() {
  mkdir -p "${HAB_CACHE_SRC_PATH}/${pkg_dirname}"
  tar xf "${HAB_CACHE_SRC_PATH}/${pkg_filename}" \
    -C "${HAB_CACHE_SRC_PATH}/${pkg_dirname}" \
    --no-same-owner
}

do_prepare() {
  find . -type f -name '*.so*' \
    -exec patchelf --set-rpath "${LD_RUN_PATH}" {} \;
  patchelf --set-rpath "${LD_RUN_PATH}" pwsh
  patchelf --interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" pwsh
  chmod +x pwsh
}

do_build() {
  return 0
}

do_install() {
  cp -rf ./* "$pkg_prefix"/bin

  # The linux powersheel distribution symlinks libssl and libcrypto to /lib64
  # We will replace those with symlinks to the openssl hab package
  rm "$pkg_prefix"/bin/libssl.so.1.0.0
  rm "$pkg_prefix"/bin/libcrypto.so.1.0.0
  ln -s "$(pkg_path_for openssl)/lib/libssl.so.1.0.0" "$pkg_prefix"/bin/libssl.so.1.0.0
  ln -s "$(pkg_path_for openssl)/lib/libcrypto.so.1.0.0" "$pkg_prefix"/bin/libcrypto.so.1.0.0
}

do_check() {
  version=$(./pwsh -Command "\$PSVersionTable.GitCommitId")
  if [ "$version" != "$pkg_version" ]; then
    build_line "Check failed to confirm powershell version as $pkg_version got $version"
    return 1
  fi
}

do_strip() {
  return 0
}
