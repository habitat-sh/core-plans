# graphviz

Graphviz - Graph Visualization Software

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

Binary package

## Usage

Install the pacakge

```
hab pkg install --binlink core/graphviz
```

You can now use graphviz binaries to render your files:

```
neato -Tpng -o mygraph.png mygraph.dot
dot -Tpng -o mygraph.png mygraph.dot
```
