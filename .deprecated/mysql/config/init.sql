DELETE FROM mysql.user WHERE USER LIKE '';
{{~#if svc.me.leader}}
-- Enable remote root access if in a topology, be sure to protect access via firewalls
-- this host is a leader
UPDATE mysql.user SET {{cfg.password_column_name}}=PASSWORD('{{cfg.root_password}}'), password_expired='N', host='%' WHERE user = 'root';
{{else}}
{{~#if svc.me.follower}}
-- Enable remote root access if in a topology, be sure to protect access via firewalls
-- this host is a follower
UPDATE mysql.user SET {{cfg.password_column_name}}=PASSWORD('{{cfg.root_password}}'), password_expired='N', host='%' WHERE user = 'root';
{{~/if}}
-- Disable remote root access by default for a standalone mysql node
UPDATE mysql.user SET {{cfg.password_column_name}}=PASSWORD('{{cfg.root_password}}'), password_expired='N', host='127.0.0.1' WHERE user = 'root';
DELETE FROM mysql.user WHERE user = 'root' and host NOT IN ('127.0.0.1', 'localhost');
{{~/if}}
{{~#if cfg.app_username}}
CREATE USER '{{cfg.app_username}}'@'%' IDENTIFIED BY '{{cfg.app_password}}';
GRANT ALL PRIVILEGES ON *.* TO '{{cfg.app_username}}'@'%';
{{~/if}}
FLUSH PRIVILEGES;
DELETE FROM mysql.db WHERE db LIKE 'test%';
DROP DATABASE IF EXISTS test;
