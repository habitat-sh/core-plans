# Nano

GNU nano -- an enhanced clone of the Pico text editor.

## Maintainers

* The Habitat Maintainers <humans@habitat.sh>

## Type of Package

Binary package

## Usage

```
hab pkg install core/nano --binlink
nano
```

Or, execute from package without binlink:

```
hab pkg exec core/nano nano
```

## Notes

Syntax highlighting files are distrubuted by default in the `${pkg_prefix}/share/nano/` directory. You can enable syntax highlighting by creating a `.nanorc` file in your user home directory, and including these files. Example: `include /hab/pkg/core/nano/2.9.8/0180702051038/share/nano/*.nanorc`.

Note, it might be simpler to symlink this directory somewhere for shorter paths / easier access, or use the hab helpers:

```
echo "include $(hab pkg path core/nano)/share/nano/*.nanorc" > ~/.nanorc
```
