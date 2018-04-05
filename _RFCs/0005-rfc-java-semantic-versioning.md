- Change Name: java-semantic-versioning
- Start Date: 2018-03-29
- RFC PR: (leave this empty)
- Core-Plans Issue: (leave this empty)

# Summary
[summary]: #summary

This RFC proposes that supported java versions are adapted to semantic versioning `M.m.p` as the rest of habitat packages

# Motivation
[motivation]: #motivation

Habitat has been designed to work with semantic versions of the format `M.m.p`, and package newness is based on this format. Currently, new versions of the java packages have to be pinned explicitely or else, you might never get those as dependency since, for example, 8u92 is found newer than 8u151.

# Guide-level explanation
[guide-level-explanation]: #guide-level-explanation

Java packages (jre and jdk) with version <= 8 will now adapt the official java version to habitat's package system:

- core/jre8/8u151 will become core/jre8/8.151.0
- core/jdk8/8u92 will become core/jdk8/8.92.0

Generally, versions `<M>u<m>` will be renamed `<M>.<m>.0`

# Reference-level explanation
[reference-level-explanation]: #reference-level-explanation

The package versions change should happen only for the latest of jre8 and jdk8. Indeed, Java 7 is not supported anymore by Oracle.

Note that version 8.151.0 is considered more recent than 8u151 by habitat, which implies that this RFC shouldn't have any undesired side-effects.

# Drawbacks
[drawbacks]: #drawbacks

Doing so might confuse people used to java versioning scheme. Although, note that starting from java 9, the versions will look like what this proposal wants to implement.

# Rationale and alternatives
[alternatives]: #alternatives

Alternatives all point to changing how habitat represents package versions. Also, it is not clear how it should change it. Also, it seems that java is the only package presenting this issue, so changing habitat for it seems unlikely.

# Unresolved questions
[unresolved]: #unresolved-questions

None
