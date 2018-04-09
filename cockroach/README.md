# CockroachDB

This plan provides for the installation of [Cockroach Labs](https://www.cockroachlabs.com)' [CockroachDB](https://github.com/cockroachdb/cockroach). It currently only replaces the installation step and does not provide any configuration management or supervision.

To get started, follow the [official getting started guide](https://www.cockroachlabs.com/docs/stable/start-a-local-cluster.html), substituting `hab pkg exec core/cockroach cockroach` in place of the bare `cockroach` command:

## Quick start

- Start single node:

    ```bash
    hab pkg exec core/cockroach cockroach start --insecure --host=localhost &
    ```
- Open web UI at http://localhost:8080
- Connect with included command-line SQL client:

    ```bash
    hab pkg exec core/cockroach cockroach sql --insecure
    ```
- Test some SQL:

    ```sql
    CREATE DATABASE bank;
    CREATE TABLE bank.accounts (id INT PRIMARY KEY, balance DECIMAL);
    INSERT INTO bank.accounts VALUES (1, 1000.50);
    SELECT * FROM bank.accounts;
    ```

- Quit the SQL client with the command `\q`
