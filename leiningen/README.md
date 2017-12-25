# Habitat package: leiningen

## Description

This plan provides the lein CLI package. `lein` is a tool used to manage Clojure(Script) projects.

## Usage

Package execution:
```
hab pkg exec core/lein lein -h

Leiningen is a tool for working with Clojure projects.

Several tasks are available:
change              Rewrite project.clj by applying a function.
check               Check syntax and warn on reflection.
classpath           Print the classpath of the current project.
clean               Remove all files from project's target-path.
compile             Compile Clojure source into .class files.
deploy              Build and deploy jar to remote repository.
deps                Download all dependencies.
do                  Higher-order task to perform other tasks in succession.
help                Display a list of tasks or help for a given task.
install             Install the current project to the local repository.
jar                 Package up all the project's files into a jar file.
javac               Compile Java source files.
new                 Generate project scaffolding based on a template.
plugin              DEPRECATED. Please use the :user profile instead.
pom                 Write a pom.xml file to disk for Maven interoperability.
release             Perform :release-tasks.
repl                Start a repl session either with the current project or standalone.
retest              Run only the test namespaces which failed last time around.
run                 Run a -main function with optional command-line arguments.
search              Search Central and Clojars for published artifacts.
show-profiles       List all available profiles or display one if given an argument.
test                Run the project's tests.
trampoline          Run a task without nesting the project's JVM inside Leiningen's.
uberjar             Package up the project files and dependencies into a jar file.
update-in           Perform arbitrary transformations on your project map.
upgrade             Upgrade Leiningen to specified version or latest stable.
vcs                 Interact with the version control system.
version             Print version for Leiningen and the current JVM.
with-profile        Apply the given task with the profile(s) specified.

Run `lein help $TASK` for details.

Global Options:
  -o             Run a task offline.
  -U             Run a task after forcing update of snapshots.
  -h, --help     Print this help or help for a specific task.
  -v, --version  Print Leiningen's version.

These aliases are available:
downgrade, expands to upgrade

See also: readme, faq, tutorial, news, sample, profiles, deploying, gpg,
mixed-source, templates, and copying.
```

Your `plan.sh` dependencies will look similar to this:

```
pkg_build_deps=(
  core/leiningen
)
```

Build your application with something like:
```
do_build() {
  lein with-profile prod uberjar
}
```
