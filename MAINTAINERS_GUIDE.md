# Policy Advice

This isn't policy. Policy should probably be in an RFC. This is the
"collective wisdom" of the current core-plans maintainers.  Written
down for when it isn't so "collective."

## Code Review & Approval

The goal of code review is to ensure the quality of the core plans,
encourage new contributors, and help drive contributions towards
completion.

Code review is a conversation between the submitter and the reviewer.
Comments should be friendly and should assume that all parties have
the best intents.

It is currently up to each reviewer as to what they require for a pull
request to receive an approval. Some examples of items you may
consider:

- [ ] Do the commit messages and PR description give enough context on why
      this change is being made? Would someone reading the commit message
      6 months from now find it useful?

- [ ] Does the plan work? Does it compile without warnings?

- [ ] Have all of the CONTRIBUTING.md requirements been met?

- [ ] Are the pkg_deps and pkg_build_deps set correctly? Can any
  run-time dependencies be moved to build dependencies?

Use your best judgment and add to this example list as appropriate.

Approval happens via GitHub's "Review" feature. For more information
on this see:

  - https://help.github.com/articles/about-pull-request-reviews/

## Merging PRs

Any maintainer can merge a pull request if

- 2 maintainers have approved the PR,

- 1 maintainer has approved a PR that is a minor or patch version bump
  to the upstream software, or

- 1 maintainer and 1 CODEOWNER has approved the PR even if the
  CODEOWNER isn't a maintainer.

You should merge the PR with the big green merge button on Github. It
is fun. You might find a fun GIF to post when you merge it.

## Promoting Packages

Packages can be promoted when INSERT_SOMETHING_HERE_EEYUN.

To promote a package, you can:

```
INSERT_PROCESS_HERE_SOMEONE
```

# Technical Notes

Put notes about commonly hit build problems down here.
