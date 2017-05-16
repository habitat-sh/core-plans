pkg_name=aws-cli
pkg_origin=core
pkg_version=1.11.76
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=('Apache-2.0')
pkg_description="The AWS Command Line Interface (CLI) is a unified tool to \
  manage your AWS services. With just one tool to download and configure, you \
  can control multiple AWS services from the command line and automate them \
  through scripts."
pkg_upstream_url=https://aws.amazon.com/cli/
pkg_source=nosuchfile.tgz
pkg_deps=(
  core/groff
)
pkg_scaffolding=core/scaffolding-python
pkg_scaffolding_python_pip_name=awscli
