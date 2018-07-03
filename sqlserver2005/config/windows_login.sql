IF NOT EXISTS(SELECT name FROM sys.server_principals WHERE name = '{{cfg.app_user}}')
  create login [{{cfg.app_user}}] FROM WINDOWS
IF NOT EXISTS(SELECT name FROM sys.database_principals WHERE name = '{{cfg.app_user}}')
  create user [{{cfg.app_user}}] for login [{{cfg.app_user}}]
grant CREATE DATABASE to [{{cfg.app_user}}]
