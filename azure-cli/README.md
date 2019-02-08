# Azure CLI

The [Azure command-line interface (CLI)](https://docs.microsoft.com/en-us/cli/azure/?view=azure-cli-latest) is Microsoft's cross-platform command-line experience for managing Azure resources. Use it in your browser with Azure Cloud Shell, or install it on macOS, Linux, or Windows and run it from the command line.

## Maintainers

The Habitat Maintainers humans@habitat.sh

## Type of Package

[binary wrapper package](https://www.habitat.sh/docs/best-practices/#binary-wrapper-packages)

## Usage

```bash
hab pkg install core/azure-cli
hab pkg binlink core/azure-cli az   # do not try to binlink all the python deps

az --version
```
