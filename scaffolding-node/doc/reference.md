# Node Scaffolding

Node Scaffolding is a [Habitat][habitat] package which helps you build your Node.js-based **web applications**, **services**, and **processes** (hereafter referred to as "apps") into a package which runs consistently on a wide range of containers, virtual machines, or servers via the Habitat Supervisor. The Supervisor will facilitate clustering, discovery of external services such as databases, dynamically update configuration and credentials, coordinate reliable rolling updates, and a lot more!

For more about Habitat, you can check out [Try Habitat][try_hab]. For more about building your apps, read on!

## Use Node Scaffolding for Your App

Check out the [Node Scaffolding QuickStart Guide](quickstart.md).

## Scaffolding Detection

To properly load and use this Scaffolding, the implementation looks for a [`package.json`][] in your app's root directory. Either directory structure is supported:

A Plan in a `habitat/` subdirectory:

```
.
├── package.json
└── habitat
    └── plan.sh
```

A Plan in the same directory as the `package.json`:

```
.
├── package.json
└── plan.sh
```

## package.json

A [`package.json`][] must be present for this Scaffolding to function correctly. Note that this could even be an empty file if there are truly no Node dependencies.

## Package Dependencies

Most non-trivial apps need more than their own codebase to run correctly. Many have library dependencies which may require compiling native code. Others require certain software present for shelling out to (for example: ImageMagick). If more packages than the defaults are required, it is generally easy to add these to your Plan to fully describe your app's [build and runtime dependencies][12factor_dependencies].

### Default Dependencies

The following Habitat package dependencies will be injected into your app's Plan:

* [`core/busybox-static`][]: Used by process bins to have valid [shebangs][] and a consistent minimal command set. Will be injected into your Plan's `pkg_deps` array.

### Detected Dependencies

Currently no additional Habitat packages are added based on the contents of the `package.json` file, although some may be added in the future.

Additional checks performed by this scaffolding are:

* The app's version of Node will be determined by checking several source locations. See the Node Version section for more details.
* If your app's root directory contains a `yarn.lock` file, then [Yarn][]-related Habitat packages will be injected into your Plan's `pkg_build_deps` array for resolving and installing Node package dependencies. See the Package Manager section for more details.
* If your app's root directory contains a `.git/` subdirectory, then Git-related Habitat packages will be injected into your Plan's `pkg_build_deps` array to better support installing your app while honoring the `.gitignore` file.

###  Specifying Run Dependencies in Your Plan

Generally speaking, your app needs additional Habitat packages present at runtime for one of two reasons:

1. Your app expects certain programs present which it may shell out or bind to in some way.
2. Your `package.json` has Node package dependencies with native extensions, requiring additional linked libraries.

In both cases, this means your app needs additional Habitat packages installed at runtime. For this, we use the `pkg_deps` array in your Plan.

For this example, let's suppose your app resizes images to generate thumbnails by using the `mogrify` program from the [ImageMagick][] software. To add this package, update your `pkg_deps` line to the following below:

```sh
pkg_name=my_app
pkg_origin=acmecorp
pkg_version=0.1.0
 # ...
pkg_scaffolding=core/scaffolding-node
pkg_deps=(core/imagemagick)
```

###  Specifying Build Dependencies in Your Plan

Finally, your app may require additional software present in order to **build** your app that is not present by default.

For this example, let's suppose you are using a fictional "MakeSmall" project to minify css files. For this you need the tool's program "mksm", but only at build time. To add the package, update your `pkg_build_deps` line to the following below:

```sh
pkg_name=my_app
pkg_origin=acmecorp
pkg_version=0.1.0
 # ...
pkg_scaffolding=core/scaffolding-node
pkg_build_deps=(core/makesmall)
```

## Node Version

### Selecting a Version of Node.js

By default the latest version of the [`core/node`][] package will be injected into your Plan's `pkg_deps` array. To specify a non-default version of Node.js, there are three locations you can do this:

1. Use the [`engines.node`][package_json_engines] data structure in your app's `package.json`
  * you can specify the version in these formats "5.0.0", "v5.0.0", "=5.0.0", ">=5.0.0", ">5.0.0","<=5.0.0","<5.0.0"
