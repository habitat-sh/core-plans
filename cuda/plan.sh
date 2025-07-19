pkg_name=cuda
pkg_origin=core
pkg_description="GPU-accelerated Libraries for Computing on NVIDIA devices"
pkg_version=9.2.148
_driverver=396.37
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('custom')
pkg_source="https://developer.nvidia.com/compute/${pkg_name}/9.2/Prod2/local_installers/${pkg_name}_${pkg_version}_${_driverver}_linux"
pkg_filename="${pkg_name}_${pkg_version}_${_driverver}_linux.run"
pkg_shasum="8daa1733f6948a15fab7da43cc47b7099e25f78644133bb33e8405ab92d6e72b"
pkg_upstream_url="https://developer.nvidia.com/cuda-zone"

## NOTE: Much of this plan copies what Archlinux did to repackage cuda.
##       ref: https://git.archlinux.org/svntogit/community.git/tree/trunk/PKGBUILD?h=packages/cuda

pkg_deps=(
  core/gcc-libs
  core/glibc
  core/ncurses
  core/gcc
  core/python2
  core/corretto8
  core/coreutils
  core/busybox-static
)
pkg_build_deps=(
  core/make
  core/patchelf
  core/perl
)

pkg_bin_dirs=(bin)
pkg_lib_dirs=(
  lib64
  lib64/stubs
  nvvm/lib64
)
pkg_include_dirs=(include)

do_before() {
  mkdir -p /usr/bin

  if [[ ! -r /usr/bin/perl ]]; then
    ln -sv "$(pkg_path_for perl)/bin/perl" /usr/bin/perl
    _clean_perl=true
  fi

  mkdir -p /bin
  if [[ ! -r /bin/rm ]]; then
  ln -sv "$(pkg_path_for coreutils)/bin/rm" /bin/rm
  _clean_rm=true
  fi
}

do_unpack() {
  pushd "${HAB_CACHE_SRC_PATH}" > /dev/null || return 1
  sh "${pkg_filename}" --extract="${HAB_CACHE_SRC_PATH}/${pkg_dirname}"

  pushd "${pkg_dirname}" > /dev/null || return 1

  # shellcheck disable=SC2211
  ./cuda-*.run --noexec --keep

  # shellcheck disable=SC2211
  ./cuda-samples*.run --noexec --keep

  popd > /dev/null || return 1

  popd > /dev/null || return 1
}

do_prepare() {
  # path hacks
  # 1rd sed line: sets right path to install man files
  # 2rd sed line: hack to lie installer, now detect launch script by root
  # 3rd sed line: sets right path in .desktop files and other .desktop stuff (warnings by desktop-file-validate)
  sed -e "s|/usr/share|${pkg_prefix}/share|g" \
      -e 's|can_add_for_all_users;|1;|g' \
      -e 's|Terminal=No|Terminal=false|g' -e 's|ParallelComputing|ParallelComputing;|g' \
      -i pkg/install-linux.pl

  # use python2
  _fix_interpreter_in_path "pkg" '*.py' core/python2 bin/python
  _fix_interpreter_in_path "pkg" '*.py' core/coreutils bin/env
}

do_build() {
  return 0
}

