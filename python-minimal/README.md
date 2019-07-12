# python-minimal

This package is intended to be used only as a build dependency for glibc.

If you would like to use Python in your applications, please look at `core/python` or one of the other versioned Python packages.

## Why does this package exist?

With glibc2.29, python was introduced as a build dependency. If we were to include `core/python` as a build dependency for `core/glibc`
it would increase the number of items that are considered "base plans", i.e. plans that are required in order to bootstrap the Habitat
ecosystem. This would make packages like Python and sqlite more difficult to update. Having `core/python` as a build dependency for
`core/glibc` means that the footprint of packages that would cause the world to rebuild would be greatly increased, resulting in slower
updates for those packages or more churn across our entire ecosystem.

As a result, this package (`python-minimal`) was introduced so that we have a version of Python that has minimal depdencies, should need
infrequent updates, and keeps the number of packages that would cause a "world rebuild" to a minimum.

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>
