- Change Name: reset-gh-approvals-when-changes-are-made
- Start Date: 2018-04-05
- RFC PR: (leave this empty)
- Core-Plans Issue: (leave this empty)

# Summary
[summary]: #summary

When in the course of human events, it becomes necessary to approve RFCs, that
approval should be reset by GitHub when the contents of the RFC changes.

# Motivation
[motivation]: #motivation

Given the types of fundamental changes that RFCs are designed to make, it's
concerning that someone can give their approval of an RFC (via the GitHub PR
approval mechanism), and then the entire RFC can be totally re-written, and
their approval remains.

# Guide-level explanation
[guide-level-explanation]: #guide-level-explanation

The purpose of this RFC is to make sure people know what they're approving.
Given the lengthy nature of the RFC process, and the types of changes that it's
designed to make, I feel it's important that people know what changes they are
saying yes to.

The way things are setup now, GitHub lets you approve a pull request, and your
approval remains on that pull request for all time, unless you or an
administrator of the repository removes it.

Given this fact, and the nature of RFCs to be revised as people comment on
them, it's entire possible that people are approving things they don't agree with,
simply because they don't re-read the RFC every time it changes.

If this RFC is approved, then any time any RFC is changed, all the GitHub approvals
would be removed and people would need to re-read and re-approve.

At first glance, this sounds like adding a lot more work to people's plates,
but I would suggest that it's leading us towards a practice where we pour all
of our thoughts and comments out first, and save our approval for the very end.

As part of this change, I will move all of the RFCs out into their own
repository, and make the appropriate settings change there. The settings for
the core-plans repository will remain unchanged, as they are today.

# Reference-level explanation
[reference-level-explanation]: #reference-level-explanation

There are no technical details to this RFC. It's simply a checkbox in the
GitHub settings that changes how sticky approvals are on pull requests.

# Drawbacks
[drawbacks]: #drawbacks

There is one principle downside that I can think of:

* More reading is involved. You can't just approve an RFC and walk away #yolo
  style, forever ignoring all the future updates to that PR. If you're serious
  about an RFC, then you might need to re-read and re-approve it several times,
  if changes are made.

# Rationale and alternatives
[alternatives]: #alternatives

The alternative to doing this is to not do it, leaving things as they are
today: namely, you can approve an RFC, and never look at that
branch again, confident that your approval will carry through forever.

# Unresolved questions
[unresolved]: #unresolved-questions
