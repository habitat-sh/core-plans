pkg_name="powershell"
pkg_origin="core"
pkg_version="6.2.1"
pkg_license=("MIT")
pkg_upstream_url="https://msdn.microsoft.com/powershell"
pkg_description="PowerShell is a cross-platform (Windows, Linux, and macOS) automation and configuration tool/framework that works well with your existing tools and is optimized for dealing with structured data (e.g. JSON, CSV, XML, etc.), REST APIs, and object models. It includes a command-line shell, an associated scripting language and a framework for processing cmdlets."
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_source="https://github.com/PowerShell/PowerShell/releases/download/v$pkg_version/PowerShell-$pkg_version-linux-x64.tar.gz"
pkg_shasum="e8287687c99162bf70fefcc2e492f3b54f80be880d86b9a0ec92c71b05c40013"
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