do_install() {
  pushd pkg > /dev/null || return 1

  export PERL5LIB=.
  perl install-linux.pl -prefix="${pkg_prefix}" -noprompt -nosymlink
  perl install-sdk-linux.pl -cudaprefix="${pkg_prefix}" -prefix="${pkg_prefix}/samples" -noprompt

  # Hack we need because of glibc 2.26 (https://bugs.archlinux.org/task/55580)
  # without which we couldn't compile anything at all.
  # Super dirty hack. I really hope it doesn't break other stuff!
  # Hopefully we can remove this for later version of cuda.
  sed -i "1 i#define _BITS_FLOATN_H" "${pkg_prefix}/include/host_defines.h"

  # Needs gcc7
  ln -s "$(pkg_path_for core/gcc)/bin/gcc" "${pkg_prefix}/bin/gcc"
  ln -s "$(pkg_path_for core/gcc)/bin/g++" "${pkg_prefix}/bin/g++"

  # Install profile and ld.so.config files
  mkdir -p "${pkg_prefix}/etc/profile.d"
  cat <<EOF > "${pkg_prefix}/etc/profile.d/cuda.sh"
export PATH=\$PATH:${pkg_prefix}/bin
EOF
  chmod 0755 "${pkg_prefix}/etc/profile.d/cuda.sh"

  mkdir -p "${pkg_prefix}/etc/ld.so.conf.d"
  cat <<EOF > "${pkg_prefix}/etc/ld.so.conf.d/cuda.conf"
${pkg_prefix}/lib64
${pkg_prefix}/nvvm/lib64
EOF
  chmod 0644 "${pkg_prefix}/etc/ld.so.conf.d/cuda.conf"

  # Install EULA
  mkdir -p "${pkg_prefix}/share/licenses"
  cp -av "${pkg_prefix}/doc/pdf/EULA.pdf" "${pkg_prefix}/share/licenses/EULA.pdf"

  # Remove docs, man and samples
  rm -fr "${pkg_prefix}/cuda-samples"
  rm -fr "${pkg_prefix}/samples"
  rm -fr "${pkg_prefix}/doc"
  rm -fr "${pkg_prefix}/usr/share/man"

  # Remove included copy of java and link to system java
  rm -fr "${pkg_prefix}/jre"
  sed "s|../jre/bin/java|$(pkg_path_for core/corretto8)/bin/java|g" \
    -i "${pkg_prefix}/libnsight/nsight.ini" \
    -i "${pkg_prefix}/libnvvp/nvvp.ini"

  # Remove unused files
  rm -fr "${pkg_prefix}/bin/.uninstall_manifest_do_not_delete.txt"
  rm -fr "${pkg_prefix}/bin/cuda-install-samples"*.sh
  rm -fr "${pkg_prefix}/bin/uninstall_cuda_toolkit"*.pl

  # Fix interpreters
  fix_interpreter "${pkg_prefix}/bin/computeprof" core/busybox-static bin/sh
  fix_interpreter "${pkg_prefix}/bin/nvvp" core/busybox-static bin/sh
  fix_interpreter "${pkg_prefix}/bin/nsight" core/busybox-static bin/sh
  fix_interpreter "${pkg_prefix}/bin/nsight_ee_plugins_manage.sh" core/busybox-static bin/sh

  # Let the patching begin
  # We create a RUN_PATH that does not include all the runtime deps.
  CUDA_RUN_PATH="${pkg_prefix}/lib64:${pkg_prefix}/nvvm/lib64:$(pkg_path_for gcc-libs)/lib:$(pkg_path_for glibc)/lib"

  # Patch Bins
  _cuda_bins=(
    nvvm/bin/cicc
    libnvvp/nvvp
    libnsight/nsight
    extras/demo_suite/bandwidthTest
    extras/demo_suite/busGrind
    extras/demo_suite/deviceQuery
    extras/demo_suite/nbody
    extras/demo_suite/oceanFFT
    extras/demo_suite/randomFog
    extras/demo_suite/vectorAdd
    bin/bin2c
    bin/cudafe++
    bin/cuobjdump
    bin/fatbinary
    bin/nvcc
    bin/nvdisasm
    bin/nvlink
    bin/nvprof
    bin/nvprune
    bin/ptxas
    bin/cuda-gdbserver
    bin/cuda-memcheck
    bin/gpu-library-advisor
  )
  for bin in "${_cuda_bins[@]}"; do
    build_line "patch ${pkg_prefix}/${bin}"
    patchelf --interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" \
      --set-rpath "${CUDA_RUN_PATH}" "${pkg_prefix}/${bin}"
  done

  # Patch Cuda-gdb
  # note: libncurses 6.1 is "designed to be source-compatible with 5.0 through 6.0"
  build_line "patch ${pkg_prefix}/bin/cuda-gdb"
  patchelf --interpreter "$(pkg_path_for glibc)/lib/ld-linux-x86-64.so.2" "${pkg_prefix}/bin/cuda-gdb"
  patchelf --replace-needed libncurses.so.5 libncurses.so.6 "${pkg_prefix}/bin/cuda-gdb"
  patchelf --set-rpath "${CUDA_RUN_PATH}:$(pkg_path_for ncurses)/lib" "${pkg_prefix}/bin/cuda-gdb"

  # Patch libraries
  _cuda_libs=(
    libOpenCL
    libcufftw
    libnppc
    libnppif
    libnppitc
    libnvrtc-builtins
    libaccinj64
    libcuinj64
    libnppial
    libnppig
    libnpps
    libnvrtc
    libcublas
    libcurand
    libnppicc
    libnppim
    libnvToolsExt
    libcudart
    libcusolver
    libnppicom
    libnppist
    libnvblas
    libcufft
    libcusparse
    libnppidei
    libnppisu
    libnvgraph
  )
  for lib in "${_cuda_libs[@]}"; do
    build_line "patch ${pkg_prefix}/lib64/${lib}.so"
    patchelf --set-rpath "${CUDA_RUN_PATH}" "${pkg_prefix}/lib64/${lib}.so"
  done

  _cuda_stubs_libs=(
    libcublas
    libcurand
    libnppial
    libnppif
    libnppisu
    libnvidia-ml
    libcuda
    libcusolver
    libnppicc
    libnppig
    libnppitc
    libnvrtc
    libcufft
    libcusparse
    libnppicom
    libnppim
    libnpps
    libcufftw
    libnppc
    libnppidei
    libnppist
    libnvgraph
  )
  for lib in "${_cuda_stubs_libs[@]}"; do
    build_line "patch ${pkg_prefix}/lib64/stubs/${lib}.so"
    patchelf --set-rpath "${CUDA_RUN_PATH}" "${pkg_prefix}/lib64/stubs/${lib}.so"
  done

  build_line "patch ${pkg_prefix}/nvvm/lib64/libnvvm.so"
  patchelf --set-rpath "${CUDA_RUN_PATH}" "${pkg_prefix}/nvvm/lib64/libnvvm.so"

  build_line "patch ${pkg_prefix}/extras/CUPTI/lib64/libcupti.so"
  patchelf --set-rpath "${CUDA_RUN_PATH}" "${pkg_prefix}/extras/CUPTI/lib64/libcupti.so"

  popd > /dev/null || return 1
}

do_strip() {
  return 0
}

do_check() {
  return 0
}

do_end() {
  if [[ -n "$_clean_perl" ]]; then
    rm -fv /usr/bin/perl
  fi

  if [[ -n "$_clean_rm" ]]; then
    rm -fv /bin/rm
  fi
}

# private #
_fix_interpreter_in_path() {
  local path=$1
  local fileending=$2
  local pkg=$3
  local int=$4

  # shellcheck disable=SC2016
  # I need these to be evaluated at exec time
  find "$path" -name "$fileending" -type f \
    -exec grep -Iq . {} \; \
    -exec sh -c 'head -n 1 "$1" | grep -q "$2"' _ {} "$int" \; \
    -exec sh -c 'echo "$1"' _ {} \; > /tmp/fix_interpreter_in_path_list

  grep -v '^ *#' < /tmp/fix_interpreter_in_path_list | while IFS= read -r line
  do
    fix_interpreter "$line" "$pkg" "$int"
  done
  rm -rf /tmp/fix_interpreter_in_path_list
}
