# Deprecating Packages

## Summary
[summary]: #summary

When a piece of software that is packaged with a Habitat plan is no longer supported by the manufacturer of that software, we need a process to deprecate that plan.

Deprecating a plan does NOT involve removing it from builder. Rather, we must indicate to users that the plan will no longer be updated by the Habitat team except in cases of security vulnerabilities.

This RFC proposes a process to:
* Deprecate a plan
* Communicate that deprecation notice to all users
* Establish a process for handling emergency updates - like serious regression bugs

## Motivation
[motivation]: #motivation

We need a way to indicate that a plan is deprecated without removing the plan itself from Builder (as this could potentially cause breakages for anyone who is still dependent on it), and to redirect users to updated plans that are still supported by the manufacturer.

## Guide-level explanation
[guide-level-explanation]: #guide-level-explanation

We currently have plans that package software which the author/manufacturer has declared EOL or otherwise no longer updated. This includes, but may not be limited to:
* [core/ruby22](https://github.com/habitat-sh/core-plans/tree/master/ruby22) (The Ruby team has indicated [here](https://www.ruby-lang.org/en/news/2018/03/28/ruby-2-2-10-released/) that Ruby 2.2.x security maintenance ended in March 2018. Additionally, we discovered during the latest base plans refresh that Ruby 2.2.x does not work with newer versions of glibc and gcc. While we can pin it to older versions of glibc and gcc, this will introduce potential dependency issues when used with software that was created with newer versions of those base packages)
* [core/jre9](https://github.com/habitat-sh/core-plans/tree/master/jre9)(Oracle has indicated [here](http://www.oracle.com/technetwork/java/javase/downloads/jre9-downloads-3848532.html) that Java SE 9 has reached end of support and users should upgrade to Java SE 10. Additionally, Oracle's download links to JRE 9 and JDK 9 have been removed. It should be noted that Oracle DOES still support JRE 8 and JDK 8.)
* [core/jdk9](https://github.com/habitat-sh/core-plans/blob/master/jdk9/plan.sh)(see explanation for core/jre9)

When we become aware that a piece of software we package in core plans has been EOL'd or the author/manufacturer otherwise stops supporting it, we will:

1. Delist the package in builder by setting it to "private" (that will make it invisible to anyone outside of the core org, as mentioned [in this issue](https://github.com/habitat-sh/builder/issues/18)

2. Move the plan directory into `.deprecated` at the root of the repository

3. Add some sort of indication to the core plan's view page in Builder (remember, even if it is set to private and not viewable publicly, it will still be viewable to members of the core origin) (this will likely require some feature work)

4. Remove the plan from the [.bldr.toml](https://github.com/habitat-sh/core-plans/blob/master/.bldr.toml) file in the core plans repo.

5. Disconnect the plan from Builder

We must follow this same process in the case of a plan that
* is incorrectly scoped into core plans - i.e. a test package
* or has been moved out to a different origin - i.e. builder packages were removed from the core origin earlier this year

## Reference-level explanation
[reference-level-explanation]: #reference-level-explanation

See the Guide-level explanation

## Drawbacks
[drawbacks]: #drawbacks

This would necessitate users changing their own behavior and the behavior of their software.

It will also necessitate some feature work on the part of Builder - we would need a field of something to that effect indicating when a plan is deprecated.

## Rationale and alternatives
[alternatives]: #alternatives

Here are few alternatives:

* Removing unsupported software completely from Builder - this would break anyone who depends on the software and cannot upgrade at this time. If there is at least one successful build of the software, we should preserve it on Builder for those who must use it, while indicating that it is deprecated and users should upgrade as soon as they can. Setting the plan as "private" makes the plan unsearchable, but still downloadable by those who are already using it.
* Keep a cache of downloaded software packages - this would seem to get us around download links being removed (which is what happened with jre9/jdk9), but would necessitate a lot more storage and feature work on the part of Builder. Even if we did this, it would not get us around the fact that the software is no longer supported by the author/manufacturer.

## Unresolved questions
[unresolved]: #unresolved-questions
