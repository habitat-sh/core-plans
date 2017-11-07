- Change Name: rfc-for-rfcs
- Start Date: 2017-11-03
- RFC PR: (leave this empty)
- Core-Plans Issue: (leave this empty)

# Summary
[summary]: #summary

This RFC is meant to serve as an example of the process for entering RFCs. It should also serve up the information regarding the RFC process that will get merged into an .md file in the repository for explanation of the why/when/how of an RFC against core-plans.

# Motivation
[motivation]: #motivation

We want to provide safety-nets and transparency over core-plans direction and development efforts while also enabling new contributors to feel comfortable in anything they might want to add to the core package set.

# Guide-level explanation
[guide-level-explanation]: #guide-level-explanation

The RFC for RFC Implementation adds a clearly defined process for _when_, _why_ ,  and _how_ to open RFCs for changes in the core-plans repository. 

The expected impact is that core-plans maintainers have another tool in the maintenance process toolchest to enable them to deal with tricky changes, whether those are substantial in scope, or substantial in outcome.

Rather than providing an example-driven introduction to the RFC process this entire RFC exists as an example of the RFC process. The explicit/reference level explanation contains a complete account of the RFC process top to bottom.



# Reference-level explanation
[reference-level-explanation]: #reference-level-explanation

#################

## Table of Contents
[Table of Contents]: #table-of-contents

  - [Intro](#core-plans-rfcs)
  - [Table of Contents](#table-of-contents)
  - [When you need to follow this process](#when-you-need-to-follow-this-process)
  - [Before creating an RFC](#before-creating-an-rfc)
  - [What the process is](#what-the-process-is)
  - [The RFC life-cycle](#the-rfc-life-cycle)
  - [Reviewing RFCs](#reviewing-rfcs)
  - [Implementing an RFC](#implementing-rfcs)
  - [RFC Postponement](#rfc-postponement)
  - [Help this is all too informal!]
  - [Attribution]

# Core-Plans RFCs
[Core-Plans RFCs]: #core-plans-rfcs

A majority of contributor and maintainer work can be implemented and reviewed via [the normal GitHub pull request workflow](https://guides.github.com/introduction/flow/). These changes include bug fixes, documentation improvements, package version bumps, and adding a new core-plan. 

Other changes by their nature are considered more complex, and we prefer to have an established process that these changes can be put through in order to provide the Habitat Maintainers and Community members those an opportunity to contribute to the design process and produce a consensus among the community.

The "RFC" (request for comments) process is intended to provide a consistent path and expectation for a few things specifically: tooling changes, process changes, or new standards that might modify the acceptance criteria for new packages entering core-plans. The purpose is to ensure that all project stakeholders can be confident and aware of the direction core-plans and their maintenance are heading in.

## When you need to follow this process
[When you need to follow this process]: #when-you-need-to-follow-this-process

You need to follow this process if you intend to make any change considered "substantial" to the Core-Plans repository, tooling, or maintenance processes (including the RFC process itself). What constitutes a "substantial" change may evolve over time based on the community, but may initially include the following.

  - Any process or operational changes to the Core-Plans Maintenance Policies.
  - Any package feature or rewrite that breaks backwards compatibility for current users.
  - Any Removal of a package's features (see breaking change).
  - Changes to the standardized operational tooling in use by Core-Plans maintainers.
  - Any changes to the standard core-plans accepted style and baseline.
  - Any inbound Habitat change that obligates all entries in Core-Plans to change.

**NOTE:** If you have opened a single PR that changes multiple plans, it is assumed you are making a substantial change to core plans. Substantial change PRs submitted without an RFC will be closed and you will be directed to open an RFC. If this was not your intention (for example in the case of updating two interdependent packages) please open separate PRs per package change.

Some changes do not require an RFC:

  - Package refactors/rephrases, changes that are transparent to user.
  - Adding net "New" software to the core repository.
  - Additions only likely to be _noticed by_ other maintainers (Invisible to target package users).
  - Bug fixes for currently available packages.

If you submit a pull request to implement a new feature without going through the RFC process, it may be closed with a polite request to submit an RFC first.

## Before creating an RFC
[Before creating an RFC]: #before-creating-an-rfc

A hastily-proposed RFC can hurt its chances of acceptance. Low quality proposals, proposals for previously-rejected features, or those that don't fit into the near-term roadmap, may be quickly rejected, which can be demotivating for the unprepared contributor. Laying some groundwork ahead of the RFC can make the process smoother.

Although there is no single way to prepare for submitting an RFC, it is generally a good idea to pursue feedback from other package developers beforehand, to ascertain that the RFC may be desirable; having a consistent impact on the project requires concerted effort toward consensus-building.

The most common preparations for writing and submitting an RFC include talking the idea over in the  [#core-plans channel in slack](https://habitat-sh.slack.com/messages/C7V72D23H/) as well as filing and discussing ideas on the [Core-Plans issue tracker](https://github.com/habitat-sh/core-plans/issues)

As a general guideline, receiving encouraging feedback from long-standing package developers, and core-plans maintainers is a good indication that the RFC is worth pursuing.

## What the process is
[What the process is]: #what-the-process-is

In short, to get a change into Core Plans, one must first get the RFC merged into the RFC directory as a markdown file. At that point the RFC is "active" and may be implemented with the goal of eventual inclusion into Core-Plans.

  - Fork the [Core Plans Repository](https://github.com/habitat-sh/core-plans)
  - Copy `_RFCs/0000-template.md` to `_RFCs/0000-my-feature.md` (where "my-feature" is descriptive. don't assign an RFC number yet).
  - Fill in the RFC. Put care into the details: RFCs that do not present convincing motivation, demonstrate understanding of the impact of the design, or are disingenuous about the drawbacks or alternatives tend to be poorly-received.
  - Submit a pull request ([make sure you sign your commits](https://github.com/habitat-sh/core-plans/blob/master/CONTRIBUTING.md#signing-your-commits)). As a pull request the RFC will receive design feedback from the larger community, and the author should be prepared to revise it in response.
  - Each pull request will be labeled with the RFC tag, which will lead to its being triaged by the core-plans maintainers in a future meeting and assigned to one of it's members.
  - Build consensus and integrate feedback. RFCs that have broad support are much more likely to make progress than those that don't receive any comments. Feel free to reach out to the RFC assignee directly to get help identifying stakeholders and obstacles.
  - The maintainers will discuss the RFC pull request, as much as possible in the comment thread of the pull request itself. Offline discussion will be summarized on the pull request comment thread.
  - RFCs rarely go through this process unchanged, especially as alternatives and drawbacks are shown. You can make edits, big and small, to the RFC to clarify or change the design, but make changes as new commits to the pull request, and leave a comment on the pull request explaining your changes. Specifically, do not squash or rebase commits after they are visible on the pull request.
  - At some point, a maintainer will propose a "motion for final comment period" (FCP), along with a *disposition* for the RFC (merge, close, or postpone).
  - This step is taken when enough of the tradeoffs have been discussed that the subteam is in a position to make a decision. That does not require consensus amongst all participants in the RFC thread (which is usually impossible). However, the argument supporting the disposition on the RFC needs to have already been clearly articulated, and there should not be a strong consensus *against* that position outside of the maintainers. We will use our best judgment in taking this step, and the FCP itself ensures there is ample time and notification for stakeholders to push back if it is made prematurely.
  - For RFCs with lengthy discussion, the motion to FCP is usually preceded by a *summary comment* trying to lay out the current state of the discussion and major tradeoffs/points of disagreement.
  - Before actually entering FCP, *all* Core-Plans Maintainers must sign off; this is often the point at which many maintainers first review the RFC in full depth.
  - The FCP lasts a fortnight, 14 calendar days, so that it is open for at least 10 business days. It is also advertised widely, e.g. in [the #announcements channel in Slack](https://habitat-sh.slack.com/messages/C1WJAA1DM/). This way all stakeholders have a chance to lodge any final objections before a decision is reached.
  - In most cases, the FCP period is quiet, and the RFC is either merged or closed. However, sometimes substantial new arguments or ideas are raised, the FCP is canceled, and the RFC goes back into development mode.

## The RFC life-cycle
[The RFC life-cycle]: #the-rfc-life-cycle

Once an RFC becomes "active" then authors may implement it and submit the change as a pull request to the Core-Plans repo. Being "active" is not a rubber stamp, and in particular still does not mean the change will ultimately be merged; it does mean that in principle all the major stakeholders have agreed to the change and are amenable to merging it.

Furthermore, the fact that a given RFC has been accepted and is "active" implies nothing about what priority is assigned to its implementation, nor does it imply anything about whether a Core-Plans developer has been assigned the task of implementing the change. While it is not *necessary* that the author of the RFC also write the implementation, it is by far the most effective way to see an RFC through to completion: authors should not expect that other project developers will take on responsibility for implementing their accepted feature.

Modifications to "active" RFCs can be done in follow-up pull requests. We strive to write each RFC in a manner that it will reflect the final design of the feature; but the nature of the process means that we cannot expect every merged RFC to actually reflect what the end result will be.

In general, once accepted, RFCs should not be substantially changed. Only very minor changes should be submitted as amendments. More substantial changes should be new RFCs, with a note added to the original RFC. Exactly what counts as a "very minor change" is up to the core-plans maintainers to decide.

## Reviewing RFCs
[Reviewing RFCs]: #reviewing-rfcs

When the RFC pull request is first opened, a core plans maintainer will be assigned as a shepherd to the RFC to ensure it makes as much progress through the RFC pipeline as is possible. While the RFC PR is open the assigned shepherd may schedule meetings  with the author and/or relevant stakeholders to discuss the issues in greater detail, and in some cases the topic may be discussed at a maintainers meeting. In either case a summary from the meeting will be posted back to the RFC pull request.

Maintainers make the final decisions about RFCs after the benefits and drawbacks are well understood. These decisions can be made at any time, but the maintainers will regularly issue decisions. When a decision is made, the RFC pull request will either be merged or closed. In either case, if the reasoning is not clear from the discussion in thread, the maintainers will add a comment describing the rationale for the decision.


## Implementing an RFC
[Implementing an RFC]: #implementing-an-rfc

Some accepted RFCs represent vital changes that need to be implemented right away. Other accepted RFCs can represent changes that can wait until some arbitrary contributor feels like doing the work. Every accepted RFC has an associated issue tracking its implementation in the Core-Plans repository; thus that associated issue can be assigned a priority via the triage process that the team uses for all issues in the Core-Plans repository.

The author of an RFC is not obligated to implement it. Of course, the RFC author (like any other contributor) is welcome to post an implementation for review after the RFC has been accepted.

If you are interested in working on the implementation for an "active" RFC, but cannot determine if someone else is already working on it, feel free to ask (e.g. by leaving a comment on the associated issue).


## RFC Postponement
[RFC Postponement]: #rfc-postponement

Some RFC pull requests are tagged with the "postponed" label when they are closed (as part of the rejection process). An RFC closed with "postponed" is marked as such because we want neither to think about evaluating the proposal nor about implementing the described feature until some time in the future, and we believe that we can afford to wait until then to do so. Postponed pull requests may be re-opened when the time is right. We don't have any formal process for that, you should ask maintainers in the relevant slack channel.

Usually an RFC pull request marked as "postponed" has already passed an informal first round of evaluation, namely the round of "do we think we would ever possibly consider making this change, as outlined in the RFC pull request, or some semi-obvious variation of it." (When the answer to the latter question is "no", then the appropriate response is to close the RFC, not postpone it.)


### Help this is all too informal!
[Help this is all too informal!]: #help-this-is-all-too-informal

The process is intended to be as lightweight as reasonable for the present circumstances. As usual, we are trying to let the process be driven by consensus and community norms, not impose more structure than necessary.


[#core-plans slack channel]: https://habitat-sh.slack.com/
[Core-Plans RFC issue tracker]: https://github.com/habitat-sh/core-plans/labels/C-RFC

## Attribution
[Attribution]: #attribution

THIS DOCUMENT IS HEAVILY INFLUENCED AND MANY OF THE WORDS ARE TAKEN DIRECTLY FROM THE RUST RFC PROCESS. [Rust RFCs](https://github.com/rust-lang/rfcs)


#################

# Drawbacks
[drawbacks]: #drawbacks

It's possible that in implementing an RFC process we'll end up with more project transparency which could result in an uptick in contribution which in turn could cause the core-plans maintainers to be further inundated with work.

# Rationale and alternatives
[alternatives]: #alternatives

Most open and free software projects already use an RFC process to get transparency over development and maintenance happening within a project as well as giving contributors perspective over project direction. This general pattern has been adopted by hundreds of thousands of FOSS projects. This change will provide our community another feedback mechanism as well as a way to teach new contributors the ins-and-outs of core-plans development.

The alternative is to not have an RFC process. We don't want to go this path as having one will help to shore up behaviors and stability in the core set of packages that all Habitat users will require going forward.

The impact of not adopting an RFC process could mean continued low-quality of various packages in core as well as the inability to lean on governance to disallow poor quality merges. It can also hinder our contribution levels if community members feel that they can't safely work on something and get it merged into the core packages in a reasonable amount of time.

# Unresolved questions
[unresolved]: #unresolved-questions

Is 10 days too long/too short of an FCP?

Do all of the current core-maintainers feel confident in the new process?

Are there any outstanding questions folks have around the theoretical process?
