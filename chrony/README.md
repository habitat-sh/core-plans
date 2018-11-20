# chrony

This package provides the chrony daemon.

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

Binary package

## Usage

Typically this is a run-time dependency that can be added to your
plan.sh:

    pkg_deps=(core/chrony)

You'll also have to add your own configuration for named and use a command like `chronyd -f -s {{ pkg.svc_config_path }}/chrony.conf` to your run hook.
