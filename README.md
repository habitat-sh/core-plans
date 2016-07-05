# Habitat Plans

[Habitat Plans](https://www.habitat.sh/docs/concepts-plans/) maintained and
built by the Habitat core maintainers for the [Habitat](https://www.habitat.sh/)
ecosystem.

See [MAINTAINERS.md](MAINTAINERS.md) for a list of maintainers of the core
plans. To become a maintainer, open a pull request to that file.

The code for Habitat itself is in the
[habitat-sh/habitat](https://github.com/habitat-sh/habitat/) GitHub repository.

## Linting Your Plans

It is good it use a tool to lint your plans to ensure you are not making any
easy-to-catch mistakes in your scripting. We recommend running
[ShellCheck](https://www.shellcheck.net/) against your plans.

Some default checks of ShellCheck can be turned off, since they aren't
necessarily applicable in plans. The following options work well:

```
shellcheck --exclude=SC2034,SC2148,SC2153,SC2154
```

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

Git makes it easy to add this line to your commit messages.  Make sure the `user.name` and
`user.email` are set in your git configs.  Use `-s` or `--signoff` to add the Signed-off-by line to
the end of the commit message.

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

## License

Copyright (c) 2016 Chef Software Inc. and/or applicable contributors

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

     Unless required by applicable law or agreed to in writing, software
     distributed under the License is distributed on an "AS IS" BASIS,
     WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
     See the License for the specific language governing permissions and
     limitations under the License.

