# Monit

This plan packages [monit](https://mmonit.com/monit), a monitoring agent with powers (it can restart processes on failure and so on).

## Usage

When using monit, you'll want to add your own rules, this cannot be done with this package. You'll need to create your own which would depend on this one. The configuration is provided as a model for you to speed up your package development.

## Plan supporter

Romain Sertelon @rsertelon

Acknowledgement: @jlebloas contributed some changes to the run hook
