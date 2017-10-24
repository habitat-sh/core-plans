# Use Graddle Scaffolding for Your App

## Habitat Quick Setup

To install and setup Habitat on your system for development, follow the instructions on the [Set up your environment][hab_setup] page from the [Getting Started with Habitat][tutorial] tutorial.

This should leave you with a `hab` program on your system with a generated origin key for signing built packages.

## Create a Plan which uses the Graddle Scaffolding

Now, navigate to the directory at the root of your app and generate a Plan with::

```sh
hab plan init --scaffolding core/scaffolding-gradle
```

Now, why not commit the Plan into your project's codebase? If using Git:

```sh
git add habitat
git commit
```

## Build Your App Package

All Habitat packages are built in an isolated build environment called a Studio. There are 2 main ways to build your package (both of which use the **exact** same process and code under the hood):

1. `hab studio enter`
2. `hab pkg build`

### Build Your App Package Interactively with Studio Enter

When you are initially getting your app to build with all of its dependencies, configuration, etc., it can be beneficial to work with a quicker feedback loop. To do this, you can interactively enter a Studio by changing directory to the root of your app and running:

```sh
hab studio enter
```

You will be sitting a shell prompt in the `/src` directory where you app's code is mounted (take a look by running `ls`). To build your app, simply run:

```sh
build
```

You can try to start any successfully built package directly in the Studio by running `hab start MY_ORIGIN/MY_APP` (note that you may require addition options such as service bindings depending on your app's needs).

Any successfully created Habitat packages will be copied into a `./results/` directory which you can access inside or outside the Studio. To exit, simply run `exit`.

For a more detailed walkthrough, try the [Getting Started with Habitat][tutorial] tutorial.

### Build Your App Package Cleanly and Declaratively with Pkg Build

Working on package interactively is nice, but if you want clean, "from-nothing" builds that will also work on CI systems and in CD pipelines? That is what `hab pkg build` is for. It performs the exact same build with a big difference: the Studio is destroyed and re-created from scratch each time you run `hab pkg build`. This ensures that no previous old software will influence the build of a package.

To build a package this way, change directory to the root of your app and run:

```sh
hab pkg build
```

[hab_setup]: https://www.habitat.sh/tutorials/getting-started/mac/setup-environment/
[tutorial]: https://www.habitat.sh/tutorials/
