- Change Name: node-scaffolding-split
- Start Date: 2017-11-20
- RFC PR:
- Core-Plans Issue:

# Summary
[summary]: #summary

This RFC proposes splitting the current [scaffolding-node](https://github.com/habitat-sh/core-plans/tree/master/scaffolding-node) into two scaffoldings - one focused on applications that run dynamically and one focused on applications that are compiled and run as static assets.

# Motivation
[motivation]: #motivation

There are currently two ways of running Node applications. Some applications (especially those created with the [Express](https://expressjs.com/) framework) run the application using Node.js's web server. Others - especially those built with [React](https://reactjs.org/) and [Angular](https://angular.io/) - compile Javascript, etc. as static assets and run them behind a proxy like Nginx. Supporting both of these approaches through one scaffolding would be deeply complex at best and untenable at worst.

# Guide-level explanation
[guide-level-explanation]: #guide-level-explanation

This splits the node scaffolding into two different scaffoldings - one for dynamic applications and one for applications that are compiled to static assets.

If you are a node developer creating an Express application (or any other application that uses the Node.js web server) you should use the scaffolding for dynamic applications.

If you are a node developer creating a React or Angular application (or any other application that is compiled into static assets, then run behind a proxy like Nginx) you should use the scaffolding for static applications.

Developers who are using the current node scaffolding need to migrate to either the dynamic scaffolding or the static scaffolding. The dynamic scaffolding will largely be the same as the current node scaffolding, but users will need to change the name of the scaffolding they specify when initializing habitat in their application repos (and in their habitat/plan.sh files).

The original scaffolding-node will remain on builder but will be deprecated and no longer updated.

# Reference-level explanation
[reference-level-explanation]: #reference-level-explanation

Scaffolding-node splits into two scaffoldings - scaffolding-node-dynamic and scaffolding-node-static (these are just placeholder names, they can be something else).

Scaffolding-node-dynamic remains largely the same as the current scaffolding-node.

Scaffolding-node-static will compile a node application into static assets and will run them behind an Nginx proxy (there will be a dependency on core/nginx).

The code around hab plan init would need to be changed to accept either the scaffolding-node-dynamic or scaffolding-node-static scaffoldings as an -s argument.

All tutorials/documentation that refer to scaffolding-node will need to change to refer to either scaffolding-node-dynamic or scaffolding-node-static.

# Drawbacks
[drawbacks]: #drawbacks

The original intent of the node scaffolding was to be a quickstart for Habitizing any node application. This approach would force node developers to think about which scaffolding would serve them best and choose one or the other.

# Rationale and alternatives
[alternatives]: #alternatives

The node ecosystem is vast and it is very unlikely we could ever support all common node implementations with one scaffolding.

An alternative would be to include two options with the current node scaffolding - and have the user decide which one to use with an environmental variable. But this would make the current node scaffolding extremely complex and make it more difficult to maintain/contribute to.

Although you can run React and Angular apps through the current node scaffolding - the current scaffolding does not support compiling JS into static assets, it runs the whole application as a service. This is counter-intutitive for many if not most front-end developers - who are the target audience for this scaffolding.

# Unresolved questions
[unresolved]: #unresolved-questions

- What do we name the two different scaffoldings?
- How do we make it easy for any node developer to know which scaffolding would best fit their needs?
