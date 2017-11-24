pkg_name=linux
pkg_origin=core
pkg_version="4.14.2"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('gplv2')
pkg_source="https://cdn.kernel.org/pub/linux/kernel/v4.x/${pkg_name}-${pkg_version}.tar.xz"
pkg_description="The Linux kernel"
pkg_upstream_url="https://www.kernel.org/"
pkg_shasum="e92690620a4e4811c6b37b2f1b6c9b32a1dde40aa12be6527c8dc215fb27464c"
pkg_deps=(core/glibc)
pkg_build_deps=(
  core/bc
  core/diffutils
  core/elfutils
  core/findutils
  core/gcc
  core/inetutils
  core/make
  core/perl
  core/openssl
)

do_begin() {
  if [[ ! -e /bin/pwd ]]; then
    hab pkg binlink core/coreutils pwd -d /bin
    _pwd_binlink=true
  fi
}

do_prepare() {
  make mrproper
  cp "${PLAN_CONTEXT}/config/config.x86_64" "${HAB_CACHE_SRC_PATH}/${pkg_dirname}/.config"
}

do_build() {
  # Some software in tools/scripts requires external libraries to compile.
  #  The resulting binaries are not packaged so their dependencies are listed
  #  as build dependencies. To allow them to build successfully and run
  #  temporarily set LD_LIBRARY_PATH to all of the pkg_build_deps lib directories.

  set_ld_library_path

  # These line numbers can change between kernel versions, but changes will only break
  #  builds that have CONFIG_ options set that require building scripts/ or tools/

  # Let the inline test build (CONFIG_STACK_VALIDATION) know where libelf lives
  sed -i "932s|-xc|$LDFLAGS -xc|" Makefile

  # Override the defaults for building scripts and tools.
  #  scripts/sign-file and tools/objtool need openssl and elfutils.
  sed -i "306s|$| $LDFLAGS|" Makefile
  sed -i "98s|\$(hostc_flags)|\$(hostc_flags) \$(HOSTLDFLAGS)|" scripts/Makefile.host
  sed -i "55s|\$(LDFLAGS)|\$(LDFLAGS) \$(HOSTLDFLAGS)|" tools/objtool/Makefile

  HOST_EXTRACFLAGS="${CFLAGS}" make -j "$(nproc)" bzImage modules

  unset LD_LIBRARY_PATH
}

do_install() {
  make INSTALL_MOD_PATH="${pkg_prefix}" modules_install
  mkdir -p "${pkg_prefix}/boot"
  cp -a arch/x86/boot/bzImage "${pkg_prefix}/boot/"

  # make modules_install symlinks lib/modules/$pkg_version/{build,source} to the cache directory
  find "${pkg_prefix}" -type l -delete
}

do_end() {
  if [[ -v $_pwd_binlink ]]; then
    rm -f /bin/pwd
  fi
}

set_ld_library_path() {
  local ld_library_path_part=()

  for dep in "${pkg_build_deps[@]}"; do
    local dep_path
    dep_path=$(pkg_path_for "$dep");

    if [[ -f "$dep_path/LD_RUN_PATH" ]]; then
      local data
      local trimmed
      data=$(cat "$dep_path/LD_RUN_PATH")
      trimmed=$(trim "$data")
      ld_library_path_part+=("$trimmed")
    fi
  done

  LD_LIBRARY_PATH=$(join_by ':' "${ld_library_path_part[@]}")
  export LD_LIBRARY_PATH
}
