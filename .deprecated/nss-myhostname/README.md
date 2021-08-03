# nss-myhostname

[nss-myhostname](http://0pointer.de/lennart/projects/nss-myhostname/) is a plugin for the GNU Name Service Switch (NSS) functionality of the GNU C Library (glibc) providing host name resolution for the locally configured system hostname as returned by gethostname(2). This plugin is commonly enabled in the default `/etc/nsswitch.conf` NSS configuration of RHEL and RHEL-like Linux distributions. glibc has `/etc/nsswitch.conf` hard-coded as the file location for configuration. So long as core/glibc ships with that setting, this plugin is necessary for some software to perform name resolution with expected behavior.

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

Binary package

## Usage

Typically this is a runtime dependency that can be added to your
plan.sh:

    pkg_deps=(core/nss-myhostname)
