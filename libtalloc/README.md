# Habitat package: libtalloc

## Description

Talloc is a hierarchical, reference counted memory pool system with destructors. It is the core memory allocator used in Samba.

## Usage

This is a library needed for various projects, such as FreeRADIUS(https://freeradius.org). It can be consumed by a plan
during build/runtime.

Example:

do_build() {
  ./configure --prefix="${pkg_prefix}" \
    --with-talloc-lib-dir="$(pkg_path_for core/talloc)" \
    --with-talloc-include-dir="$(pkg_path_for core/talloc)"
  make
}
