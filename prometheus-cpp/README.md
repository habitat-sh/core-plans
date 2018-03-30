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

An example application can view [here](https://github.com/jupp0r/prometheus-cpp#usage).