2. Write an [`.nvmrc`][] in your app's root directory with the version of Node.js to use
3. Set the `scaffolding_node_pkg` variable in your Plan with a valid Habitat package identifier corresponding to a package with a `node` program

A set Plan variable will win over setting a version in your `package.json` and over an `.nvmrc` files (and the `package.json` will win over an `.nvmrc` file), however it is recommended to the `package.json` strategy first as this is most portable across other Node app build and deployment solutions.

#### Specifying a Node Version in Your package.json

You can use the [`engines.node`][package_json_engines] data structure in your app's `package.json` to specify a version of Node. For example:

```json
{
  "name": "my_app",
  "version": "0.1.0",
  "engines": {
    "node": "6.10.3"
  },
	...
}
```

The value of this key will be used to determine the version of the Habitat [`core/node`][] package. For example, the `package.json` above would result in `core/node/6.10.3` being injected into your Plan's `pkg_deps` array.

Currently only releases of the [`core/node`] package will work so if further customizing is required you may need to specify a version of Node.js in your Plan as described below. Additionally, only exact versions of Node.js are currently supported, so version constraint expressions such as `">= 0.10.3"` will not work.

#### Specifying a Node Version in an .nvmrc File

You can use an [`.nvmrc`][] file in your app's root directory to specify a version of Node. For example:

```
> cat .nvmrc
6.10.3
```

The value of the contents of this file will be used to determine the version of the Habitat [`core/node`][] package. For example, the `.nvmrc` file above would result in `core/node/6.10.3` being injected into your Plan's `pkg_deps` array.

If a version of Node.js is detected in your project's `package.json`, the value in an `.nvmrc` will not be used.

Currently only releases of the [`core/node`][] package will work  so if further customizing is required you may need to specify a version of Node.js in your Plan as described below. Additionally, only exact version of Node.js are currently support, so version constraint expressions or wildcard versions will not work.

#### Specifying a Node.js Version in Your Plan

You can set the `scaffolding_node_pkg` variable in your Plan to specify a version of Node.js. For example:

```sh
pkg_name=my_app
pkg_origin=acmecorp
pkg_version=0.1.0
 # ...
pkg_scaffolding=core/scaffolding-node

scaffolding_node_pkg=core/node/5.6.0
```

The value of this variable will be used to determine the Habitat package to satisfy the role of your app's Node.js implementation.

## Package Manager

This scaffolding can detect and use either [npm][] or [Yarn][] to resolve, download, and install Node package dependencies. If the detection logic is not yielding your package manager of choice, you can set this in your Plan as described below.

### Detecting a Yarn-based Project

If a `yarn.lock` file is found in your app's root directory, then [Yarn][] will be used to install dependencies. An additional Habitat package of [`core/yarn`][] will be injected into your Plan's `pkg_build_deps` array.

### Detecting an npm-based Project

If no `yarn.lock` file is found in your app's root directory, then [npm][] will be used to install dependencies. The version of `npm` will be the version that ships with the version of Node.js selected.

### Specifying the Package Manager in Your Plan

You can override the default detection logic which determines the package manager by setting the `scaffolding_pkg_manager` variable in your Plan to either `"npm"` or `"yarn"`. For example:

```sh
pkg_name=my_app
pkg_origin=acmecorp
pkg_version=0.1.0
 # ...
pkg_scaffolding=core/scaffolding-node

scaffolding_pkg_manager=yarn
```

This would force the Scaffolding code to use Yarn over npm, even if no `yarn.lock` file was present.

## Build and Post-Build scripts

