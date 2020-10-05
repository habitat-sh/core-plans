# Go Scaffolding
The go scaffolding can be use to package application from a remote repository or
from local source. It has two available modes:
* GOPATH Mode
* Module Mode

## GOPATH Mode
In this mode, the Go Scaffolding will automatically configure
the `GOPATH` environment variable and directory structure.

### From a remote repository
By adding the `pkg_source` variable you will be telling the go scaffolding to
package the application from a remote repository.

An example of a `plan.sh`:
```
pkg_name=hello-go
pkg_origin=afiune
pkg_version="0.1.0"
pkg_scaffolding=core/scaffolding-go
pkg_source="http://github.com/afiune/hello-go"
```

### From local source
If you are building an application from local source, you have to avoid defining
the `pkg_source` variable, this way the go scaffolding will prapare a Go Workspace
to build and package your local application.

Optionally, you can define the `scaffolding_go_base_path` if you are planning to
keep your code in a source repository somewhere.

An example of a `plan.sh`:
```
pkg_name=hello-go
pkg_origin=afiune
pkg_version="0.1.0"
pkg_scaffolding=core/scaffolding-go
scaffolding_go_base_path=github.com/afiune
```

## Go Module Mode
This mode allows you to build your go application outside a Go
Workspace, it requires the existence of the [`go.mod` file.](https://golang.org/cmd/go/#hdr-The_go_mod_file)

An example of a `plan.sh`:
```
pkg_name=hello-go
pkg_origin=afiune
pkg_version="0.1.0"
pkg_scaffolding=core/scaffolding-go
scaffolding_go_module=on
```

## Getting Started with Scaffolding
See https://www.habitat.sh/docs/concepts-scaffolding/ to learn how to get started
with Scaffolding.

## Variables
| Variable | Type | Value | Default |
| -------- | ---- | ----- | ------- |
|`scaffolding_go_gopath`| String | _(Optional)_ Value for `GOPATH` | `$SRC_PATH` |
|`scaffolding_go_base_path`| String | _(Optional)_  The base path that will be used in the import path construction. Eg: `github.com/myorg`| `localhost/user`|
|`scaffolding_go_build_deps`| Array  | _(Optional)_ Array of URLs to `go get` | Undefined |
|`scaffolding_go_module`| String  | _(Optional)_  Enable or disable go module support: `off` or `on`| `auto` |

## Callbacks
### Scaffolding
#### scaffolding_go_get
Executes `go get` against the `pkg_source` and the contents of the `scaffolding_go_build_deps` array to install any additional dependencies which would not otherwise be resolved.
#### scaffolding_go_before
Initialize the Go Workspace package path only if no `pkg_source` was specified.
#### scaffolding_go_download
Calls [scaffolding_go_get](#scaffolding_go_get) by default. This callback adds a callback you can use to override download behaviors.
#### scaffolding_go_clean
Performs `go clean -r -i` to recursively clean build and build deps.
#### scaffolding_go_build
This will attempt to use a `Makefile` if one is found and assumes there is a default make target. If no `Makefile` is found, `go build` is executed against the project.
#### scaffolding_go_install
Installs the application and runtime deps into `"${pkg_prefix}/${bin}"`

### Default Overrides
The following default callbacks have overrides:
* `do_default_before` - Calls [scaffolding_go_before](#scaffolding_go_before)
* `do_default_download` - Calls [scaffolding_go_download](#scaffolding_go_download)
* `do_default_clean` - Calls [scaffolding_go_clean](#scaffolding_go_clean)
* `do_default_verify` - NOP -- Returns 0
* `do_default_unpack` - NOP -- Returns 0
* `do_default_build`- Calls [scaffolding_go_build](#scaffolding_go_build)
* `do_default_install` Calls [scaffolding_go_install](#scaffolding_go_install)
