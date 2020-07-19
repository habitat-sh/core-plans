# busybox

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

Binary package

## Usage

Install the package, and binlink any commands you want to use from `busybox`.

Note that because most of these commands are present on existing distributions, you may need to use `--force` while using the binlink command.

```
hab pkg install core/busybox
hab pkg binlink core/busybox telnet --force
```
