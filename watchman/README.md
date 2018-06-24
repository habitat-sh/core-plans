# watchman

Watchman exists to watch files and record when they change. It can also trigger actions (such as rebuilding assets) when matching files change.

* [Website](https://facebook.github.io/watchman/)
* [GitHub](https://github.com/facebook/watchman)
* [Documentation: Command Line](https://facebook.github.io/watchman/docs/cli-options.html)

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Usage

This package exports three commands:

* [`watchman`](https://facebook.github.io/watchman/docs/cli-options.html): contains both the client and the server components of the watchman service.
* [`watchman-make`](https://facebook.github.io/watchman/docs/watchman-make.html): a convenience tool to help automatically invoke a build tool or script in response to files changing. It is useful to automate building assets or running tests as you save files during development.
* [`watchman-wait`](https://facebook.github.io/watchman/docs/watchman-wait.html): waits for changes to files. It uses the watchman service to efficiently and recursively watch your specified list of paths.

The `watchman` client/server command is a compiled binary that can be run via `hab pkg exec` or binlinked and run directly.

`watchman-make` and `watchman-wait` are python scripts that rely on habitat-provided runtime environment variables, they must be run via `hab pkg exec` for best results.

## Examples

### Watch the current directory for changes indefinitely

```bash
hab pkg exec jarvus/watchman watchman-wait -m 0 .
```
