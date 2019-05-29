# apr

Apache Portable Runtime

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

Binary package

## Usage

More details - https://apr.apache.org

On Linux binlink and use the command directly:

```
hab pkg install core/apr --binlink
apr-1-config --version

```

## Testing

```
hab studio build go
source results/last_build.env
hab studio run ./apr/tests/test.sh ${pkg_ident}
```
## Sample Output

```
1..3
ok 1 package directory for package ident bernagh/apr/1.6.5/20190529124535 exists
ok 2 apr-1-config exe runs
ok 3 apr-1-config exe output mentions expected version 1.6.5
```
