# Habitat Package: core/jenkins

## Description

- [Jenkins Website](https://jenkins.io)
- [Jenkins Documentation](https://jenkins.io/doc/)

> Jenkins is a self-contained, open source automation server which can
> be used to automate all sorts of tasks such as building, testing,
> and deploying software. Jenkins can be installed through native
> system packages, Docker, or even run standalone by any machine with
> the Java Runtime Environment installed.

## Usage

### Starting

```
hab sup start core/jenkins
```

### Initial Password

On first login, you will be asked for an initial admin password. This is
generated automatically, and output in the supervisor log (check with
`sup-log`), and is also available on disk at
`/hab/svc/jenkins/data/secrets/initialAdminPassword`.

## Notes

By default, this package is configured for plain HTTP and is intended
for usage in secure environment.
