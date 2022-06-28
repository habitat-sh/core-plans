[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.aws-cli?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=99&branchName=master)

# AWS CLI

The [AWS Command Line Interface](https://aws.amazon.com/cli/) (CLI) is a unified tool to manage your AWS services. With just one tool to download and configure, you can control multiple AWS services from the command line and automate them through scripts.

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

[binary wrapper package](https://www.habitat.sh/docs/best-practices/#binary-wrapper-packages)

## Usage

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/aws-cli as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/aws-cli)

##### Runtime Depdendency

> pkg_deps=(core/aws-cli)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

`hab pkg install core/aws-cli`

> » Installing core/aws-cli
>
>☁ Determining latest version of core/aws-cli in the 'stable' channel
>
> ↓ Downloading core/aws-cli/1.18.25/20200319204505
>
> ☛ Verifying core/aws-cli/1.18.25/20200319204505
>
> ...
>
> ✓ Installed core/aws-cli/1.18.25/20200319204505
>
> ★ Install of core/aws-cli/1.18.25/20200319204505 complete with 3 new packages installed.

`hab pkg binlink core/aws-cli`

> » Binlinking aws.cmd from core/aws-cli into /bin
>
> ★ Binlinked aws.cmd from core/aws-cli/1.18.25/20200319204505 to /bin/aws.cmd

#### Using an example binary
You can now use the binary as normal:

`/bin/aws --help` or `aws --help`

```
AWS()                                                                    AWS()



NAME
       aws -

DESCRIPTION
       The  AWS  Command  Line  Interface is a unified tool to manage your AWS
       services.

SYNOPSIS
          aws [options] <command> <subcommand> [parameters]

       Use aws command help for information on a  specific  command.  Use  aws
       help  topics  to view a list of available help topics. The synopsis for
       each command shows its parameters and their usage. Optional  parameters
       are shown in square brackets.
...
```
