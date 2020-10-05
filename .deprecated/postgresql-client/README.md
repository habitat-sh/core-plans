# Habitat package: postgresql-client

## Description

This plan provides the client binaries for Postgresql.  It can be used both as a client for `core/postgresql` as well as standalone pgsql installations.  Just as with `core/postgresql` there are versions that match every point version of Postgres.

## Usage

This mostly provides the postgres binaries (`psql`, `createdb`, etc) to other applications, but users can use/test it via
`hab pkg exec core/postgresql-client psql <args>`
