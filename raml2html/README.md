[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.raml2html?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=186&branchName=master)

# raml2html

RAML to HTML documentation generator.

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/raml2html as a depdendency, you can add one of the following to your plan file.

##### Buildtime Dependency

> pkg_build_deps=(core/raml2html)

##### Runtime Depdendency

> pkg_deps=(core/raml2html)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

`hab pkg install core/raml2html`

> » Installing core/raml2html

>☁ Determining latest version of core/raml2html in the 'stable' channel

> ☛ Verifying core/raml2html/6.3.0/20200319193104

> ✓ Installed core/raml2html/6.3.0/20200319193104

> ★ Install of core/raml2html/6.3.0/20200319193104 complete with 4 new packages installed.

`hab pkg binlink core/raml2html`

> » Binlinking raml2html from core/raml2html into /bin

> ★ Binlinked raml2html from core/raml2html/6.3.0/20200319193104 to /bin/raml2html

#### Using an example binary
You can now use the binary as normal:

`/bin/raml2html --help` or `raml2html --help`

```
Usage: raml2html [options] [RAML input file]

Options:
  --version       Show version number                                  [boolean]
  -h, --help      Show help                                            [boolean]
  -i, --input     Input file                                            [string]
  -o, --output    Output file                                           [string]
  -t, --template  Template path                                         [string]
  -v, --validate  Validate RAML and examples (off by default)          [boolean]
  --theme         Theme name                                            [string]

Examples:
  raml2html example.raml > example.html
  raml2html --theme raml2html-markdown-theme example.raml > example.html
  raml2html --template my-template.nunjucks -i example.raml -o example.html
```
