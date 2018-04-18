prometheus-cpp
===============

This package provides the [Prometheus Client C++ Library](https://github.com/jupp0r/prometheus-cpp).

## Maintainers

The Habitat Maintainers humans@habitat.sh

## Type of Package

Static C++ Library and `include`

## Usage

If you are building a C++ application and you require a way to provide metrics especially
for [Prometheus](http://prometheus.io), then add this package to your `pkg_build_deps`.  Habitat
will then populate the `LD_RUN_PATH`, `CFLAGS`, `CXXFLAGS`, etc. to allow you statically link to
this library.

### CMake

For those using `cmake`, this is an example `plan.sh`:

```bash
pkg_name=prometheus-cpp-example
pkg_origin=bdangit
pkg_version=0.1.0
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

BUILDDIR='build'

do_prepare() {
  rm -rf "${BUILDDIR}"
}

do_build() {
  mkdir -p "${BUILDDIR}"
  cmake -H./ \
    -B${BUILDDIR} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
    -Dprometheus-cpp_DIR="$(pkg_path_for core/prometheus-cpp)/lib64/cmake/prometheus-cpp"
  make -C "${BUILDDIR}" VERBOSE=${DEBUG}
}

do_install() {
  make -C "${BUILDDIR}" install
}
```

In your `CMakeLists.txt`, make sure to find the package `prometheus-cpp` and set your target to link against `prometheus-cpp::prometheus-cpp`.

```cmake
find_package(prometheus-cpp REQUIRED)

add_executable(myapp main.cpp)
target_link_libraries(myapp prometheus-cpp::prometheus-cpp)
```

### Example Application

An example application built with Habitat is can be viewed
 [here](https://github.com/bdangit/prometheus-cpp-example).
