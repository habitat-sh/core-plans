# apr-util

Apache Portable Runtime Utility

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

Binary package

## Usage

More details - https://apr.apache.org

On Linux binlink and use the command directly:

```
hab pkg install core/apr-util --binlink
apu-1-config --version
```

## Testing

```
hab studio build apr-util
source results/last_build.env
hab studio run "./apr-util/tests/test.sh ${pkg_ident}"
```
## Sample Output

```
1..3
ok 1 package directory for package ident core/apr-util/1.6.1/20190603213302 exists
ok 2 apu-1-config exe runs
ok 3 apu-1-config exe output mentions expected version 1.6.1
```
