- Change Name: standardize_tracking_major_package_versions
- Start Date: 2018-03-27
- RFC PR: (leave this empty)
- Core-Plans Issue: (leave this empty)

# Summary
[summary]: #summary

Everytime a new major version of software packaged by Habitat is released (whether stable or an edge release), a new core plan must be made for that version (i.e. when Docker11 is released, we should create core/docker11).

Generic package names (ones which do not specify a version in the name - i.e. core/docker) must always point to the latest **stable** version of the software.  They must not track edge versions of the software.  They must source the plan for the latest stable plan which tracks that software (i.e. if the current stable version of Docker is Docker10, and the edge version is Docker11, core/docker should source core/docker10).

Edge versions of software are not tracked by core plans. If a user wishes to use the edge version of a package, they must either fork an existing core plan or create a new core plan to package it. Core plans only support stable versions of software.

# Motivation
[motivation]: #motivation

We currently have several generic packages (i.e. core/docker) that track the current stable version of the packaged software (as of today, core/docker points to Docker 17). When a new major version of the package becomes available, we move the old version (i.e. Docker 16) to a separate plan to track the old version (i.e. core/docker16) while the generic package (core/docker) will be updated to point to the current major version of the software.

However, we do not have a process in place to handle edge releases of software. As of today, Docker 18 is the latest edge version of Docker, but the latest stable version is still Docker 17. This brought us to the question - should "core/docker" track the latest stable version or the latest edge version? Should we even track edge versions at all?

# Guide-level explanation
[guide-level-explanation]: #guide-level-explanation

Many Habitat packages track and package 3rd party software - this includes Docker, Node, Java, and more. We learned early on that even when a new major version of the software was released, many people still used the older version (and sometimes did not have the choice of upgrading immediately due to compliance or other reasons).

Historically, when a new major version of software was released (i.e. when Node 8 became the new LTS over Node 7) we changed the generic package (i.e. core/node) to track the newest major version and, for people who needed to use an older major version of the software, created a new plan (i.e. "core/node7") that they could refer to.

Now we will create a new core plan for every major release of a piece of software.

Generic packages (i.e core/docker) will continue to track the latest stable version of the software. However, they will do this by sourcing whatever version plan corresponds to the latest stable version (i.e. if Docker10 is stable, core/docker will source core/docker10, rather than core/docker9).

# Reference-level explanation
[reference-level-explanation]: #reference-level-explanation

This RFC would not change any current plans, it would apply to updated and new plans from the time of the adoption of the RFC.

# Drawbacks
[drawbacks]: #drawbacks

This does potentially introduce many more plans into core/plans - which will need to be maintained and rebuilt as necessary, and it will increase the build load on Builder.

# Rationale and alternatives
[alternatives]: #alternatives

The alternative is to keep doing what we have historically done - having the generic plan (i.e. core/node) track the latest major stable version of the software, and add in core/nodeX whenever a new major version of Node is released to stable).

However, this makes it more difficult for users to "pin" to a certain version of software if they know they are not going to be upgrading to the next major version in the near future.

The other alternative is to avoid sourcing another plan from the generic plan by tracking the latest stable version in both the generic plan (i.e. core/node) and the version specific plan (i.e. core/node9). This, however, introduces duplication, and the high possiblility of one being updated and the other not. Directly sourcing the version specific plan from the generic plan prevents this.


# Unresolved questions
[unresolved]: #unresolved-questions

- is there any way to automate this check for whether an update goes beyond the latest stable version of the software being packaged?