# Habitat package: consul

## Description

[OpenVPN](https://openvpn.net/) provides flexible VPN solutions to secure your data communications.

This plan attempts to provide a single plan to configure both server and client.

## Usage

```
hab svc load core/openvpn
```

You must at least provide SSL/TLS root certificate (ca), certificate (cert), and private key (key). As well as Diffie hellman parameters.  Each client and the server must have their own cert and key file. The server and all clients will use the same ca and dh files.

### Certificates

We don't generate or provide any keys or certificates for OpenVPN. You'll need to generate your own and populate the server. You can do that with Habitat using the `file upload` command. Or by injecting them directly into
`/hab/user/openvpn/config/user.toml`.

#### Uploading with `hab file upload`

On the system that is to run OpenVPN:

```
hab service key generate openvpn.default ORGNAME
hab start core/openvpn --group default --org ORGNAME
```

On the local system that has the OpenVPN keys/certificates (e.g., a laptop/workstation), copy the generated `openvpn.default@ORGNAME-timestamp.pub` file (e.g., in `/hab/cache/keys`) to the local system to the key cache (e.g., `~/.hab/cache/keys`). Then do the following:

```
hab user key generate USERNAME
```

Copy the generated `USERNAME-timestamp.pub` to the OpenVPN system key cache (e.g., `/hab/cache/keys`). Then upload the OpenVPN certificates and keys.

```
for i in ca.crt server.crt server.key dh.pem
do
  hab file upload --org ORGNAME --peer 172.17.0.4 openvpn.default $i 1 USERNAME
done
```
