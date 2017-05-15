Cassandra plan for habitat
==========================

This plan contains a default configuration for Cassandra. SSL support is
off, and legacy endpoint `thrift` is also off.
It provides a simple way to connects node together by using the standalone
topology [see this section for multi node](#multi-node-setup)

Activate SSL
------------

To activate secure connection to the Cassandra cluster you need to fill some
requirements.
First, you need to activate the following options, in your config.toml file

```toml
[native_transport]
port_ssl = 9142
[encryption.client]
enabled = true
optional = true # you can force ssl by setting this to false
keystore = "{{pkg.svc_config_path}}/.keystore"
keystore_password = "cassandra"
```

Generate and add ssl certs to the keystore following those steps
http://docs.datastax.com/en/cassandra/3.0/cassandra/configuration/secureSSLCertificates.html



Multi Node Setup
----------------

You can simply connect together in habitat throught the standalone topology.

```bash
# node 1
hab start core/cassandra

# node 2
hab start --peer=172.17.0.1 core/cassandra # where 172... is the ip of the first node
```

However, this setup is not recommended for huge cluster size in production.
See next section for more informations:

### Custom node registration

Binding to Cassandra
--------------------

You can bind to Cassandra other service with habitat. This plan expose
multiple services which you can bind to.

- `port`: default port for CQL client connection
- `ssl-port`: ssl port for encrypted CQL client connection, see [the ssl section](#activate-ssl)
- `thrift-port`: legacy thrift client endpoint, disabled by default.
