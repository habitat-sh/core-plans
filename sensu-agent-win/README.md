# Habitat package: sensu-agent-win

## Description

This plan installs & configures the `sensu-agent-win`.

## Usage

The sensu agent should be using in conjunction with one or more sensu backends. It can be configured to work with a backend via service bindings or through the package configuration.

Ex:
```bash
  hab sup run core/sensu-agent-win --bind backend:sensu-backend.default --peer some.ip --topology standalone --strategy at-once
```

See also: configuring the sensuctl to work with the backend

https://docs.sensu.io/sensu-core/2.0/getting-started/configuring-sensuctl/
