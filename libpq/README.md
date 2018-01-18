# Habitat Package: libpq
The Habitat Maintainers humans@habitat.sh

## Description
Habitat package for the client side libraries of postgresql, including
libpq and the psql command line client utility.

This is a subset of the postgresql habitat package, leaving out much
of the server side code and postgis support. It is intended to be a
lightweight package for client side applications, providing both the
build and runtime dependencies for clients.

Postgresql-client was considered as a name, to follow mysql-client, but in
the end the libpq-dev debian package came the closest to what this
provides.
