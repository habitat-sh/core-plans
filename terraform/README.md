[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.terraform?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=286&branchName=master)

# terraform

Terraform is a tool for building, changing, and combining infrastructure safely and efficiently.  See [documentation](https://www.terraform.io/docs/index.html)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/terraform as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/terraform)

#### Runtime dependency

> pkg_deps=(core/terraform)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/terraform --binlink``

will add the following binaries to the PATH:

* /bin/terraform

For example:

```bash
$ hab pkg install core/terraform --binlink
» Installing core/terraform
☁ Determining latest version of core/terraform in the 'stable' channel
→ Found newer installed version (core/terraform/0.12.26/20200928151023) than remote version (core/terraform/0.12.26/20200601204523)
→ Using core/terraform/0.12.26/20200928151023
★ Install of core/terraform/0.12.26/20200928151023 complete with 0 new packages installed.
» Binlinking terraform from core/terraform/0.12.26/20200928151023 into /bin
★ Binlinked terraform from core/terraform/0.12.26/20200928151023 to /bin/terraform
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/terraform --help`` or ``terraform --help``

```bash
$ terraform --help
Usage: terraform [-version] [-help] <command> [args]

The available commands for execution are listed below.
The most common, useful commands are shown first, followed by
less common or more advanced commands. If you're just getting
started with Terraform, stick with the common commands. For the
other commands, please read the help and docs before usage.

Common commands:
    apply              Builds or changes infrastructure
    console            Interactive console for Terraform interpolations
    destroy            Destroy Terraform-managed infrastructure
...
...
```
