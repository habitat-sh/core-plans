# Moodle #

## Building Habitat packages for Moodle ##

Let's assume:
* a working habitat studio
* default origin is set to 'core'
* command are executed from working directory: `/src/` inside the studio

### Build the package ###

* Build the required packages

```shell
build php5
build moodle-proxy
build moodle
```

### Start Moodle using the Supervisor ###

* Create a toml file to properly configure core/mysql

```shell
cat<<EOF > /src/mysql_moodle.toml
app_username = 'moodleroot'
app_password = 'S3cret'
root_password = 'SuperS3cret'
EOF
```

* Stop (just to be sure) and start the supervisor and apply the configuration

```shell
sup-term
sup-run
hab config apply mysql.default $(date +%s) mysql_moodle.toml
```

* Start core/mysql (optionally, test the connection)

```shell
hab start core/mysql
hab pkg exec core/mysql-client mysql -umoodleroot -pS3cret -h127.0.0.1
# debug tip: have a look at /hab/svc/mysql/config/init.sql to see if users are set up correctly
```

* Start nginx (optionally test if the web server is listening)

```shell
hab start core/moodle-proxy
hab pkg exec core/curl curl 127.0.0.1
# should give output: 502 Bad Gateway
```

* Start moodle

```shell
hab start core/moodle --bind database:mysql.default
sup-log
```

### Quickly do a clean restart (after rebuilding a package for example) ###

```shell
sup-term # stop supervisor
rm -rf /hab/svc/{moodle,moodle-proxy,mysql} # remove all files of previously started services (will be recreated)
sup-run # start the supervisor
hab config apply mysql.default $(date +%s) mysql_moodle.toml # apply the mysql configuration
hab start core/mysql # start mysql
hab start core/moodle-proxy # start the nginx proxy
hab start core/moodle --bind database:mysql.default # start php-fpm for moodle
sup-log # see the output
```
