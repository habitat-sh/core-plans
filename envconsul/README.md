# Habitat package: envconsul

## Description

This plan provides the envconsul CLI package. `envconsul` is a tool, written in Go, used to inject
configuration values from HashiCorp's Consul or Vault.

## Usage

```
hab pkg exec core/envconsul envconsul -h
Usage:  [options] <command>

  Watches values from Consul's K/V store and Vault secrets to set environment
  variables when the values are changed. It spawns a child process populated
  with the environment variables.

Options:

  -config=<path>
      Sets the path to a configuration file or folder on disk. This can be
      specified multiple times to load multiple files or folders. If multiple
      values are given, they are merged left-to-right, and CLI arguments take
      the top-most precedence.

  -consul-addr=<address>
      Sets the address of the Consul instance

  -consul-auth=<username[:password]>
      Set the basic authentication username and password for communicating
      with Consul.

  -consul-retry
      Use retry logic when communication with Consul fails

  -consul-retry-attempts=<int>
      The number of attempts to use when retrying failed communications

  -consul-retry-backoff=<duration>
      The base amount to use for the backoff duration. This number will be
      increased exponentially for each retry attempt.

  -consul-retry-max-backoff=<duration>
      The maximum limit of the retry backoff duration. Default is one minute.
      0 means infinite. The backoff will increase exponentially until given value.

  -consul-ssl
      Use SSL when connecting to Consul

  -consul-ssl-ca-cert=<string>
      Validate server certificate against this CA certificate file list

  -consul-ssl-ca-path=<string>
      Sets the path to the CA to use for TLS verification

  -consul-ssl-cert=<string>
      SSL client certificate to send to server

  -consul-ssl-key=<string>
      SSL/TLS private key for use in client authentication key exchange

  -consul-ssl-server-name=<string>
      Sets the name of the server to use when validating TLS.

  -consul-ssl-verify
      Verify certificates when connecting via SSL

  -consul-token=<token>
      Sets the Consul API token

  -consul-transport-dial-keep-alive=<duration>
      Sets the amount of time to use for keep-alives

  -consul-transport-dial-timeout=<duration>
      Sets the amount of time to wait to establish a connection

  -consul-transport-disable-keep-alives
      Disables keep-alives (this will impact performance)

  -consul-transport-max-idle-conns-per-host=<int>
      Sets the maximum number of idle connections to permit per host

  -consul-transport-tls-handshake-timeout=<duration>
      Sets the handshake timeout

  -exec=<command>
      Enable exec mode to run as a supervisor-like process - the given command
      will receive all signals provided to the parent process and will receive a
      signal when templates change

  -exec-kill-signal=<signal>
      Signal to send when gracefully killing the process

  -exec-kill-timeout=<duration>
      Amount of time to wait before force-killing the child

  -exec-reload-signal=<signal>
      Signal to send when a reload takes place

  -exec-splay=<duration>
      Amount of time to wait before sending signals

  -kill-signal=<signal>
      Signal to listen to gracefully terminate the process

  -log-level=<level>
      Set the logging level - values are "debug", "info", "warn", and "err"

  -max-stale=<duration>
      Set the maximum staleness and allow stale queries to Consul which will
      distribute work among all servers instead of just the leader

  -once
      Do not run the process as a daemon

  -pid-file=<path>
      Path on disk to write the PID of the process

  -prefix=<prefix>
      A prefix to watch, multiple prefixes are merged from left to right, with
      the right-most result taking precedence, including any values specified
      with -secret

  -pristine
      Only use values retrieved from prefixes and secrets, do not inherit the
      existing environment variables

  -reload-signal=<signal>
      Signal to listen to reload configuration

  -sanitize
      Replace invalid characters in keys to underscores

  -secret=<prefix>
      A secret path to watch in Vault, multiple prefixes are merged from left
      to right, with the right-most result taking precedence, including any
      values specified with -prefix

  -syslog
      Send the output to syslog instead of standard error and standard out. The
      syslog facility defaults to LOCAL0 and can be changed using a
      configuration file

  -syslog-facility=<facility>
      Set the facility where syslog should log - if this attribute is supplied,
      the -syslog flag must also be supplied

  -upcase
      Convert all environment variable keys to uppercase

  -vault-addr=<address>
      Sets the address of the Vault server

  -vault-grace=<duration>
      Sets the grace period between lease renewal and secret re-acquisition - if
      the remaning lease duration is less than this value, Consul Template will
      acquire a new secret from Vault

  -vault-renew-token
      Periodically renew the provided Vault API token - this defaults to "true"
      and will renew the token at half of the lease duration

  -vault-retry
      Use retry logic when communication with Vault fails

  -vault-retry-attempts=<int>
      The number of attempts to use when retrying failed communications

  -vault-retry-backoff=<duration>
      The base amount to use for the backoff duration. This number will be
      increased exponentially for each retry attempt.

  -vault-retry-max-backoff=<duration>
      The maximum limit of the retry backoff duration. Default is one minute.
      0 means infinite. The backoff will increase exponentially until given value.

  -vault-ssl
      Specifies whether communications with Vault should be done via SSL

  -vault-ssl-ca-cert=<string>
      Sets the path to the CA certificate to use for TLS verification

  -vault-ssl-ca-path=<string>
      Sets the path to the CA to use for TLS verification

  -vault-ssl-cert=<string>
      Sets the path to the certificate to use for TLS verification

  -vault-ssl-key=<string>
      Sets the path to the key to use for TLS verification

  -vault-ssl-server-name=<string>
      Sets the name of the server to use when validating TLS.

  -vault-ssl-verify
      Enable SSL verification for communications with Vault.

  -vault-token=<token>
      Sets the Vault API token

  -vault-transport-dial-keep-alive=<duration>
      Sets the amount of time to use for keep-alives

  -vault-transport-dial-timeout=<duration>
      Sets the amount of time to wait to establish a connection

  -vault-transport-disable-keep-alives
      Disables keep-alives (this will impact performance)

  -vault-transport-max-idle-conns-per-host=<int>
      Sets the maximum number of idle connections to permit per host

  -vault-transport-tls-handshake-timeout=<duration>
      Sets the handshake timeout

  -vault-unwrap-token
      Unwrap the provided Vault API token (see Vault documentation for more
      information on this feature)

  -wait=<duration>
      Sets the 'min(:max)' amount of time to wait before writing a template (and
      triggering a command)

  -v, -version
      Print the version of this daemon
```
