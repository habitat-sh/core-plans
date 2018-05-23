# Habitat package: RethinkDB

## Description

[RethinkDB](1) is an open-source database for the realtime web.

## Usage

```
hab svc load core/rethinkdb
```

## Bindings

This plan exports three ports for consumers to access:

`http-port` is the web based administration port, for accessing the admin tool.

`driver-port` is used for RethinkDB clients to connect and communicate with the database. Your application will likely want to use this for primary communication.

`cluster-port` is used for inter-node communication between RethinkDB server nodes.

## Topology

RethinkDB can be deployed as a single node with `standalone` topology, or in a multi-node setup to achieve [clustering, replication and sharding][2] as required for your application / data.

## Update Strategy

Recommended update strategy is `rolling`.

[1]: https://www.rethinkdb.com
[2]: https://www.rethinkdb.com/docs/sharding-and-replication/
