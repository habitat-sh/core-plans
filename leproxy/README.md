# leproxy

HTTPS reverse proxy with automatic Letsencrypt usage for multiple hostnames/backends.

## Maintainers

* The Habitat Maintainers <humans@habitat.sh>

## Type of Package

Binary package

## Usage

`leproxy` is a simple HTTPS proxy, and configuration will be specific to the backend services that are being proxied. As such, this package remains as a binary package that can be wrapped by service plans. Since this uses name based directives in `mapping.yml` there is no appropriate default settings.

A simple proxy would include a configuration `mapping.yml` matching server names to be used with their backends:

```yml
subdomain1.example.com: 127.0.0.1:8080
subdomain2.example.com: /var/run/http.socket
static.example.com: /var/www/
```

For a full example, please see the [leproxy readme][leproxy-readme].

This config would be paired with the service run command, such as:

```sh
leproxy -addr :https -map /path/to/mapping.yml -cacheDir /path/to/letsencrypt
```

Here is a full plan example, using leproxy:

```sh
pkg_name=web-proxy
pkg_origin=myorigin
pkg_version="0.1.0"

pkg_svc_run="leproxy -addr :https -map ${pkg_svc_config_path}/mapping.yml -cacheDir ${pkg_svc_var_path}/letsencrypt"
```

[leproxy-readme]: https://github.com/artyom/leproxy
