# grpc-cpp

This packages provides the [GRPC C/C++ Libraries](https://grpc.io).  GRPC is a a high performance, open-source universal RPC framework.

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

Binary package

## Usage

If you are buildinig a C++ application, then add `core/grpc-cpp` to your
`pkg_build_deps`.  Habitat will then populate the `LD_RUN_PATH`, `CFLAGS`,
`CXX_FLAGS`, and `CMAKE_FIND_ROOT_PATH`.
