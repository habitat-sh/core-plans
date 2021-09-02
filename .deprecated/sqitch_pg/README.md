# sqitch_pg
This is a Habitat plan for [Sqitch](http://sqitch.org/) with [DBD-Pg](http://search.cpan.org/dist/DBD-Pg/) which is used to do database deploys to PostgreSQL.

## Maintainers
The Habitat Maintainers humans@habitat.sh

## Type of Package

This is a hybrid binary + library package, designed to make it easy to install Sqitch for PostgreSQL with a single package definition.

## Usage

Install this package by running:
```
hab pkg install -b core/sqitch_pg
```

Run this package like so:
```
cd your_schema_folder
hab pkg exec core/sqitch_pg sqitch --engine pg deploy "db:pg://${USER}:${PASS}@${HOST}/$DB"
```

For a complete example, see [this db-migrations script](https://github.com/chef/chef-server/blob/master/src/bookshelf/habitat/config/database-migrations.sh)
