# Habitat Node.js Scaffolding

This is [Habitat
scaffolding](https://www.habitat.sh/docs/concepts-scaffolding/) for
[Node.js](https://nodejs.org/en/) software.

To use it add:

```
pkg_scaffolding=core/scaffolding-node
```

to your plan.

If you have set a `pkg_source`, it will try to use
[NPM](https://www.npmjs.com/) to build your package. If you don't, it will look
in `$SRC_PATH` for a package.json and attempt to build a package using those
files and data.

## Node Version

### Selecting a Version of Node

By default the latest version of the Node.js ([`core/node`](https://app.habitat.sh/#/pkgs/core/node) package will be injected into your Plan's `pkg_deps` array. To specify a non-default version of Node, there are two locations you can do this:

1. Have a version set in a `.nvmrc` file in your plan's source
2. Set the `scaffolding_node_pkg` variable in your Plan with a valid Habitat package identifier corresponding to a package with `node` and `npm` programs

A set Plan variable will win over setting a version in your `.nvmrc`, however it is recommended to the `.nvmrc` strategy first as this makes it possible to use the exact same Node version in development with [nvm](https://github.com/creationix/nvm) and compatible tools as in your Habitat package.

#### Specifying a Node Version in Your .nvmrc

You can put a file in your source called `.nvmrc` that contains the version of Node your applcation should use.

For example, a `.nvmrc` with the contents of `5.6.0` in `core/node/5.6.0` being injected into your Plan's `pkg_deps` array.

#### Specifying a Node Version in Your Plan

You can set the `scaffolding_node_pkg` variable in your Plan to specify a version of Node. For example:

```sh
pkg_name=my_app
pkg_origin=acmecorp
pkg_version=0.1.0
# ...
pkg_scaffolding=core/scaffolding-node

scaffolding_node_pkg=core/node/5.6.0
```

The value of this variable will be used to determine the Habitat package to satisfy the role of your app's Node implementation.

## Features

* If you set `pkg_source` to anything that can be used by `npm install`, it will install it
* `pkg_description`, `pkg_license`, `pkg_maintainer`, and `pkg_upstream_url` can all be auto-populated from their corresponding values in the package's package.json
* A run hook can be generated from the scripts.start field of the package.json, or if there's a server.js at the root of the package it will use that
* If you're using the [config](https://github.com/lorenwest/node-config) package, you can put a config/production.js or config/default.js (or [other file formats](https://github.com/lorenwest/node-config/wiki/Configuration-Files#file-formats)) in your plan and the run hook will set the `NODE_CONFIG_PATH` to the `$pkg_svc_config_path` and use them
* If a config/env file is present in the plan it will be sourced into any generated run hook. You can set environment variables there to be used in your app.

## Building

In a studio where /src is the [core-plans
repo](https://github.com/habitat-sh/core-plans), run `build scaffolding-node`.

## Running tests

Run:

```bash
hab pkg exec chef/inspec inspec exec scaffolding-node/test
```

This assumes that the `$HAB_ORIGIN` that is set in the studio is the same as the
origin of the scaffolding-node package that is installed and used to run the
tests.
