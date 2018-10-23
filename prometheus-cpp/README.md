prometheus-cpp
===============

This package provides the [Prometheus Client C++ Library](https://github.com/jupp0r/prometheus-cpp).

## Maintainers

The Habitat Maintainers humans@habitat.sh

## Type of Package

Static C++ Library and `include`

## Usage

If you are building a C++ application and you require a way to provide metrics especially for
[Prometheus](http://prometheus.io), then add this package to your `pkg_build_deps`.  Habitat will then populate the
`LD_RUN_PATH`, `CFLAGS`, `CXXFLAGS`, and `CMAKE_FIND_ROOT_PATH`. to allow you statically link to this library.

### CMake

For those using `cmake`, this is an example `plan.sh`:

```bash
pkg_name=prometheus-cpp-example
pkg_origin=bdangit
pkg_version=0.1.1
pkg_license=('MIT')
pkg_build_deps=(
  core/gcc
  core/cmake
  core/make
  core/pkg-config
  core/prometheus-cpp
)
pkg_deps=(
  core/glibc
  core/gcc-libs
  core/zlib
  core/protobuf
)

pkg_bin_dirs=(bin)

do_begin() {
  export HAB_ENV_CMAKE_FIND_ROOT_PATH_SEPARATOR=";"
  export HAB_ENV_CMAKE_FIND_ROOT_PATH_TYPE="aggregate"
}

do_setup_environment() {
  set_buildtime_env BUILDDIR "_build"
}

do_prepare() {
  mkdir -p "${BUILDDIR}"
}

do_build() {
  pushd "${BUILDDIR}" || exit 1
  cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
    -DCMAKE_FIND_ROOT_PATH="${CMAKE_FIND_ROOT_PATH}" \
    ..
  make
  popd || exit 1
}

do_install() {
  pushd "${BUILDDIR}" || exit 1
  make install
  popd || exit 1
}
```

In your `CMakeLists.txt`, make sure to find the package `prometheus-cpp` and set your target to link against
`prometheus-cpp::core`, `prometheus-cpp::pull`, and/or `prometheus-cpp::push`.

```cmake
find_package(prometheus-cpp REQUIRED)

add_executable(myapp main.cpp)
target_link_libraries(myapp prometheus-cpp::core prometheus-cpp::pull)
```

### Example Application

An example application built with Habitat can be viewed [here](https://github.com/bdangit/prometheus-cpp-example).
