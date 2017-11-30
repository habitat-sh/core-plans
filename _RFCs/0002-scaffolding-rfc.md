- Change Name: scaffolding-rfc
- Start Date: 2017-11-30
- RFC PR: (leave this empty)
- Core-Plans Issue: (leave this empty)

# Summary
[summary]: #summary

This RFC is meant to clarify the purpose and general functionality expected of Habitat scaffoldings - including (but not limited to) the node scaffolding and ruby scaffolding.

# Motivation
[motivation]: #motivation

There has been some healthy debate in the Habitat community around:
* How much functionality (and how customizable is should be) should be included in a scaffolding
* What the intended audience is for Habitat scaffoldings (i.e. beginner or experienced Habitat users)
* Whether a scaffolding should include a runtime for languages/frameworks that can be compiled into static assets.

The expected outcome of this RFC is adoption of community expectations and standards for scaffoldings within the core-plans repository.

# Guide-level explanation
[guide-level-explanation]: #guide-level-explanation

Core Habitat scaffoldings should provide the quickest and most delightful path to packaging and running an application in particular languages. The core audience for scaffoldings are new users of Habitat - who are still learning the Habitat concepts, terminology, and technology components. A first time Habitat user should be able to use a scaffolding to package and run a simple application over a lunch break.

That said - an experienced user of Habitat should be able to use and build upon a scaffolding to package and run more complex applications. Scaffoldings should allow customization through overriding callbacks, environmental variables, plan settings, helper functions, and more. However, this kind of customization should not be required for simple applications - it should be an option, not a requirement.

Additionally, scaffoldings should not require the use of alpha features - features should be out of alpha and beta to be required by scaffoldings. Although users are welcome to experiment with combining alpha features and scaffolding, they are not officially supported by the core-plans maintainers.

# Reference-level explanation

Habitat scaffoldings were originally modeled after [Heroku Buildpacks](https://devcenter.heroku.com/articles/buildpacks). They provide both a way of packaging an application and an executable runtime. If an advanced user prefers to use only the packaged application they can override or ignore the runtime functionality - but the default functionality will always include a runtime.

A user of scaffolding should be able to package and run a simple application
* with minimal Habitat knowledge
* within 1 hour
* with minimal operations experience

Additionally, using a scaffolding should not depend on alpha or beta features (which at the time of this RFC includes composite plans). It is fine for someone to experiment with using scaffoldings with alpha/beta features, but this should not be required for use and should not be officially supported by the core maintainers of core-plans.

# Drawbacks
[drawbacks]: #drawbacks

This will tip the appeal of scaffoldings toward beginner users, rather than advanced users. It will take additional work to establish documentation and patterns of more advanced uses of scaffolding. We will also need to communicate clearly what Habitat features we do and don't officially support for use with scaffoldings.

This may also require re-working of some of our scaffoldings.

# Rationale and alternatives
[alternatives]: #alternatives

I had originally [proposed splitting the node scaffolding](https://github.com/habitat-sh/core-plans/pull/1009). Through vigorous debate and discussion, we determined that splitting may not be necessary - clarifying of the purpose and intended use of scaffolding was. These guidelines should apply to all scaffoldings, not just the node scaffolding.

# Unresolved questions
[unresolved]: #unresolved-questions

- How will we and who will update the existing scaffoldings to these standards?
