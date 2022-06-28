# Nginx

Nginx is an HTTP and reverse proxy server, a mail proxy server, and a generic TCP/UDP proxy server.

## Maintainers

* The Habitat Maintainers <humans@habitat.sh>

## Type of Package

Service package

## Usage

This plan builds nginx and is usable standalone. However, the intention is that a configuration plan should be create to wrap this plan, allowing customization of the service and configuration.

Examples of this are detailed below.

## Bindings

Consuming an Nginx service depends on what ports are exposed. Configuration plans wrapping `core/nginx` may expose more than a single port, however this core plan exposes a single http port:

```
han start <origin>/<app> --bind webserver:nginx.default
```

The app being started should be configured to read a `port` binding from the webserver.

## Topologies

Nginx is designed as a standalone service.

## Update Strategies

An at-once update strategy is recommended. However this can be changed / altered as you wrap the plan to customize its functionality.

### Configuration Updates

It is highly recommended that this plan not be used directly as a service to run your webserver.

Use this plan as a dependency of your plan, providing your own configuration and settings.

## Monitoring

## Practical Usage

As mentioned throughout the readme, it is not recommended to run this plan standalone without changes. We highly recommend that you build a configuration plan to provide the functionality that you need, and gain the control you require for your webserver.

This section will detail how to achieve this.

### Configuration Plan

A configuration plan is a Habitat plan that has a dependency on another plan, and simply provides its own configuration for the service. They have also been called Wrapper plans.

### Wrapping Nginx

Create a new plan:

```
hab plan init my-webserver
cd my-webserver
```

At minimum, the `plan.sh` should contain the following:

```
pkg_name=my-webserver
pkg_origin=myorigin
pkg_version="0.1.0"
pkg_deps=(core/nginx)
pkg_exports=(
  [port]=port
)
pkg_exposes=(port)

do_build() {
  return 0
}

do_install() {
  return 0
}
```

The `default.toml` should contain the following:

```
worker_processes = "auto"
port = 80

[events]
worker_connections = 512
```

Next, you will need to create 2 files. One is the static `mime.types` required by nginx to serve the content correctly, and the other is the main `nginx.conf` which will override some compiled-in values from the `core/nginx` package.

You can download the `mime.types` file from the [Nginx repository][mime-types].

The `nginx.conf` file should contain at least the following:

```
daemon off;
pid {{pkg.svc_var_path}}/pid;
worker_processes {{cfg.worker_processes}};

events {
  worker_connections {{cfg.events.worker_connections}};
}

http {
  include        mime.types;
  default_type   application/octet-stream;

  client_body_temp_path {{pkg.svc_var_path}}/client-body;
  fastcgi_temp_path {{pkg.svc_var_path}}/fastcgi;
  proxy_temp_path {{pkg.svc_var_path}}/proxy;
  scgi_temp_path {{pkg.svc_var_path}}/scgi_temp_path;
  uwsgi_temp_path {{pkg.svc_var_path}}/uwsgi;

  server {
    listen {{cfg.port}} default_server;
    server_name _;

    location / {
      root {{pkg.svc_data_path}};
      index index.html index.htm;
    }
  }
}
```

The important pieces here are the `temp_path` overrides that will allow Nginx to write temporary content to the correct directories.

Once you have created the above files, you can enter a habitat studio and build the plan:

```
hab studio enter

[1][default:/src:0]# build
```

[mime-types]: https://github.com/nginx/nginx/blob/master/conf/mime.types
