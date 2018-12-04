# Habitat package: vault

## Maintainers
* [Christopher P. Maher](https://github.com/defilan)

## Description
[Vault](https://www.vaultproject.io/) secures, stores, and tightly controls access to tokens, passwords, certificates, API keys, and other secrets in modern computing. Vault handles leasing, key revocation, key rolling, and auditing.

This plan provides the static binary for execution, as well as the service.

## Usage
This package contains Vault. To use Vault properly, you need to provide it
with a valid backend, for example [Consul](https://consul.io). By default, this
package is set to run Vault in "dev" mode, a simple setup solely for experimenting and testing.

Warning: Never, ever, ever run a "dev" mode server in production. It is insecure and will lose data on every restart (since it stores data in-memory). It is only made for development or experimentation.

## Topology
Vault can be deployed either in a `standalone` topology or in a multi-node
`leader` topology. There are multiple ways to make this work, with your needs
and HA requirements driving the configuration.

```text
hab start core/vault
```

## Update Strategy

Recommended update strategy for Vault is `rolling`.

## BREAKING CHANGES FROM 1.0.0

Vault >=1.0.0 introduced changes in the Habitat plan in order to simplify default configuration and reduce dependencies. This makes adoption and maintenance easier, and aligns with recent RFCs for plan development.

If you have upgraded to Vault 1.0.0 from Vault 0.*, you will notice that the default storage backend has changed from consul to file based.

In order to continue using the consul storage backend, a configuration/wrapper plan must be created to provide your own custom configuration.
