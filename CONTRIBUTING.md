# Contributing

# When to add a plan to core plans

[Habitat Plans](https://www.habitat.sh/docs/glossary/#glossary-packages) are packages in the Habitat Core Origin. They are maintained and built by the core maintainers to provide the fundamental base tier of packages used by the [Habitat](https://www.habitat.sh/) ecosystem.

Participation in the Habitat community is governed by the [code of conduct](https://github.com/habitat-sh/habitat/blob/master/CODE_OF_CONDUCT.md).

You can browse all available packages that you can leverage and use, including packages built and maintained by community members both inside and outside of this core origin, in [Habitat Builder](https://bldr.habitat.sh/#/explore).

Keep in mind that a core plan must by definition be abstracted to serve a wide array of users in service of their applications. If you are building a plan that is tailor made for your own unique application or specific use case, it is better suited to your own origin. Packages can be made public in your own origin too. Community and external project owned origins are an awesome way to make, share, and use functionality that lives outside of and extends core plans.

# Requirements to add a plan to core plans

In order for a package to be accepted as a core package, the following requirements must be met:

- [Package Metadata](#package-metadata)
- [Package Name Conventions](#package-name-conventions)
- [Adding an older version of a core package](#adding-an-older-version-of-a-core-package)
- [Dependencies](#dependencies)
- [Plan syntax](#plan-syntax)
- [Linting your plans](#linting-your-plans)
- [Pre-commit hooks](#pre-commit-hooks)
- [Signing your commits](#signing-your-commits)
- [Separate changes, separate PRs](#separate-prs)
- [Pull request review and merge automation](#pull-request-review-and-merge-automation)
- [Add yourself as a CODEOWNER](#add-yourself-as-a-codeowner)
- [Add yourself to core plans maintainers](#add-yourself-to-core-plans-maintainers)

## Package Metadata

Each package plan in this repository *must* contain a value adhering to the guidelines for each of the following elements:

- `pkg_description`
- `pkg_license` (in [SPDX format](http://spdx.org/licenses/))
- `pkg_maintainer` in the format of "The Habitat Maintainers <humans@habitat.sh>"
- `pkg_name` see the section of this document on "Package Name Conventions"
- `pkg_origin` must be set to `core`
- `pkg_source`
- `pkg_upstream_url`
- `pkg_version` must be the complete version number of the software

## Package Name Conventions

Each package is identified by a unique string containing four sub-strings separated
by a forward slash (`/`) called a [PackageIdent](https://www.habitat.sh/docs/glossary/#glossary-packages).

    `origin`/`name`/`version`/`release`

The `origin`, `name`, and `version` values of this identifier are user defined by
setting their corresponding variable in your `plan.sh` file while the value of
`release` is generated at build-time.

The value of `name` should exactly match the name of the project it represents and the `plan.sh` file should be located within a directory of the same name in this repository.

> Example: The plan for the [bison project](https://www.gnu.org/software/bison/) project contains setting `pkg_name=bison` and resides in `$root/bison/plan.sh`.

There is one exception to this rule: Additional plans may be defined for projects for their past major versions by appending the major version number to its name. The `plan.sh` file for this new package should be located within a directory of the same name.

> Example: the [bison project](https://www.gnu.org/software/bison/) maintains the 2.x line along with their current major version (at time of writing: 3.x). A second plan is created as `bison2` and placed within a directory of the same name in this repository.

Packages meeting this exception will always have their latest major version found in the package sharing the exact name of their project. A new package will be created for the previous major version following these conventions.

> Example: the [bison project](https://www.gnu.org/software/bison/) releases the 4.x line and is continuing to support Bison 3.x. The `bison` package is copied to `bison3` and the `bison` package is updated to build Bison 4.x.

## Adding an older version of a core package

Sometimes you may need a version of software that we are packaging which was released before the project's corresponding Habitat core package was created.

Please *do not* issue a PR containing a new plan for the specific version of software that you need unless the software project it packages meets the exceptional cases outlined in the above section "Package Name Conventions". Instead [create an issue](https://github.com/habitat-sh/core-plans/issues/new) containing the name and version of the software that you want published to [Habitat Builder](https://bldr.habitat.sh). A maintainer will run a one-off build and publish the generated artifact to the public depot and close your issue once the work is completed.

Issues with an associated gist containing a working fork of our current plan which builds the version of the software will be attended to first.

## Dependencies

If your package has dependencies, it should only depend on other packages in the core origin.

## Plan syntax

You can review the entire [plan syntax guide here](https://www.habitat.sh/docs/developing-packages/).

Please note that the following conditions must be observed for any plan to be merged into core plans (and are important best practices for any plan):

### Plan basic settings

You can read more about [basic plan settings](https://www.habitat.sh/docs/developing-packages/#write-plans) here. The minimum requirements for a core plan are:

- pkg_name is set
- pkg_origin is set
- pkg_shasum is set
- pkg_description is set

### Callbacks

You can read more about [callbacks](https://www.habitat.sh/docs/reference/#reference-callbacks) here. The minimum requirement for a core plan are:

#### Do's

- `do_prepare()` is a good place to set environment variables and set the table to build the software. Think of it as a good place to do patches.

#### Don't's

- You should never call `exit` within a build phase. You should instead return an exit code such as `return 1` for failure, and `return 0` for success.
- If you clone a repo from git, you must override `do_verify()` to `return 0`.
- Never use `pkg_source` unless you are downloading something as a third party.
- You should never shell out to `hab` from within a callback. If you think you want to, you should use a [utility function](https://www.habitat.sh/docs/reference/#utility-functions) instead.
- You should not call any function or helper that begin with an underscore, for example `_dont_call_this_function()`. Those are internal only functions that are not supported for external use and will break your plan if you call them.
- Don't run any code or run anything outside of a build phase or bash function.

### Hooks

The supervisor dynamically invokes hooks at run-time, triggered by an application lifecycle event. You can read more about [hooks](https://www.habitat.sh/docs/reference/#reference-hooks) here.

- You cannot block the thread in a hook unless it is in the `run` hook. Never call `hab` or `sleep` in a hook that is not the `run` hook.
- You should never shell out to `hab` from within a hook. If you think you want to, you should use a [runtime configuration setting](https://www.habitat.sh/docs/reference/#template-data) instead. If none of those will solve your problem, open an issue and tell the core team why.
- Run hooks should:
  - Redirect `stderr` to `stdout` (e.g. with `exec 2>&1` at the start of the hook)
  - Call the command to execute with `exec <command> <options>` rather than running the command directly. This ensures the command is executed in the same process and that the service will restart correctly on configuration changes.
  - If you are running something with a pipe `exec` won't work.
  - Always assume a minimal BusyBox `sh` implementation, never GNU Bash unless `core/bash` is an explicit run dependency and the hook's shebang line calls this Bash interpreter directly.
- Attempting to execute commands as a `root` user or trying to do `sudo hab install` are not good practice.
- Don't edit any of the Supervisor rendered templates.
  - You can only write to: `/var/`, `/static/`, `/data/` directories. You should only access these with your `runtime configuration setting` variable.
  - No one should ever edit anything in `/hab/` directly.
  - No one should write to anything in `/hab/` directly.

### README

All plans should have a README. In core plans, it is a hard requirement. Your README at a bare minimum should include:

- Your name as maintainer and supporter of this plan.
- Absolutely required:
  - What habitat topology it uses (and the plan should have the correct topology for the technology).
  - Clear, step by step instructions as to how to use the package successfully.
  - What is the best update strategy for different deployments?
  - What are some configuration updates a user can make, or do they always need to do a full rebuild?
- Strongly recommended:
  - Documentation on how to scale the service.
  - Instructions on how to monitor the health of the service at the application layer.
  - Can a user simply call the package as a dependency of their application?
  - How does the package integrate into their developer workflow?

## Linting Your Plans

It is good it use a tool to lint your plans to ensure you are not making any
easy-to-catch mistakes in your scripting. We recommend running
[ShellCheck](https://www.shellcheck.net/) against your plans.

Some default checks of ShellCheck can be turned off, since they aren't
necessarily applicable in plans. The following options work well:

```
shellcheck --shell=bash --exclude=SC1090,SC1091,SC2034,SC2039,SC2148,SC2153,SC2154,SC2140
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

## Separate Changes, Separate Pull Requests

Each package being changed should be separated into its own pull request. E.g. If you are making a change to `core/openssl` and your change requires another change in `core/curl` to be merged, each of these changes should be submitted as two different PRs with a note about the order in which each thing should be submitted. 

Each of these change PRs submitted should include a bracketed packagename as the prefix to the change information. For example in the previously defined situation the PR titles above might titled like so:

  - `[curl] Making a change here`
  - `[openssl] Also making a change here`

If you have opened a single PR that changes multiple plans, it is assumed you are making a substantial change to core plans. Substantial change PRs submitted without an RFC will be closed and you will be directed to open an RFC. If this was not your intention please open separate PRs per package change.



## Pull Request Review and Merge Automation

Habitat uses a bot to automate merging of pull requests. Messages to and from the bots are brokered via the account @thesentinels which can process incoming commands from reviewers to approve PRs. These commands are routed to a [sentinel](https://github.com/habitat-sh/sentinel) bot that will automatically merge a PR when sufficient reviewers have provided a +1 (or @thesentinels `approve` in sentinels terminology).

We use GitHub's integrated [CODEOWNERS](CODEOWNERS) to determine a appropriate reviewer(s). You must receive an approval from at least one CODEOWNER if there is one present for the plan you are modifying.

## Add yourself as a CODEOWNER

You may optionally add yourself as a CODEOWNER of a plan. Adding yourself as an owner means you have a vested interest in the software packaged by the plan and you, or another owner of the plan, will be required to review suggested changes. At least one CODEOWNER's approval is always required for a change to be accepted even if the change has been reviewed by a core plans maintainer.

## Add yourself to core plans maintainers

You can add yourself to [core plans maintainers](MAINTAINERS.md) to take a greater role and responsibility in the care, feeding, and maintenance of all core plans.
