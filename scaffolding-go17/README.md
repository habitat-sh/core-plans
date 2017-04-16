# Go Scaffolding
The go scaffolding automatically configures the $GOPATH environment variable, downloads the code via `go get`, builds, and packages you application into a habitat package.

## Getting Started with Scaffolding
See https://www.habitat.sh/docs/concepts-scaffolding/ to learn how to get started with Scaffolding.

## Variables
| Variable | Type | Value | Default |
| -------- | ---- | ----- | ------- |
|`scaffolding_go_gopath`| String |_(Optional)_ Value for `GOPATH`|`"$HAB_CACHE_SRC_PATH/$pkg_dirname"`|
|`scaffolding_go_src_path`| String | _(Optional)_ URL to Source in `go get` format. Eg: `github.com/myorg/myapp`| `$GOPATH/src/$pkg_src` ($pkg_src is sanitized to go get format) |
|`scaffolding_go_build_deps`| Array  | _(Optional)_ Array of URLs to `go get` | Undefined |

## Callbacks
### Scaffolding
#### scaffolding_go_get
Executes `go get` against the `pkg_source` and the contents of the `scaffolding_go_build_deps` array to install any additional dependencies which would not otherwise be resolved.
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
* `do_default_download`Calls [scaffolding_go_download](#scaffolding_go_download)
* `do_default_clean` - Calls [scaffolding_go_clean](#scaffolding_go_clean)
* `do_default_verify` - NOP -- Returns 0
* `do_default_unpack` - NOP -- Returns 0
* `do_default_build`- Calls [scaffolding_go_build](#scaffolding_go_build)
* `do_default_install` Calls [scaffolding_go_install](#scaffolding_go_install)
