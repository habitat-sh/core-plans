source "$(dirname "${BASH_SOURCE[0]}")/../cuda/plan.sh"

pkg_name=cuda9
pkg_origin=core
pkg_description="GPU-accelerated Libraries for Computing on NVIDIA devices"
pkg_version=9.2.148
_driverver=396.37
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('custom')
pkg_source="https://developer.nvidia.com/compute/cuda/9.2/Prod2/local_installers/cuda_${pkg_version}_${_driverver}_linux"
pkg_filename="cuda_${pkg_version}_${_driverver}_linux.run"
pkg_shasum=f5454ec2cfdf6e02979ed2b1ebc18480d5dded2ef2279e9ce68a505056da8611
pkg_upstream_url="https://developer.nvidia.com/cuda-zone"
