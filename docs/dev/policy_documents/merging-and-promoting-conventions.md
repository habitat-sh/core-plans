# Merging and Promoting Conventions

## Summary
[summary]: #summary

This policy defines a 'fast-track' merge and promote policy for a subset of core-plans.  

## Motivation
[motivation]: #motivation

Our code review process is currently slow, frustrating core-plan maintainers who are donating their personal time or their employer's time to the project. One contributor (Graham Wilson, predominant) has hundreds of updates in his backlog, but has been holding back because of delays in the review process.

If someone who contributes heavily to core plans has a pull request (PR) for a minor change open for 7+ days, the automated testing already in place and the small scope of the change makes the value of additional code-review small compared to the cost it is imposing on some maintainers.  In this situation, allowing 'approver' maintainers to use their own judgement and immediately merge the PR will help ensure core-plan maintainers can make the most of the time they spend on this project.

## Guide-level explanation
[guide-level-explanation]: #guide-level-explanation

PR's eligible for fast-track are those:

* That consist of minor changes. For example, version bumps, style improvements, bug fixes that don't change the scope of the plan;
* That are opened by an 'approver' core-plan contributor specified in [MAINTAINERS.md](https://github.com/gavindidrichsen/core-plans/blob/master/MAINTAINERS.md).  For more information on Chef's project membership policy see [here](https://github.com/chef/chef-oss-practices/blob/master/project-membership.md)
* That are not base plans.  See the [base-plans.txt](https://github.com/habitat-sh/core-plans/blob/master/base-plans.txt);
* That do not have the 'T-DO-NOT-MERGE' label;
* That have passing automated tests

**If the above criteria are satisfied** for a given PR, then the 'approver' may merge and promote the PR if it has not received feedback for 7+ days.

## Drawbacks
[drawbacks]: #drawbacks

Drawbacks include:

* maintainers may have less awareness about what changes have occurred recently;
* bugs might enter that would have been caught in code review;
* this 'fastrack' approach might decrease pressure to improve the code-review process that has led to long delays.

## Rationale and alternatives
[alternatives]: #alternatives

N/A

## Unresolved questions
[unresolved]: #unresolved-questions

N/A
