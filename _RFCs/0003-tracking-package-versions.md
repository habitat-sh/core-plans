- Change Name: standardize_tracking_major_package_versions
- Start Date: 2018-03-27
- RFC PR: (leave this empty)
- Core-Plans Issue: (leave this empty)

# Summary
[summary]: #summary

Generic package names (ones which do not specify a version in the name - i.e. core/docker) must always point to the latest **stable** version of the software.

Everytime a new major version of software packaged by Habitat is released as stable, a new core plan must be made for that version (i.e. when Docker11 is released as stable, we should create core/docker11). Any core plan which tracks a major stable version release (i.e. core/docker10, core/docker11) should source the generic plan and overwrite download urls, build phases, etc., as necessary to download and package that major version.

Edge versions of software are not tracked by core plans. If a user wishes to use the edge version of a package, they must either fork an existing core plan or create a new core plan to package it. Core plans only support stable versions of software.

# Motivation
[motivation]: #motivation

We currently have several generic packages (i.e. core/docker) that track the current stable version of the packaged software (as of today, core/docker points to Docker 17). When a new major version of the package becomes available, we move the old version (i.e. Docker 16) to a separate plan to track the old version (i.e. core/docker16) while the generic package (core/docker) is updated to point to the current major version of the software.

# Guide-level explanation
[guide-level-explanation]: #guide-level-explanation

Many Habitat packages track and package 3rd party software - this includes Docker, Node, Java, and more. We learned early on that even when a new major version of the software was released, many people still used the older version (and sometimes did not have the choice of upgrading immediately due to compliance or other reasons).

Historically, when a new major version of software was released (i.e. when Node 8 became the new LTS over Node 7) we changed the generic package (i.e. core/node) to track the newest major version and, for people who needed to use an older major version of the software, created a new plan (i.e. "core/node7") that they could refer to.

Now we will create a new core plan for every major release of a piece of software.

Generic packages (i.e core/docker) will continue to track the latest stable version of the software. Version specific plans (i.e. core/Docker10) will source the generic plan and overwrite download urls, build phases, and whatever else is appropriate. We currently do this with our core/postgres and core/postgresX packages and will follow this process with each of our core plans going forward.

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

The other alternative is to avoid sourcing another plan by tracking the latest stable version in both the generic plan (i.e. core/node) and the version specific plan (i.e. core/node9). This, however, introduces duplication, and the high possiblility of one being updated and the other not. Directly sourcing the version specific plan from the generic plan prevents this.


# Unresolved questions
[unresolved]: #unresolved-questions

- is there any way to automate this check for whether an update goes beyond the latest stable version of the software being packaged?
