# git

Git is a free and open source distributed version control system designed to handle everything from small to very large projects with speed and efficiency.

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

Binary package

## Usage

Install the package and execute git.

On windows, `binlink` is not supported, so you can execute directly from the package:

```
hab pkg install core/git
hab pkg exec core/git git --help
```

On Linux you can do the same, or binlink and use the command directly:

```
hab pkg install core/git --binlink
git --help
```

If using this as a dependency from another plan, you can include as a build or runtime dependency, and it will be automatically included in the path as necessary:

```
pkg_deps=(core/git)
```
