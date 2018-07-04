# Drupal
- [Drupal Website](https://www.drupal.org)

Drupal is content management software. It's used to make many of the websites
and applications you use every day. Drupal has great standard features, like
easy content authoring, reliable performance, and excellent security. But what
sets it apart is its flexibility; modularity is one of its core principles. Its
tools help you build the versatile, structured content that dynamic web
experiences need.

## Maintainers
- The Habitat Maintainers: [humans@habitat.sh](mailto:humans@habitat.sh)

## Type of Package
Composite:
- drupal-app: core/php (FPM) + Drupal-specific configuration
- drupal-http: core/nginx + Drupal PHP code + Drupal-specific configuration

This package can be optionally bound to `core/mysql` for extra convenience when
first launching the service.

## Usage

> hab svc load core/drupal
> or
> hab svc load core/drupal --bind [core/mysql details here]
