Google Test
===========

[Google C++ Testing Framework](https://github.com/google/googletest) helps you write better C++
tests.  This package contains pre-built static libraries for googletest and googlemock for you to
include into your project.  To unit test your C/C++ app, you have to link and compile your unit
tests and then you will have an executable with the Google Test runner.  More info on usage can be
followed [here](https://github.com/google/googletest).

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>
* [Ben Dang](me@bdang.it)

## Type of Package

Static C++ Library and Include Headers

## Usage

If you require `gtest` and `gmock` just include `core/googletest` preferably in `pkg_build_deps`.  
Habitat will then update `CFLAGS`, `CXXFLAGS`, `CPPFLAGS`, `LDFLAGS` and `PKG_CONFIG_PATH` with
paths to the libs and includes.

### CMake

For those using `cmake`, this is an example `plan.sh`

```bash
pkg_origin=bdangit
pkg_name=googletest-cmake-example
pkg_version='0.1.0'
pkg_description="googletest cmake example"
pkg_license=('MIT')
pkg_maintainer='Ben Dang <me@bdang.it>'
pkg_deps=(
  core/gcc-libs
  core/glibc
)
pkg_build_deps=(
  core/gcc
  core/make
  core/cmake
  core/googletest
)
pkg_bin_dirs=(bin)

do_setup_environment() {
  set_buildtime_env BUILD_DIR "build"
}

do_prepare() {
  mkdir -p "${BUILD_DIR}"
}

do_build() {
  pushd "${BUILD_DIR}" > /dev/null

  _GTEST_PATH="$(pkg_path_for core/googletest)"

  cmake \
    -DCMAKE_INSTALL_PREFIX="${pkg_prefix}" \
    -DGTest_DIR="${_GTEST_PATH}/lib64/cmake/GTest" \
    ..
  make

  popd > /dev/null
}
```

In your `CMakeLists.txt`, make sure to find the package `GTest` and set your target to link against
`GTest::gtest`, `GTest::gtest_main`, `GTest::gmock`, and/or `GTest::gmock_main`.

```cmake
# note: we want the config mode since googletest packaged a very robust cmake macro
#       for finding gtest and gmock
find_package(GTest CONFIG REQUIRED)

add_executable(gtest-sample sample.cpp)
target_include_directories(gtest-sample PRIVATE src)
target_link_libraries(gtest-sample GTest::gtest GTest::gtest_main)
```
