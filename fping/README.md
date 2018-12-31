# fping

  fping is a program to send ICMP echo probes to network hosts, similar to
  ping, but much better performing when pinging multiple hosts. fping has a
  long long story: Roland Schemers did publish a first version of it in 1992
  and it has established itself since then as a standard tool.

## Maintainers

* The Habitat Maintainers: <humans@habitat.sh>

## Type of Package

Binary package

## Usage

This package needs the file `/etc/protocols` from the `core/iana-etc` package.
Add this to your plan/hooks:

```
if [[ ! -f /etc/protocols ]]; then
  hab pkg install core/iana-etc
  ln -s $(hab pkg path core/iana-etc)/etc/protocols /etc/protocols
fi
```
