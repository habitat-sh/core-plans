This package provides the telegraf binary and the basic default configuration file that can be used to start the service. Custom configuration should be done by creating a new package that depends on `core/telegraf`. For example:

```shell
pkg_name=acme-telegraf
pkg_origin=example
pkg_version=1.0
pkg_maintainer="Example Operations <ops@example.com>"
pkg_description="Custom Telegraf configuration for the ACME application cluster"
pkg_license=("Apache-2.0")
pkg_deps=(core/telegraf)
pkg_svc_user="root"
pkg_svc_group="root"
pkg_svc_run="telegraf --config ${pkg_svc_config_path}/telegraf.conf"

do_build() {
  return 0
}

do_install() {
  return 0
}
```

(other callbacks may need to be overwritten with `return 0`)
