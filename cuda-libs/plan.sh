source ../cuda/plan.sh

pkg_name=cuda-libs
pkg_origin=core
pkg_description="Runtime libraries shipped by Nvidia CUDA"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('custom')
pkg_upstream_url="https://developer.nvidia.com/cuda-zone"

pkg_deps=(
  core/gcc-libs
  core/glibc
)
pkg_build_deps=(
  "core/cuda/$pkg_version"
  core/patchelf
)

pkg_bin_dirs=()
pkg_include_dirs=()
pkg_lib_dirs=(
  lib64
  lib64/stubs
  nvvm/lib64
)

do_install() {
  CUDA_RUN_PATH="${pkg_prefix}/lib64:${pkg_prefix}/nvvm/lib64:$(pkg_path_for gcc-libs)/lib:$(pkg_path_for glibc)/lib"

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
    cp -av "$(pkg_path_for core/cuda)/lib64/${lib}".* "${pkg_prefix}/lib64/"
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
    cp -av "$(pkg_path_for core/cuda)/lib64/stubs/${lib}".* "${pkg_prefix}/lib64/stubs/"
    patchelf --set-rpath "${CUDA_RUN_PATH}" "${pkg_prefix}/lib64/stubs/${lib}.so"
  done

  cp -av "$(pkg_path_for core/cuda)/nvvm/lib64/libnvvm".* "${pkg_prefix}/nvvm/lib64/"
  patchelf --set-rpath "${CUDA_RUN_PATH}" "${pkg_prefix}/nvvm/lib64/libnvvm.so"

  # Install EULA
  mkdir -p "${pkg_prefix}/share/licenses"
  cp -av "$(pkg_path_for core/cuda)/share/licenses/EULA.pdf" "${pkg_prefix}/share/licenses/EULA.pdf"
}

# Turn the remaining default phases into no-ops
do_download() {
  return 0
}

do_verify() {
  return 0
}

do_unpack() {
  return 0
}

do_prepare() {
  return 0
}

do_build() {
  return 0
}

do_strip() {
  return 0
}

# We will rely on tests from `cuda`, so skip them here
unset -f do_check
