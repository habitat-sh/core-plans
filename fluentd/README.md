## Habitat Package: Fluentd

> Fluentd is an open source data collector for unified logging layer.

- [www](https://www.fluentd.org/)
- [Docs](https://docs.fluentd.org/v0.14/articles/quickstart)

This plan provides base Fluentd package without any external plugin installed and supports standalone topology.

### Basic Usages

#### Starting

```shell
hab start core/fluentd
```

By default, this package will accept logs/events on below ports and stream them to stdout.
- 24224 - [forward input plugin](https://docs.fluentd.org/v0.14/articles/in_forward)
- 8888  - [http input plugin](https://docs.fluentd.org/v0.14/articles/in_http)

#### Stopping

```shell
hab sup stop core/fluentd
```

#### Customizing

When using fluentd, you'll want to add your own rules or plugins, this cannot be done with this package. You'll need to create your own which would be clone of this one. The configuration is provided as a model for you to speed up your package development.

For example, Make a fluentd package with `fluent-plugin-elasticsearch` and `fluent-plugin-record-modifier` plugins:
- clone this folder

```shell
git clone git@github.com:habitat-sh/core-plans.git
cp -a core-plans/fluentd ./
cd fluentd
```

- Update `plan.sh` to reflect desired metadata and add plugins to `Gemfile`:

```shell
pkg_name=fluentd-example
pkg_origin=example
pkg_version=0.14.3
pkg_deps=(
  core/ruby
  core/coreutils
  core/bundler
)
pkg_build_deps=(
  core/make
  core/gcc
  core/gcc-libs
)
pkg_upstream_url=https://www.fluentd.org/
pkg_description="Fluentd is an open source data collector, which lets \
  you unify the data collection and consumption for a better use and \
  understanding of data."
pkg_license=('Apache-2.0')
pkg_maintainer="Example name <name@example.com>"
pkg_source=nothing-downloaded-but-build-in-src-cache-anyway
pkg_bin_dirs=(bin)
pkg_exports=(
  [forward-port]=input.forward.port
  [http-port]=input.http.port
)
pkg_exposes=(forward-port http-port)

do_download() {
  return 0
}

do_verify() {
  return 0
}

do_unpack() {
  return 0
}

do_build() {
  local _bundler_dir
  _bundler_dir=$(pkg_path_for bundler)

  export GEM_HOME=${pkg_path}/vendor/bundle
  export GEM_PATH=${_bundler_dir}:${GEM_HOME}

  cat > Gemfile <<-GEMFILE
    source 'https://rubygems.org'
    gem 'fluentd', '= ${pkg_version}'
    gem 'fluent-plugin-elasticsearch'
    gem 'fluent-plugin-record-modifier'
GEMFILE

  bundle install --jobs 2 --retry 5 --path ./vendor/bundle --binstubs
}

do_install() {
  cp -R . "$pkg_prefix/"
  fix_interpreter "$pkg_prefix/bin/*" core/coreutils bin/env
}

```

- Update the configuration by editing `config/fluent.conf`
- Build and export it

```shell
hab studio enter
> build
> hab pkg export docker $HAB_ORIGIN/fluentd-example
> exit
```

### CODEOWNERS

Rahul Sinha (rahulwa) @rahulwa_
