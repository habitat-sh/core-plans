# Habitat package: consul

## Description

[Consul](1) is Service Discovery and Configuration Made Easy.

This plan provides the static binary for execution.

## Usage

```
hab svc load core/consul
```

### Enable ACLs

To enable ACLs add the `[acl]` stanza to `default.toml`

```toml
[acl]
enabled = true
default_policy = "deny"
down_policy = "extend-cache"
```

Sub hashes can be described in standard TOML format:

```
[acl]
enabled = true
default_policy = "deny"
down_policy = "extend-cache"
tokens.master = "b1gs33cr3t"
tokens.agent = "da666809-98ca-0e94-a99c-893c4bf5f9eb"
```

Would render as:

```json
  "acl" : {
    "enabled" : true,
    "default_policy" : "deny",
    "down_policy" : "extend-cache",
    "tokens" : {
      "master" : "b1gs33cr3t",
      "agent" : "da666809-98ca-0e94-a99c-893c4bf5f9eb"
    }
  }
```

## Topology

Consul can be deployed as a single node for testing, with `standalone` topology, or in a multi-node setup also as `standalone`. The nodes share the same configuration, and can utilize service member IP addresses for [consul join commands](2) or using the [start_join configuration](2) options.

## Update Strategy

Recommended update strategy for Consul is `rolling`.

[1]: https://consul.io
[2]: https://www.consul.io/docs/guides/bootstrapping.html
