source "$(dirname "${BASH_SOURCE[0]}")/../cuda/plan.sh"

pkg_name=cuda10
pkg_origin=core
pkg_description="GPU-accelerated Libraries for Computing on NVIDIA devices"
pkg_version=10.0.130
_driverver=410.48
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('custom')
pkg_source="https://developer.nvidia.com/compute/${pkg_name}/10.0/Prod/local_installers/${pkg_name}_${pkg_version}_${_driverver}_linux"
pkg_filename="${pkg_name}_${pkg_version}_${_driverver}_linux.run"
pkg_shasum=92351f0e4346694d0fcb4ea1539856c9eb82060c25654463bfd8574ec35ee39a
pkg_upstream_url="https://developer.nvidia.com/cuda-zone"
