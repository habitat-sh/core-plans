UPDATE mysql.user SET {{cfg.password_column_name}}=PASSWORD('{{cfg.root_password}}'), password_expired='N', host='127.0.0.1' WHERE user = 'root';
DELETE FROM mysql.user WHERE USER LIKE '';
DELETE FROM mysql.user WHERE user = 'root' and host NOT IN ('127.0.0.1', 'localhost');
{{#if cfg.app_username}}
CREATE USER '{{cfg.app_username}}'@'%' IDENTIFIED BY '{{cfg.app_password}}';
GRANT ALL PRIVILEGES ON *.* TO '{{cfg.app_username}}'@'%';
{{/if}}
FLUSH PRIVILEGES;
DELETE FROM mysql.db WHERE db LIKE 'test%';
DROP DATABASE IF EXISTS test ;
