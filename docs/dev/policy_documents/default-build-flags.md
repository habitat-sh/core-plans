# Summary
[summary]: #summary

Habitat's core plans should provide a reliable base system on which
Habitat users can build applications. To meet this goal, core-plans
software written in the C programming language should use compiler and
linker flags that provide a level of performance and security at least
as good as other Linux distributions.

# Motivation
[motivation]: #motivation

## Performance

Consider our current build of `bc` attempting to compute Pi to 4096
digits:

```
> time /hab/pkgs/core/bc/1.07.1/20190115012704/bin/bc -l <<< "scale=4096;4*a(1)"
...SNIP...
real	0m28.250s
user	0m28.229s
sys	0m0.016s
```

This same command recompiled with -O3:

```
> time /hab/pkgs/ssd/bc/1.07.1/20200427105511/bin/bc -l <<< "scale=4096;4*a(1)"
...SNIP...
real	0m10.950s
user	0m10.960s
sys	0m0.004s

```

This example was purposefully constructed to show a large speedup from
optimization. However, I expect that the majority of software written
in C in core-plans would benefit from ensuring we create optimized
builds.

Some software in core-plans already builds with optimizations, either
because their build scripts add the required flags or because the plan
we created does.

However, it is common practice for distributions to set a default
level of optimization for all builds. This is in part because some
security features are also tied to having optimization enabled:

For example,

- [Omnibus: -02](https://github.com/chef/omnibus/blob/0baf021d62d9e61687e2d7efbac865a9640027c2/lib/omnibus/software.rb#L753)
- [NixPkgs: -02 enabled when hardening is enabled (which is the default)](https://github.com/NixOS/nixpkgs/blob/4707dc6454904bee0bacd3a53829bcc76b4f0667/pkgs/build-support/cc-wrapper/add-hardening.sh#L41)
- [Debian: -02](https://manpages.debian.org/testing/dpkg-dev/dpkg-buildflags.1.en.html)

## Security

Compilers have implemented a broad range of security
mitigations. These include things like stack protectors that help
prevent security bugs because of buffer overflows, automatic rewriting
of unsafe libc functions into safer variants, and position independent
executables to support address space layout randomization which makes
various exploits harder to write.

These mitigations are enabled via compiler and linker flags.  Most
distributions have made such flags their default:

https://fedoraproject.org/wiki/Changes/Harden_All_Packages
https://wiki.debian.org/HardeningWalkthrough
https://nixos.org/nixpkgs/manual/#sec-hardening-in-nixpkgs
https://wiki.gentoo.org/wiki/Project:Hardened

## Why a Policy?

Multiple users have attempted to make progress on this issue in the
past. For example,

- https://github.com/habitat-sh/core-plans/issues/587
- https://github.com/habitat-sh/core-plans/pull/881

A set policy is likely needed because:

- The effort to fix this across all builds is non-trivial

- Some portion of the effort will need to be an acceptance criteria
  for future core-plan refreshes.

- Eventually `hab-plan-build` integration will be required.

# Guide-level explanation
[guide-level-explanation]: #guide-level-explanation

In the reference-level explanation, a multi-phase implementation
approach is recommended. This section only provides an explanation for
the first phase, as the details of the later phases are contingent on
what we learn from phase 1.

core-plans maintainers and contributors would need to apply hardening
flags to their plans. This would be done by sourcing a shared script
in their plan:

    . includes/hardening-defaults.sh

A test will be added to the continuous integration system that checks
the produced libraries and binaries for indicators that the hardening
has been applied. These tests will only run for plans that have opted
in to the default flags.

Changes to the default set of flags applied to core-plans does not
need to go through an RFC process and can rather go through the normal
pull-request process to update the above mentioned script.

# Reference-level explanation
[reference-level-explanation]: #reference-level-explanation

A mutli-phased approach will help us quickly improve the quality of
core-plans while working on a feature robust enough for inclusion in
hab-plan-build.

## Phase 1: Tooling and Manual Application of Easy-to-apply-flags

Experience shows that the following flags can be applied to a broad
range of software without substantial problems:

- `-02`: Default optimization level used by most distributions. Does
  not introduce the danger typically associated with `-03`.

- `--stack-protector-strong`: Stack protection that tries to balance
  attack mitigation with performance.

- `-D_FORTIFY_SOURCE=2`: A glibc macro that adds checks to commonly
  misused functions in order to prevent buffe oveflow errors.

These would be applied on a per-plan basis via the sourcing of a bash
script that sets `CFLAGS`, `LDFLAGS`, `CPPFLAGS`, and `CXXFLAGS` as
required.

We will also develop tooling to help us ensure that the flags have
actually made their way into the build and had the intended affect on
the created executables and libraries.

## Phase 2: Harder to Apply Flags

The next phase would be to investigate and apply flags that often
require deeper integration with the compiler and linker toolchains.

Many distributions have a wrapper for their compiler that is
responsible for correctly applying these flags since some of the flags
are mutually exclusive and are only applicable to certain kinds of
output (executable vs shared object file for example).

- `-Wl,-z,relro`: Sets relocation-related memory sections to read-only
  before execution is turned over, preventing most overwriting of the
  Global Offset Table.

- `-Wl,-z,now`: Resolve all symbols immediately when loading the
  program. This allows the entire Global Offset Table to be marked as
  read-only.

- `-fPIE`, `-pie`, `-fPIC`: Create position independent executables
  and shared object files. This is typically done via a wrapper for
  `cc`.

## Phase 3: hab-plan-build support

The previous 2 phases should provide us with a lot of experience
applying these flags to a broad set of software. Adding this to
hab-plan-build would help users outside of core-plans and simplify the
customization needed inside the core-plans repository.

- Add the new defaults to hab-plan-build
- Design and implement a feature that allows users to opt-out of flags
  that would break their builds.

# Drawbacks
[drawbacks]: #drawbacks

- As with all things, time spent applying these flags is time diverted
  from other improvements to core-plans.

# Rationale and alternatives
[alternatives]: #alternatives

## Alternative: Only Apply -02

If we only target `-02` then we can likely fairly rapidly build that
into hab-plan-build and apply it to all plans inside
core-plans. Further, we are likely reducing the impact of `-02` by
also including security-related flags in this plan. We may consider
restricting this RFC to only the security-related flags and
immediately apply `-02` to all builds.

# Unresolved questions
[unresolved]: #unresolved-questions
