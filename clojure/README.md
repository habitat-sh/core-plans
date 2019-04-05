# clojure

Clojure is a robust, practical, and fast programming language with a set of useful features that together form a simple, coherent, and powerful tool.

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

Service package

## Usage

Install:
```
hab pkg install core/clojure
```

Execute:
```
hab pkg exec core/clojure clj -h
```

Add to a plan:
```
pkg_deps=(
  core/clojure
)
```

Start an nrepl:
```
hab svc load core/clojure
hab svc start core/clojure
```

Validate connectivity to nrepl service:
```
hab pkg exec core/clojure clj -Sdeps '{:deps {nrepl {:mvn/version "0.6.0"}}}' \
  -m nrepl.cmdline --connect --host localhost --port 31337
```

rebel-readline REPL from an exported docker container:
```
docker run -it --rm --entrypoint hab core/clojure pkg exec core/clojure \
  clojure -Sdeps '{:deps {com.bhauman/rebel-readline {:mvn/version "0.1.4"}}}' \
  -m rebel-readline.main
```
