Google Mock
===========

Maintainer: [Ben Dang](me@bdang.it)

Google Mock are part of the Google Test unit test framework for C/C++.  This package contains
pre-built static libraries for you to include into your project.  More info on usage can be
followed [here](https://github.com/google/googletest/tree/master/googlemock).

To help with locating the static libraries, a custom `pkg_config` has been included.  When you
build your app with Habitat, your `CXX_FLAGS` will have the correct include folder and your
`LD_LIBRARY_PATH` will have the path to the static library.  All you get to focus on is writing
awesome tests!

## Usage

Just include `core/googlemock` preferably in `pkg_build_deps`.
