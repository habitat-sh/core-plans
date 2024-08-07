pkg_name=linux
pkg_origin=core
pkg_version="4.20.17"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_description="The Linux kernel"
pkg_upstream_url="https://www.kernel.org/"
pkg_license=('gplv2')
pkg_source="https://cdn.kernel.org/pub/linux/kernel/v4.x/${pkg_name}-${pkg_version}.tar.xz"
pkg_shasum="d011245629b980d4c15febf080b54804aaf215167b514a3577feddb2495f8a3e"
pkg_deps=(
  core/glibc
)
pkg_build_deps=(
  core/bc
  core/bison
  core/diffutils
  core/elfutils
  core/findutils
  core/gcc
  core/inetutils
  core/make
  core/perl
  core/openssl
  core/patch
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

  HOSTLDFLAGS="${LD_FLAGS}"
  export HOSTLDFLAGS

  HOST_EXTRACFLAGS="-w ${CFLAGS}"
  export HOST_EXTRACFLAGS

  # Some software in tools/scripts requires external libraries to compile.
  #  The resulting binaries are not packaged so their dependencies are listed
  #  as build dependencies. To allow them to build successfully and run
  #  temporarily set LD_LIBRARY_PATH to all of the pkg_build_deps lib directories.
  set_ld_library_path

  # http://lkml.iu.edu/hypermail/linux/kernel/2011.0/03431.html
  patch -p1 < "${PLAN_CONTEXT}"/patches/000-generate-clang-non-section-symbols-in-orc-generation.patch
  # https://lore.kernel.org/patchwork/patch/1369985/
  patch -p1 < "${PLAN_CONTEXT}"/patches/001-build-thunk-only-if-config-preemption.patch

  # These line numbers can change between kernel versions, but changes will only break
  #  builds that have CONFIG_ options set that require building scripts/ or tools/

  # Let the inline test build (CONFIG_STACK_VALIDATION) know where libelf lives
  sed -i "961s|-xc|$LDFLAGS -xc|" Makefile

  # Override the defaults for building scripts and tools.
  #  scripts/sign-file and tools/objtool need openssl and elfutils.
  sed -i "373s|$| $LDFLAGS|" Makefile
}

do_build() {
  make -w -j "$(nproc)" bzImage modules
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
