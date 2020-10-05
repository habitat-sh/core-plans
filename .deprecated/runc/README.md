# Runc
The `runc` plan _only_ provides users access to the standalone [runc binary](https://github.com/opencontainers/runc). Runc unlike dockerd does not include a running daemon. Instead, it is meant to be executed as a binary or consumed as a library to manage OCI bundle containers.

## Examples
To use the `runc` binary you can follow two different patterns. You can either binlink the package to the underlying system, or you can use the `hab` binary to execute the `img` binary

```
$ hab pkg exec core/runc runc --help
```
Or
```
$ hab pkg binlink core/runc runc
$ runc --help
```
