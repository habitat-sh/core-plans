# Jenkins

[Jenkins][jenkins] is a self-contained, open source automation server which can be used to automate all sorts of tasks such as building, testing, and deploying software.

## Maintainers

* The Habitat Maintainers <humans@habitat.sh>

## Type of Package

Service package

## Usage

Start the service with Habitat:

```
hab sup start core/jenkins
```

### Initial Password

On first login, you will be asked for an initial admin password. This is generated automatically, and output in the supervisor log (check with `sup-log`), and is also available on disk at `/hab/svc/jenkins/data/secrets/initialAdminPassword`.

## Topologies

Deploy Jenkins in a `standalone` topology, or leave it empty (default).

## Update Strategies

An `at-once` update strategy, or none work for Jenkins.

## Notes

By default, this package is configured for plain HTTP and is intended for usage in secure environment.

## Port

This plan uses port `8080` for HTTP and `8443` for HTTPS by default.

Previous versions of this plan used port 80 and 443. Upgrading from a pervious version may yield unexpected connection issues if you're expecting this to service on port 80/443.

[jenkins]: https://jenkins.io
