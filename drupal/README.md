# Habitat Package: Crate
The Habitat Maintainers <humans@habitat.sh>

## Description

- [www](https://www.drupal.org)
- [Docs](https://www.drupal.org/documentation/

> Drupal is content management software. It's used to make many of the
> websites and applications you use every day.

Drupal has great standard features, like easy content authoring,
reliable performance, and excellent security. But what sets it apart
is its flexibility; modularity is one of its core principles. Its
tools help you build the versatile, structured content that dynamic
web experiences need.

## Usage

### Starting

```
hab start core/drupal --bind database:<database service group> --peer <ip of database service group supervisor>
```

### Stopping

```
hab sup stop core/nginx
hab sup stop core/drupal
```

By default, Drupal will be available on port 80.

### Notes

- This package requires a running instance of `core/mysql` to bind to.
- After starting the service the user is provided with a new Drupal site with preconfigured admin username and password.