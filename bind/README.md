# bind

This package provides the bind name server.

## Usage

Typically this is a run-time dependency that can be added to your
plan.sh:

    pkg_deps=(core/bind)

You'll also have to add your own configuration for named and use a command like `named -c <path to config file>` to your run hook.
