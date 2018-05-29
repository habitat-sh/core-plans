# csvkit

A suite of utilities for converting to and working with CSV, the king of tabular file formats.

Full documentation for csvkit is available at [csvkit.readthedocs.io](https://csvkit.readthedocs.io)

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Usage

All the commands provided by the csvkit project are exported by this package via `pkg_bin_dirs`. They rely on a habitat-provided runtime environment though and so will not work via binlink. Use `hab pkg exec` for best results:

```bash
hab pkg exec core/csvkit in2csv data.xlsx > data.csv
```
