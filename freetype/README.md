# freetype

A software library to render fonts

## Maintainers

The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

Binary package

## Usage

*TODO: Add instructions for usage*

# Building core/freetype on Linux/Mac

## Build the freetype core plan

For example from the core-plans root, do the following from a terminal

```bash
# build freetype from its own directory
( cd freetype && hab pkg build . )
```

## Verify the build

Bats tests have been added to the core/freetype plan that

* are run as part of the build within the [do_after() callback](https://www.habitat.sh/docs/reference/#reference-callbacks):
* define basic build environment contraints including the presence of a couple dependencies, core/zlib and core/libpng.
* are packaged with the core/freetype hart so can be reused in other plans that include the core/freetype plan
* produce output in the build something like:

   ```bash
   ...
   ...
      freetype: Running sanity tests against the build
   1..5
   ok 1 core/zlib must be installed
   ok 2 core/libpng must be installed
   ok 3 PKG_CONFIG_PATH must be set and not be empty
   ok 4 core/zlib must be included in the $pkg_deps so that it is added to PKG_CONFIG_PATH
   ok 5 core/libpng must be included in the $pkg_deps so that it is added to PKG_CONFIG_PATH
      freetype: Building package metadata
   /hab/cache/src/freetype-2.9.1 /src
   ...
   ...
   ```

# Using the tests packaged within core/freetype

A wrapper plan has been included beneath the test directory that illustrates a minimum configuration for the core/freetype.  The wrapper plan also illustrates how to run bats tests that might be packaged within any of the dependencies within $pkg_dep.

To build the wrapper plan and test the locally built core/freetype:

* ensure that the terminal is located in the core-plans directory
* open a habitat studio.
* do the following steps:

```bash
# set environment from the last freetype build
source freetype/results/last_build.env

# install the freetype artifact
hab pkg install freetype/results/$pkg_artifact

# build the test plans
( cd freetype/test && build . )
```

## Positive scenario, when all tests pass

The build above should complete without error and contain passing bats tests re-used from the installed core/freetype package.  For example:

```bats
   ...
   ...
   freetype_setenv: Stripping unneeded symbols from binaries and libraries
   freetype_setenv: ~~~~~~~~~~~~~~~~~ Start Habitat Build Tests ~~~~~~~~~~~~~~~~~
   freetype_setenv: no tests defined for core/zlib
   freetype_setenv: no tests defined for core/libpng
   freetype_setenv: running tests for bigbird/freetype
   freetype_setenv: /hab/pkgs/bigbird/freetype/2.9.1/20190513145457/test/bats/integration/integration.bats
 ✓ core/freetype must be installed
 ✓ core/freetype must be included in the $pkg_deps so that it is added to $PKG_CONFIG_PATH
 ✓ if PKG_CONFIG_PATH is set, 'freetype-config --prefix' should return the $pkg_prefix for freetype

3 tests, 0 failures
   freetype_setenv: /hab/pkgs/bigbird/freetype/2.9.1/20190513145457/test/bats/unit/pkg_config_path.bats
 ✓ PKG_CONFIG_PATH must be set and not be empty
 ✓ core/zlib must be included in the $pkg_deps so that it is added to PKG_CONFIG_PATH
 ✓ core/libpng must be included in the $pkg_deps so that it is added to PKG_CONFIG_PATH

3 tests, 0 failures
   freetype_setenv: /hab/pkgs/bigbird/freetype/2.9.1/20190513145457/test/bats/unit/dependencies.bats
 ✓ core/zlib must be installed
 ✓ core/libpng must be installed

2 tests, 0 failures
   freetype_setenv: ~~~~~~~~~~~~~~~~~ Finish Habitat Build Tests ~~~~~~~~~~~~~~~~~
   freetype_setenv: Building package metadata
...
...
   freetype_setenv: hab-plan-build cleanup
   freetype_setenv:
   freetype_setenv: Source Path: /src/freetype/test
   freetype_setenv: Installed Path: /hab/pkgs/bigbird/freetype_setenv/0.1.0/20190513132053
   freetype_setenv: Artifact: /src/freetype/test/results/bigbird-freetype_setenv-0.1.0-20190513132053-x86_64-linux.hart
   freetype_setenv: Build Report: /src/freetype/test/results/last_build.env
   freetype_setenv: SHA256 Checksum: 619b63b358d0708395bad1f6f96508006bcf4624578e97f966d5721d12f468dc
   freetype_setenv: Blake2b Checksum: b5650151527fc207afadc6a09dc367e36c640b29191eed820f4c8857ca68f472
   freetype_setenv:
   freetype_setenv: I love it when a plan.sh comes together.
   freetype_setenv:
   freetype_setenv: Build time: 1m4s
[7][default:/src:0]# e
```

## Negative scenario, when some tests fail

One of the tricky features about the core/freetype core plan is that if a plan includes it, then the same must also include a couple other dependencies core/libpng and core/zlib.  If these dependencies are present, then the build will complete without error as above.   If however, one of the dependencies then the build may complete but the environment may not work as expected.  

For example, remove the core/libpng from the pkg_deps and the bats tests will fail the build with a clear indication of how to fix the dependency.  First, remove the dependency from the plan.sh

```diff
diff --git a/freetype/test/habitat/plan.sh b/freetype/test/habitat/plan.sh
index 5941fbc1..b1df9da8 100644
--- a/freetype/test/habitat/plan.sh
+++ b/freetype/test/habitat/plan.sh
@@ -6,7 +6,6 @@ pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
 pkg_license=("Apache-2.0")
 pkg_deps=(
   core/zlib
-  core/libpng
   "${HAB_ORIGIN}/freetype"
 )
 pkg_build_deps=( core/diffutils core/bats )
```

Second, rebuild and notice the failing tests have also cause the build to fail.  :

```bats
[8][default:/src:0]# ( cd freetype/test && build . )
...
...
   freetype_setenv: Stripping unneeded symbols from binaries and libraries
   freetype_setenv: ~~~~~~~~~~~~~~~~~ Start Habitat Build Tests ~~~~~~~~~~~~~~~~~
   freetype_setenv: no tests defined for core/zlib
   freetype_setenv: running tests for bigbird/freetype
   freetype_setenv: /hab/pkgs/bigbird/freetype/2.9.1/20190513145457/test/bats/integration/integration.bats
 ✓ core/freetype must be installed
 ✓ core/freetype must be included in the $pkg_deps so that it is added to $PKG_CONFIG_PATH
 ✓ if PKG_CONFIG_PATH is set, 'freetype-config --prefix' should return the $pkg_prefix for freetype

3 tests, 0 failures
   freetype_setenv: /hab/pkgs/bigbird/freetype/2.9.1/20190513145457/test/bats/unit/pkg_config_path.bats
 ✓ PKG_CONFIG_PATH must be set and not be empty
 ✓ core/zlib must be included in the $pkg_deps so that it is added to PKG_CONFIG_PATH
 ✗ core/libpng must be included in the $pkg_deps so that it is added to PKG_CONFIG_PATH
   (in test file /hab/pkgs/bigbird/freetype/2.9.1/20190513145457/test/bats/unit/pkg_config_path.bats, line 14)
     `diff <( echo "${PKG_CONFIG_PATH}" ) <( echo "${result}" )' failed
   1c1
   < /hab/pkgs/core/zlib/1.2.11/20190115003728/lib/pkgconfig:/hab/pkgs/bigbird/freetype/2.9.1/20190513145457/lib/pkgconfig
   ---
   > didn't contain /hab/pkgs/core/libpng/

3 tests, 1 failure
   freetype_setenv: /hab/pkgs/bigbird/freetype/2.9.1/20190513145457/test/bats/unit/dependencies.bats
 ✓ core/zlib must be installed
 ✓ core/libpng must be installed

2 tests, 0 failures
   freetype_setenv: ~~~~~~~~~~~~~~~~~ Finish Habitat Build Tests ~~~~~~~~~~~~~~~~~
   freetype_setenv: WARN: check the build for failing tests
   freetype_setenv: Build time: 0m6s
   freetype_setenv: Exiting on error
[48][default:/src:1]#
```

# Design Comments

* the bats tests live beneath the exploded "freetype" package directory--the hart artifact will be created from this package directory
* the test/bats directory has been divided into 'unit' and 'integration' directories.
* the 'unit' tests verify that freetype is setup correctly with necessary core package dependencies
* the 'integration' tests verify that freetype-config works in the current plan's build environment
* the wrapper plan triggers the test from within the ``do_after()`` passes the array of $pkg_deps to the ``run_all_tests()`` which runs all bats tests contained in every dependency.  It only terminates the build if one or more tests have failed.  If this pattern is accepted then ``run_all_tests()`` could be placed in a common source script so that all plans have access to this.
* $pkg_deps plans that do not have any tests are ignored.

   ```bash
   do_after() {
   run_all_tests ${pkg_deps[@]}
   }
   ```

* the ``do_install()`` copies the to the $pkg_prefix/test directory.  This ensures the tests are included in the hart artifact.

    ```bash
    do_install() {
    do_default_install

    build_line "Remove space from freetype-config interperter"
    sed -i 's@#! /bin/sh@#!/bin/sh@' "$CACHE_PATH/builds/unix/freetype-config"

    build_line "Copy freetype-config to bin"
    install "$CACHE_PATH/builds/unix/freetype-config" "$pkg_prefix/bin/"

    fix_interpreter "$pkg_prefix/bin/freetype-config" "core/bash" "bin/sh"

    build_line "Copy tests to installation"
    mkdir -p "$pkg_prefix/test/bats"
    cp -R $PLAN_CONTEXT/test/bats "$pkg_prefix/test/."
    }
    ```
