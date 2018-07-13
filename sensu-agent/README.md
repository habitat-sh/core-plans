# Habitat package: sensu-agent

## Description

This plan installs & configures the `sensu-agent`.

## Usage

The sensu agent should be using in conjunction with one or more sensu backends. It can be configured to work with a backend via service bindings or through the package configuration.

Ex:
```bash
  hab sup run core/sensu-agent --bind backend:sensu-backend.default --peer some.ip --topology standalone --strategy at-once
```


## Testing

To test out the plan locally, install the [kitchen-habitat](https://github.com/test-kitchen/kitchen-habitat) plugin and run `kitchen converge` to create a sensu backend with 2 sensu-agents that are bound to it.

See also: configuring the sensuctl to work with the backend

https://docs.sensu.io/sensu-core/2.0/getting-started/configuring-sensuctl/
