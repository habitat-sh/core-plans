# Example Usage of tomcat8

This is an example usage of the core/tomcat8 plan

## Maintainers

The Habitat Maintainers: <humans@habitat.sh>

## Usage

Ensure that the terminal is located in the core-plans directory.  Enter a habitat studio ``hab studio enter`` and do the following steps

```bash
( cd tomcat8 && hab pkg build ./examples/using_jre8_in_pkg_dep )
```

Exit the habitat studio environment

Open another habitat studio ``hab studio enter`` and do the following steps:

```bash
# obtain the $pkg_ident from the last_build.env
source tomcat8/examples/using_jre8_in_pkg_dep/results/last_build.env

# run the bats tests to verify the service
tomcat8/examples/using_jre8_in_pkg_dep/test.sh "${pkg_ident}"
```

Sample output:

```bash
[2][default:/src:0]# tomcat8/examples/using_jre8_in_pkg_dep/test.sh "${pkg_ident}"
» Installing core/bats
...
...
The core/tomcat8/8.5.9/20190516111146 service was successfully loaded
 ✓ package directory for package ident core/tomcat8/8.5.9/20190516111146 exists
 ✓ tomcat8.default habitat service should be running
 ✓ curl -sS localhost:8080 should return correct version 8.5.9

3 tests, 0 failures
[3][default:/src:0]#
```
