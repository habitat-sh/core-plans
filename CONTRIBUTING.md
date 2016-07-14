# Contributing

When contributing to the `core-plans` repository, follow these guidelines.

## Package Metadata

A package should contain key elements:

- `pkg_description`
- `pkg_license` (in [SPDX format](http://spdx.org/licenses/))
- `pkg_maintainer` in the format of "The Habitat Maintainers <humans@habitat.sh>"
- `pkg_name`
- `pkg_origin`
- `pkg_source`
- `pkg_upstream_url`
- `pkg_version`

## Linting Your Plans

It is good it use a tool to lint your plans to ensure you are not making any
easy-to-catch mistakes in your scripting. We recommend running
[ShellCheck](https://www.shellcheck.net/) against your plans.

Some default checks of ShellCheck can be turned off, since they aren't
necessarily applicable in plans. The following options work well:

```
shellcheck --shell=bash --exclude=SC1091,SC2034,SC2039,SC2148,SC2153,SC2154
```

If ShellCheck is installed, you can run this (and other checks) locally with:

```
git add <your changes> && pre-commit run
```

See below for more about the pre-commit hooks.

## Pre-commit hooks

Install [pre-commit](http://pre-commit.com/) to run prior to your commits.
This will perform some initial checks against your changes and recommend any fixes before you commit.

## Signing Your Commits

This project utilizes a Developer Certificate of Origin (DCO) to ensure that each commit was written by the
author or that the author has the appropriate rights necessary to contribute the change.  The project
utilizes [Developer Certificate of Origin, Version 1.1](http://developercertificate.org/)

```
Developer Certificate of Origin
Version 1.1

Copyright (C) 2004, 2006 The Linux Foundation and its contributors.
660 York Street, Suite 102,
San Francisco, CA 94110 USA

Everyone is permitted to copy and distribute verbatim copies of this
license document, but changing it is not allowed.


Developer's Certificate of Origin 1.1

By making a contribution to this project, I certify that:

(a) The contribution was created in whole or in part by me and I
    have the right to submit it under the open source license
    indicated in the file; or

(b) The contribution is based upon previous work that, to the best
    of my knowledge, is covered under an appropriate open source
    license and I have the right under that license to submit that
    work with modifications, whether created in whole or in part
    by me, under the same open source license (unless I am
    permitted to submit under a different license), as indicated
    in the file; or

(c) The contribution was provided directly to me by some other
    person who certified (a), (b) or (c) and I have not modified
    it.

(d) I understand and agree that this project and the contribution
    are public and that a record of the contribution (including all
    personal information I submit with it, including my sign-off) is
    maintained indefinitely and may be redistributed consistent with
    this project or the open source license(s) involved.
```

Each commit must include a DCO which looks like this

`Signed-off-by: Joe Smith <joe.smith@email.com>`

The project requires that the name used is your real name.  Neither anonymous contributors nor those
utilizing pseudonyms will be accepted.

Git makes it easy to add this line to your commit messages.

1. Make sure the `user.name` and `user.email` are set in your git configs.
2. Use `-s` or `--signoff` to add the Signed-off-by line to the end of the commit message.

## Pull Request Review and Merge Automation

Habitat uses several bots to automate the review and merging of pull
requests. Messages to and from the bots are brokered via the account
@thesentinels. First, we use Facebook's [mention bot](https://github.com/facebook/mention-bot)
to identify potential reviewers for a pull request based on the `blame`
information in the relevant diff. @thesentinels can also receive
incoming commands from reviewers to approve PRs. These commands are
routed to a [homu](https://github.com/barosl/homu) bot that will
automatically merge a PR when sufficient reviewers have provided a +1
(or r+ in homu terminology).

### Delegating pull request merge access

A Habitat core maintainer can delegate pull request merge access to a contributor via

    @thesentinels delegate=username

If you've been given approval to merge, you can do so by appending a comment to the pull request containing the following text:

    @thesentinels r+

Note: **do not** click the Merge Pull Request button if it's enabled.
