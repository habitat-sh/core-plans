# Shebang Line Conventions

## Summary
[summary]: #summary

There are a wide variety of patterns being used in the "shebang" lines of lifecycle hooks throughout core plans, but not much guidance on what the "best" way to set up hooks is.

## Motivation
[motivation]: #motivation

Providing guidance on how best to set up the "shebang" lines of hooks will allow newcomers to more quickly get a working Habitat package set up. It will also reduce ambiguity in hook authoring, and increase the safety of hook execution.

## Guide-level explanation
[guide-level-explanation]: #guide-level-explanation

Lifecycle hooks are the templatable scripts that a Habitat plan author may include in their plans (in the `habitat/hooks` directory) that the Supervisor uses to run a Habitat service. They can also be used to customize various behaviors around the overall lifecycle of the service (for instance, pre-startup initialization can occur in an `init` hook, a health check can be defined in the `health_check` hook, and so on).

Since these are scripts, and not binaries (which would, among other things, defeat the purpose of being templatable), they must define an interpreter to run them in the first line of the script, commonly called the "shebang line", named thus after the `#!` character pair that begins the line.

The Habitat Supervisor provides all services with access to the Bourne Shell `/bin/sh` interpreter via [Busybox](https://busybox.net/about.html). As a result, any lifecycle hook that starts with the shebang line `#!/bin/sh` is guaranteed to work.

Busybox also can be invoked as the "Bourne Again" Shell (Bash) `/bin/bash`, and you will often see plans with a shebang line of `#!/bin/bash`. This will work, but can be dangerously misleading. Busybox does not support all features of Bash; if you truly need actual Bash features and use `#!/bin/bash`, your hook will fail, and it will be difficult to understand why if you're not aware of this Busybox behavior.

The alternative is to take advantage of our `pkgPathFor` templating helper. If you genuinely need to use Bash, the safe (and more flexible!) way to proceed is to use a templated shebang line:

    #!{{pkgPathFor "core/bash"}}/bin/bash

This requires the addition of `core/bash` to the package's runtime dependencies (`pkg_deps` in the Habitat plan file). This does require a small amount of extra work on the author's part, but does make explicit the fact that there actually is a runtime dependency on Bash, and ultimately gives the author more control over the interpreter being used.

This technique also makes it easy to see that you can use any interpreter that you like. For example, if you wanted to write hooks in Ruby, you'd use `core/ruby` in that shebang line (and add `core/ruby` to your runtime dependencies list).

This can be summed up as "Feel free to use `#!/bin/sh` explicitly; if you need any other interpreter, declare a runtime dependency and use `pkgPathFor`".

## Reference-level explanation
[reference-level-explanation]: #reference-level-explanation

To implement this, we would clearly document this approach on https://habitat.sh. Additionally, we would need to ensure that all existing core plans adhere to the proposed pattern.

## Drawbacks
[drawbacks]: #drawbacks

None.

## Rationale and alternatives
[alternatives]: #alternatives

This is the safest way to ensure that the appropriate interpreter is being used for lifecycle hooks.

## Unresolved questions
[unresolved]: #unresolved-questions

This RFC is chiefly a question of documentation, so there are no unresolved questions.
