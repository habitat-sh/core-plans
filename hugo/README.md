[![Build Status](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_apis/build/status/chef-base-plans.hugo?branchName=master)](https://dev.azure.com/chefcorp-partnerengineering/Chef%20Base%20Plans/_build/latest?definitionId=219&branchName=master)

# hugo

Hugo is a static HTML and CSS website generator written in Go. It is optimized for speed, ease of use, and configurability. Hugo takes a directory with content and templates and renders them into a full HTML website.  Hugo relies on Markdown files with front matter for metadata, and you can run Hugo from any directory. This works well for shared hosts and other systems where you don’t have a privileged account.  Hugo renders a typical website of moderate size in a fraction of a second. A good rule of thumb is that each piece of content renders in around 1 millisecond.  Hugo is designed to work well for any kind of website including blogs, tumbles, and docs.  See [documentation](https://gohugo.io)

## Maintainers

* The Core Planners: <chef-core-planners@chef.io>

## Type of Package

Binary package

### Use as Dependency

Binary packages can be set as runtime or build time dependencies. See [Defining your dependencies](https://www.habitat.sh/docs/developing-packages/developing-packages/#sts=Define%20Your%20Dependencies) for more information.

To add core/hugo as a dependency, you can add one of the following to your plan file.

#### Buildtime Dependency

> pkg_build_deps=(core/hugo)

#### Runtime dependency

> pkg_deps=(core/hugo)

### Use as Tool

#### Installation

To install this plan, you should run the following commands to first install, and then link the binaries this plan creates.

``hab pkg install core/hugo --binlink``

will add the following binary to the PATH:

* /bin/hugo

For example:

```bash
$ hab pkg install core/hugo --binlink
» Installing core/hugo
☁ Determining latest version of core/hugo in the 'stable' channel
→ Found newer installed version (core/hugo/0.72.0/20200918115600) than remote version (core/hugo/0.72.0/20200621233854)
→ Using core/hugo/0.72.0/20200918115600
★ Install of core/hugo/0.72.0/20200918115600 complete with 0 new packages installed.
» Binlinking hugo from core/hugo/0.72.0/20200918115600 into /bin
★ Binlinked hugo from core/hugo/0.72.0/20200918115600 to /bin/hugo
[7][default:/src/hugo:0]#
```

#### Using an example binary

You can now use the binary as normal.  For example:

``/bin/hugo --help`` or ``hugo --help``

```bash
$ hugo --help
hugo is the main command, used to build your Hugo site.

Hugo is a Fast and Flexible Static Site Generator
built with love by spf13 and friends in Go.

Complete documentation is available at http://gohugo.io/.

Usage:
  hugo [flags]
  hugo [command]

Available Commands:
  config      Print the site configuration
  convert     Convert your content to different formats
  deploy      Deploy your site to a Cloud provider.
  env         Print Hugo version and environment info
  gen         A collection of several useful generators.
  help        Help about any command
...
...
```
