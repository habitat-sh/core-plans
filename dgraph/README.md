# Dgraph

Dgraph is a distributed, transactiona, graph database written in go

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

Binary package

## Usage

Usage instructions for Dgraph specifically can be found in their [documentation](https://docs.dgraph.io/get-started/). This package provides the binary only, and can be used as follows:

```
hab pkg install --binlink core/dgraph
dgraph help
```

Alternatively, it can be run without binlinking:

```
hab pkg install core/dgraph
hab pkg exec core/dgraph dgraph help
```
