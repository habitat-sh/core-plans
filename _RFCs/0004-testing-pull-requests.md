- Change Name: testing_requirements_pull_requests
- Start Date: 2018-03-27
- RFC PR: (leave this empty)
- Core-Plans Issue: (leave this empty)

# Summary
[summary]: #summary

Pull requests to core plans (whether new core plans or updates to existing ones) must have steps for manually testing the change (which will be automated as much as possible when the automated testing framework is available).

# Motivation
[motivation]: #motivation

Stability and reliability of core plans is central to the user experience and is therefore a top priority of core plans maintainers. Having a way to test an updated or new core plan helps improve the quality of core plans, and provides confidence in the change submitted.

Part of what makes pull requests to core plans linger open for so long is that, although many people are comfortable with reviewing the code, many are hesitant to merge, release, and promote the package for fear of breaking it or other packages dependent on it.  A future automated testing framework (currently in development) will automate much of this testing, but before we can automate testing something, we need to know how to test it manually.

# Guide-level explanation
[guide-level-explanation]: #guide-level-explanation

When someone opens a pull request to the core plans repo, they must include steps to test the change they are making (or the functionality of a new plan). The intent is to have a way to test any new functionality and, as much as possible, prevent breaking of existing functionality. Providing these testing steps (and sample apps when useful) is the responsibility of the person opening the pull request. However, should the person opening the pull request need help with establishing testing steps, they are most welcome to ask for it in the pull request.  A pull request must not be approved until testing steps are provided in the pull request.

In lieu of manual steps, we also welcome tests in the do_check build phase (for more info about build phases (including do_check) please see [this documentation](https://www.habitat.sh/docs/reference/#build-phase-callbacks)).

At least one core maintainer must review the pull request's code and, upon approval, either that same maintainer or another maintainer must follow the manual testing steps locally OR, if tests have been added to the do_check build phase that cover the added functionality, build the package with do_check enabled. This manual and automated testing can be done either before or after the merge (when the package is on the unstable channel in Builder), but must be done before the package is promoted to stable. It should be noted that it is a bad practice to leave a package in unstable more than a day without testing it for promotion to stable (ideally, it should be tested as soon as it builds successfully and is put in the unstable channel).

# Reference-level explanation
[reference-level-explanation]: #reference-level-explanation

Here are some examples of manually testing pull requests:

* [Reviewing a database service package](https://forums.habitat.sh/t/reviewing-core-plans-example-database/476)
* [Reviewing a binary package](https://forums.habitat.sh/t/reviewing-core-plans-example-binaries/449)
* [Reviewing changes to core/scaffolding-node and core/scaffolding-ruby](https://forums.habitat.sh/t/reviewing-core-plans-example-scaffoldings/450)
* [General guidelines for reviewing core plans](https://forums.habitat.sh/t/reviewing-core-plans/434)

# Drawbacks
[drawbacks]: #drawbacks

This does put more of a burden on the person who is opening the pull request - to not only submit the request, but also include steps for testing it.

# Rationale and alternatives
[alternatives]: #alternatives

There is an automated testing framework in the works, which will be very helpful with this. That said, as of the time of writing this pull request, that framework is not yet ready. Additionally, even when that framework is ready, we still need to know how to manually test a plan before we can automate those tests. The best person to guide how to test a change is the person who made that change.

# Unresolved questions
[unresolved]: #unresolved-questions
