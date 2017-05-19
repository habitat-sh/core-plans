# Habitat Package: core/jenkins
The Habitat Maintainers <humans@habitat.sh>

## Description

- [www](https://jenkins.io)
- [Docs](https://jenkins.io/doc/)

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

## Notes

- By default, this package is configured for plain HTTP and is
  intended for usage in secure environment.
  - On first run, you will be asked for an initial admin password. Run
  `slog` inside the studio to obtain this.
