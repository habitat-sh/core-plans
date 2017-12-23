# dovecot

This package provides the dovecot IMAP server.

## Usage

Typically this is a run-time dependency that can be added to your
plan.sh:

    pkg_deps=(core/dovecot)

You'll also have to add your own configuration for dovecot and use a command like `dovecot -c <path to config file>` to your run hook.
