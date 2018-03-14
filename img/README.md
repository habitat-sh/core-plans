# Img
The `img` plan _only_ provides users access to the standalone [img binary](https://github.com/genuinetools/img). IMG unlike docker does not include a running daemon. Instead, it is meant to be executed as a binary for the creation of unprivilied OCI and Docker container images

## Examples
To use the `img` binary you can follow two different patterns. You can either binlink the package to the underlying system, or you can use the `hab` binary to execute the `img` binary

```
$ hab pkg exec core/img img --help
```
Or
```
$ hab pkg binlink core/img img
$ img --help
```
