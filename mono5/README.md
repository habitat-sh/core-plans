# Mono5
Mono is a software platform designed to allow developers to easily create cross platform applications part of the .NET Foundation.

## Maintainers
The Habitat Maintainers <humans@habitat.sh>

## Type of Package
Binary Package for building and running Mono applications.

## Usage

### Runtime
Add `core/mono5` to your `pkg_deps` and invoke your mono application using the `{{pkgPathFor "core/mono5"}}` handlebars helper in your hooks.

### Building Mono Applications
Add `core/mono5` to your `pkg_build_deps` or `pkg_deps` and run your build using the `pkg_path_for mono5` shell helper or `{{pkgPathFor "core/mono5"}}` handlebars helper.

## Notes
Building Mono applications may require additional third-party Mono specific build tools which have not yet been added to core-plans. Please be sure to check your application build to ensure you can build using standard tools.
