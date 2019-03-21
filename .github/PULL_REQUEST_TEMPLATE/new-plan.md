---
name: New Plan
about: I'd like add a new Core Plan
labels: C-new-plan

---

Hello - thanks for contributing to Habitat Core Plans!

You've indicated that you'd like to add new software to be tracked and packaged as part of Habitat Core Plans. Please review and include the following information:

- [ ] A short description of the functionality this software provides
- [ ] README.md included. Please follow this [template](https://github.com/habitat-sh/core-plans/blob/master/README_TEMPLATE_FOR_PLANS.md)

Please describe how we can verify that the resulting package is working as intended. Consider adding tests to automate the verification of the package.  Please read [RFC0004](https://github.com/habitat-sh/core-plans-rfcs/blob/master/_RFCs/0004-testing-pull-requests.md) for more details.

- [ ] Description of how to validate the package **OR** addition of tests to validate the package.

Please verify the license is correct and allows for redistribution

- [ ] pkg_license is correct and allows for redistribution

Habitat Builder uses a `.bldr.toml` file in this repository to provide hints for what should be built when a PR merges. Please add this plan to the `.bldr.toml`

- [ ] Add `.bldr.toml` entry (alphabetical)

If the package is a service, please ensure the service runs with the provided defaults. We also prefer that configuration complexity be kept to a minimum. Please read [RFC0009](https://github.com/habitat-sh/core-plans-rfcs/blob/master/_RFCs/0009-plan-configuration-complexity.md) for more details.

- [ ] Service runs with provided defaults (if applicable)
