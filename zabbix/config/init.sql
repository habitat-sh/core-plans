UPDATE mysql.user SET {{cfg.mysql.password_column_name}}=PASSWORD('{{cfg.mysql.root_password}}'), password_expired='N' WHERE user = 'root';
DELETE FROM mysql.user WHERE USER LIKE '';
DELETE FROM mysql.user WHERE user = 'root' and host NOT IN ('127.0.0.1', 'localhost');
FLUSH PRIVILEGES;
DELETE FROM mysql.db WHERE db LIKE 'test%';
DROP DATABASE IF EXISTS test ;
