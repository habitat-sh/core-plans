# scaffolding-base

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Usage

A scaffolding for building Chef Policyfiles into executable habitat packages.

```bash
scaffold_policy_name="base"
pkg_name="chef-base"
pkg_origin=chefdorf
pkg_version="0.1.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Apache-2.0")
pkg_description="The Chef $scaffold_policy_name Policy"
pkg_upstream_url="http://chef.io"
pkg_scaffolding="core/scaffolding-chef"
```

Will take a `policyfiles/base.rb` and build it. The scaffolding expects that
the plan itself will live in a directory that is up to 3 levels above the
policyfiles directory.

The resulting artifact can be installed, and the service will run chef-client
with this policyfile.

