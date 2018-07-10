# 7zip

7-Zip is a file archiver with a high compression ratio.

## Maintainers

The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

Binary package

## Usage

Install the package and execute 7zip.

On windows, `binlink` is not supported, so you can execute directly from the package:

```
hab pkg install core/7zip
hab pkg exec core/7zip 7z --help
```

On Linux you can do the same, or binlink and use the command directly:

```
hab pkg install core/7zip --binlink
7z --help
```
