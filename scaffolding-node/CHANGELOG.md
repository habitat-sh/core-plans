# Node Scaffolding CHANGELOG

[Full history](https://github.com/habitat-sh/core-plans/commits/master/scaffolding-node)

## 0.6.6 (10-18-2017)

- support prebuild and postbuild scripts

## 0.6.5 (10-11-2017)

- Exclude the results/ directory from inclusion in a package [#854]

## 0.6.4 (10-04-2017)

- prevent shellouts where hab functions can do the same work
- remove unnecessary bin/ dir inclusion in scaffold's pkg_bin_dirs
- move version parsing into scaffolding.sh
- update version parsing to omit = and v from version strings
- make core/node a build dependency in the scaffolding itself

## 0.6.3 (09-25-2017)

- add explicit dependency on core/node

## 0.6.2 (09-19-2017)

- move setting scaffolding app prefix until after pkg_version is computed

## 0.6.0 (05-18-2017)

- Initial release.
