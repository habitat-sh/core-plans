# Vault

[Vault](https://www.vaultproject.io/) secures, stores, and tightly controls access to tokens, passwords, certificates, API keys, and other secrets in modern computing. Vault handles leasing, key revocation, key rolling, and auditing.

This plan provides the static binary for execution.

## Maintainers

* The Habitat Maintainers humans@habitat.sh
* [Christopher P. Maher](https://github.com/defilan)
* [Daniel B. Hagen](https://github.com/dbhagen)

## Type of Package

Service

## Usage

This package contains Vault. To use Vault properly, you need to provide it
with a valid backend, for example [Consul](https://consul.io). By default, this
package is set to run Vault in "dev" mode, a simple setup solely for experimenting and testing.

> <span style="color:red">**Warning:**</span> Never, ever, ever run a "dev" mode server in production. It is insecure and will lose data on every restart (since it stores data in-memory). It is only made for development or experimentation.

## Bindings

To Be Added.

## Topologies

Vault can be deployed either in a `Standalone` topology or in a multi-node
`Leader/Follower` topology. There are multiple ways to make this work, with your needs
and HA requirements driving the configuration.

```text
hab start core/vault
```

### Standalone

To Be Added.

### Leader-Follower

To Be Added.

## Update Strategies

The recommended update strategy for Vault is `rolling`.

### Configuration Updates

Checkout the [configuration update](https://www.habitat.sh/docs/using-habitat/#configuration-updates) documentation for more information on what configuration updates are and how they are executed.

View the [Default.toml](https://github.com/habitat-sh/core-plans/blob/master/vault/default.toml)

## Scaling

To Be Added.

## Monitoring

To Be Added.

## Notes

(Optional)
