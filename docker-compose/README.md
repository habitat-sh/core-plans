# Docker Compose

[Compose](https://docs.docker.com/compose/) is a tool for defining and running multi-container Docker applications.

## Maintainers

The Habitat Maintainers humans@habitat.sh

## Type of Package

[binary wrapper package](https://www.habitat.sh/docs/best-practices/#binary-wrapper-packages)

## Usage

```bash
hab pkg install core/docker-compose
hab pkg binlink core/docker-compose docker-compose   # do not try to binlink all the python deps

docker-compose --version
```
