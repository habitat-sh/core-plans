# Verifying base-plan updates

[Base plans](https://github.com/habitat-sh/core-plans/blob/master/base-plans.txt) are low-level pieces of software in the Habitat ecosystem. Every core plan has one or more direct or transitive dependency on a base plan and the core origin is depended on by every user of Habitat so it is critical that extra validation be done prior to merging a change to a base plan. This document is focused on reviewing and verifying updates to base-plans.

## Updating a base-plan

An update to a base plan should follow the same process as a change to every other plan. A PR should contain a change to a single plan that will be run through CI before being reviewed and accepted. Base plans differ here, in that the target branch will be a long-lived branch with the convention `refresh/YYYYqN` rather than `master`.  This branch will serve as a staging ground for a [base plans refresh ](https://forums.habitat.sh/t/base-plans-refreshes/806).

## Build and Verification

We provide a [script](https://github.com/habitat-sh/core-plans/blob/master/bin/refresh-verify-change.sh) to build and verify a change to a base plan.  Once you have validated that your change builds, this script should be run before submitting the change. This script can also be used by maintainers to validate any incoming changes.

This must be run outside of CI. In order to build against the changed and rebuilt software, the packages must be uploaded to a Habitat Builder instance or all built from the same studio. We currently don't have an Builder instance we can use and there is a 60 minute timeout on CI so it's almost guaranteed that the build would timeout.

## Exceptions

glibc, binutils and GCC will often need to be updated at the same time in order for builds to succeed. If possible, they should be updated independently but a PR containing multiple updates should be considered if the changes are required to build  together.

## Downstream Impact

Any time a base plan is updated and a package is made available on builder, there is a high probability that origins outside of core will be impacted.

## Unanswered questions

If we start merging into a long-lived branch, how do we expose that to our contributors so they can see if an update has already been submitted?

Is there automation we can put in place to change the target branch if the PR contains a base plan update?
