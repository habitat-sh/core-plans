- Change Name: standardize_tracking_major_package_versions
- Start Date: 2018-03-27
- RFC PR: (leave this empty)
- Core-Plans Issue: (leave this empty)

# Summary
[summary]: #summary

Generic package names (ones which do not specify a version in the name - i.e. "core/docker") must always point to the latest **stable** version of the software.  They must not track edge versions of the software.

# Motivation
[motivation]: #motivation

We currently have several generic packages (i.e. "core/docker") that track the "current" version of the packaged software (as of today, core/docker points to Docker 17). When a new major version of the package becomes available, we move the old version (i.e. Docker 16) to a separate plan to track the old version (i.e. "core/docker16") while the "generic" package ("core/docker") will be updated to point to the current major version of the software.

However, we do not have a process in place to handle edge releases of software. As of today, Docker 18 is the latest edge version of Docker, but the latest stable version is still Docker 17. This brought us to the question - should "core/docker" track the latest stable version or the latest edge version?

# Guide-level explanation
[guide-level-explanation]: #guide-level-explanation

Many Habitat packages track and package 3rd party software - this includes Docker, Node, Java, and more. We learned early on that even when a new major version of the software was released, many people still used the older version (and sometimes did not have the choice of upgrading immediately due to compliance or other reasons).

Historically, when a new major version of software was released (i.e. when Node 8 became the new LTS over Node 7) we changed the "generic" package (i.e. "core/node") to track the newest major version and, for people who needed to use an older major version of the software, created a new plan (i.e. "core/node7") that they could refer to.

When a new edge version of the software is released (i.e. Node 9.9.0 is the latest edge release as of this RFC), we do not track that in the generic package (i.e. core/node). The generic package must always track the latest stable release.

# Reference-level explanation
[reference-level-explanation]: #reference-level-explanation

This RFC would not change any current plans, it would apply to updated and new plans from the time of the adoption of the RFC.

# Drawbacks
[drawbacks]: #drawbacks

Users who want the bleeding edge versions of software will not be able to get them through Habitat's core plans.

# Rationale and alternatives
[alternatives]: #alternatives

It would not make sense to add a new package for the edge version (i.e. if the latest edge release of Node is 10, create a "core/node10"), then remove that package when that version become the stable version and is tracked in core/node. It also would be confusing to, rather than remove the edge version package ("core/node10") when it becomes the LTS version, to track Node 10 in both "core/node" and "core/node10".

Some have mentioned the idea of not having any generic packages - rather than "core/node", have only "core/node8", "core/node9", etc. While possible, this would potentially break plans which already depend on "core/node" or "core/docker", and a large amount of existing plans, documentation, and more would be required to change. I don't feel it is worth that pain of making our users switch from something like "core/node" to always specifying the latest major versions, particulary for users who don't care about the version as long as it works.


# Unresolved questions
[unresolved]: #unresolved-questions

- is there any way to automate this check for whether an update goes beyond the latest stable version of the software being packaged?