This scaffolding does support running build scripts, etc. that are defined in package.json. However, due to a [known issue](https://github.com/habitat-sh/habitat/issues/1547), you will need to run the Habitat services as "root" rather than the default "hab" user.  You can do this by adding this line to your plan.sh

## Process Bins

Your app may have one or more top-level processes which map to a [running service or ephemeral task][12factor_processes]. Each of these processes will be wrapped up in a small script which sets up a suitable app environment and invokes a command. By convention the main process bin which the package's `run` hook will invoke is the `web` process.

### Default Process Bins

By default, two process bins will be generated: `web` and `sh`. The detection for `web` is described in the Specifying Process Bins section and the `sh` process is described immediately below.

#### Default Shell Process Bin

A bare-bones shell process bin will be generated for all apps. Due to the process bin wrapping logic, this shell session will have its `$PATH` correctly set, all appropriate environment variables set and will be running in the app's installed root path.

* `sh`: `sh`

### Specifying Process Bins

By default, the scaffolding will determine some of the process bins to be created. To customize your app's process bins, there are three locations you can do this:

1. Use a [`Procfile`][] in your app's root directory
2. Use the [`scripts.start`][package_json_scripts] entry in `package.json`
3. Setup the `scaffolding_process_bins` hash in your Plan

For each process bin name a set Plan hash entry will win over a `Procfile` entry and over a `package.json` entry (and `Profile` will win over `package.json`), however it is recommended to use the `Procfile` strategy first as this is portable across other Node.js app build and deployment solutions.

#### Specifying Process Bins in a Procfile

You can override default process bins or even add new ones by including a [`Procfile`][] in your app's root directory. By convention, the `web` entry will be invoked by your package's `run` hook and will therefore be considered your package's main service. Additional entries will generate additional process bins in your package. For example, let's take an app whose package name is set to `"my_app"` (by setting `pkg_name="my_app"` in your `plan.sh`) and a Procfile containing:

```
web: node server.js -p $PORT
release: node scripts/migrate_db.js
```

The Scaffolding will produce `my_app-web` and `my_app-release` process bins in the resulting package under `$pkg_prefix/bin` which will be in the package's `$PATH` environment.

#### Specifying Process Bins in package.json

You can override the default `web` process bin in your app's `package.json` by setting the [`scripts.start`][package_json_scripts] section like so:

```json
{
  "name": "my_app",
  "version": "0.1.0",
  "scripts": {
    "start": "node app.js",
    "test": "nom run test-unit"
  },
	...
}
```

The Scaffolding will produce a `my_app-web` process bin but not a `my_app-test` process bin. Only the a script entry called `"start"` will be detected and used.

Note that a `web` entry in a `Procfile` (as described above) will win over any setting in `package.json`.

#### Specifying Process Bins in Your Plan

You can override default process bins or even add new ones by creating the `scaffolding_process_bins` hash in your Plan and setting one or more entries. By convention, the `web` entry will be invoked by your package's `run` hook and will therefore be considered your package's main service. Additional entries will generate addition process bins in your package. For example, let's take an app whose package name is set to `"my_app`" (by setting `pkg_name="my_app"` in your `plan.sh`):

```sh
pkg_name=my_app
pkg_origin=acmecorp
pkg_version=0.1.0
 # ...
pkg_scaffolding=core/scaffolding-node

 # Declare the associative array (hash) in bash
declare -A scaffolding_process_bins
 # Override the default web process
scaffolding_process_bins[web]='node server.js -p ${PORT}'
 # Add an addition process bin called release
scaffolding_process_bins[release]='node scripts/migrate_db.js'
```

The scaffolding will produce `my_app-web` and `my_app-release` process bins in the resulting package under `$pkg_prefix/bin` which will be in the package's `$PATH` environment.

**Note:** future work may make the Bash associative array creation an easier task.

## App Environment Variables

In order to run correctly, your app may require several environment variables set up which it would [consume on start][12factor_config]. At build time, a Plan hash called `scaffolding_env` can be created to set up more app environment variables. The Scaffolding writes all of the app's environment variables to a config template which the Supervisor will compute and render at runtime. Each process bin will source the runtime-computed version of this config file before running itself meaning that all process bins have access to these variables.

### Default App Environment Variables

The following default app environment variables are created:

* `PORT`: `{{cfg.app.port}}`

The values of these environment variables use handlebars templating, meaning that their values will be computed and rendered by the Supervisor at runtime.

### Specifying App Environment Variables

To further customize your app's environment variables, you would setup the `scaffolding_env` hash in your Plan.

For each environment variable name, a set Plan hash entry will win over a default entry.

#### Specifying App Environment Variables in Your Plan

You can override default app environment variables or even add new ones by creating the `scaffolding_env` hash in your Plan and setting one or more entries. Let's see an example:

```sh
pkg_name=my_app
pkg_origin=acmecorp
pkg_version=0.1.0
 # ...
pkg_scaffolding=core/scaffolding-node

 # Declare the associative array (hash) in bash
declare -A scaffolding_env
 # Add an addition variable which is hardcoded at build time
scaffolding_env[MY_PKG_VERSION]="$pkg_version/$pkg_release"
 # Add addition variables which is uses runtime config values
scaffolding_env[AWS_DEFAULT_REGION]="{{cfg.aws_default_region}}"
```

Note that in the above example we can choose to consume runtime configuration by writing the value with handlebars templating. This will be computed and rendered by the Supervisor at runtime and provided to your app. However, if the value is not "tunable" (i.e. would you change this setting in different environments or in production?), you can immutably set the variable by simply not using any handlebars templating syntax.

## Config Settings

To make your app's package useful in more [environments and contexts][12factor_build], your package will contain config settings. These settings will be computed at runtime and can be used to dynamically generate app config files, environment variable settings, etc.

### Default Config Settings

The following config settings will be created for each app:

* `app.port`: Used to set the listen port number for your app when it runs. It is consumed to set the `$PORT` environment variable and to set the value of the exported `port` configuration. This enforces the [port binding][12factor_port] contract. Note that your app must check for this environment variable for this contract to be fulfilled.

### Specifying Config Settings

The Scaffolding creates some default app config settings, but to further customize your app's config settings, you would create a `default.toml` file with your Plan.

#### Specifying Config Settings in default.toml

You can add more config settings by creating a `default.toml` file in the same directory containing your `plan.sh` file. Either directory structure is supported:

A Plan in a `habitat/` subdirectory:

```
.
├── package.json
└── habitat
    ├── default.toml
    └── plan.sh
```

A Plan in the same directory as the `package.json`:

```
.
├── package.json
├── default.toml
└── plan.sh
```

## Service Bindings

[Service bindings][bindings] are a powerful way to declare your app's [service dependencies][12factor_backing_services] which the Supervisor will honor when running your app.

### Default Service Bindings

Currently, no service bindings are generated by default.

### Specifying Service Bindings in Your Plan

You can add service bindings in your Plan by setting an entry in the `pkg_binds` hash. Let's see an example of declaring a **required** binding on an [Elasticsearch][] service group:

```sh
pkg_name=my_app
pkg_origin=acmecorp
pkg_version=0.1.0
 # ...
pkg_scaffolding=core/scaffolding-node

 # We require both the HTTP and transport ports from this
 # service binding
pkg_binds[elasticsearch]="http-port transport-port"
```

This allows your app to [dynamically bind][12factor_backing_services] to the desired Elasticsearch service group at runtime. For example, if your app's target Elasticsearch service group was `"es.my_app"`, then you would start it with:

```sh
hab start acmecorp/my_app --bind elasticsearch:es.my_app
```

## App Type Detection

Other Scaffolding packages may offer framework-specific app type detection in order to make further default behavior easier. However, this is currently no app type detection for this Scaffolding package.


[12factor_backing_services]: https://12factor.net/https://12factor.net/backing-services
[12factor_build]: https://12factor.net/build-release-run
[12factor_config]: https://12factor.net/config
[12factor_dependencies]: https://12factor.net/dependencies
[12factor_port]: https://12factor.net/port-binding
[12factor_processes]: https://12factor.net/processes
[bindings]: https://www.habitat.sh/docs/run-packages-binding/
[`core/busybox-static`]: https://app.habitat.sh/#/pkgs/core/busybox-static
[`core/node`]: https://app.habitat.sh/#/pkgs/core/node
[`core/yarn`]: https://app.habitat.sh/#/pkgs/core/yarn
[Elasticsearch]: https://www.elastic.co/products/elasticsearch
[habitat]: https://www.habitat.sh/
[npm]: https://www.npmjs.com/
[`.nvmrc`]: https://github.com/creationix/nvm#nvmrc
[`package.json`]: https://docs.npmjs.com/files/package.json
[package_json_engines]: https://docs.npmjs.com/files/package.json#engines
[package_json_scripts]: https://docs.npmjs.com/files/package.json#scripts
[`Procfile`]: https://devcenter.heroku.com/articles/procfile
[shebangs]: https://en.wikipedia.org/wiki/Shebang_(Unix)
[try_hab]: https://www.habitat.sh/try/
[Yarn]: https://yarnpkg.com/en/
