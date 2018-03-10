# rkt

This package provides the rkt binary

## Usage

Typically this is a runtime dependency that can be added to your

```
plan.sh:

    pkg_deps=(core/rkt)
```

Or in the case of simply needed to execute the binary you can do:

`hab pkg exec core/rkt rkt`
