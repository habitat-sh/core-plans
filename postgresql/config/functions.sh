init_pgpass() {
  export PGPASSFILE="{{pkg.svc_config_path}}/.pgpass"
  chmod 0600 {{pkg.svc_config_path}}/.pgpass
}

ensure_dir_ownership() {
  echo 'Making sure hab user owns var, config and data paths'
  chown -RL hab:hab {{pkg.svc_var_path}}
  chown -RL hab:hab {{pkg.svc_config_path}}
  chown -RL hab:hab {{pkg.svc_data_path}}
}

write_local_conf() {
  echo 'Writing postgresql.local.conf file based on memory settings'
  cat > {{pkg.svc_config_path}}/postgresql.local.conf<<LOCAL
# Auto-generated memory defaults created at service start by Habitat
effective_cache_size=$(awk '/MemTotal/ {printf( "%.0f\n", ($2 / 1024 / 4) *3 )}' /proc/meminfo)MB
shared_buffers=$(awk '/MemTotal/ {printf( "%.0f\n", $2 / 1024 / 4 )}' /proc/meminfo)MB
maintenance_work_mem=$(awk '/MemTotal/ {printf( "%.0f\n", $2 / 1024 / 16 )}' /proc/meminfo)MB
work_mem=$(awk '/MemTotal/ {printf( "%.0f\n", (($2 / 1024 / 4) *3) / ({{cfg.max_connections}} *3) )}' /proc/meminfo)MB
temp_buffers=$(awk '/MemTotal/ {printf( "%.0f\n", (($2 / 1024 / 4) *3) / ({{cfg.max_connections}}*3) )}' /proc/meminfo)MB
LOCAL
}

write_env_var() {
  echo "$1" > "{{pkg.svc_config_path}}/env/$2"
}

write_wale_env() {
  echo 'Writting environment variables required by wal-e'
  mkdir -p "{{pkg.svc_config_path}}/env"
  {{#with cfg.wal-e.aws as |aws| }}
  write_env_var 's3://{{aws.bucket}}/{{../../../svc.service}}-{{../../../svc.group}}' 'WALE_S3_PREFIX'
  write_env_var '{{aws.access_key_id}}' 'AWS_ACCESS_KEY_ID'
  write_env_var '{{aws.secret_access_key}}' 'AWS_SECRET_ACCESS_KEY'
  write_env_var '{{aws.region}}' 'AWS_REGION'
  {{/with}}

  write_env_var '{{cfg.superuser.name}}' 'PGUSER'
  write_env_var '{{cfg.superuser.password}}' 'PGPASSWORD'
  write_env_var 'postgres' 'PGDATABASE'
}

setup_replication_user_in_master() {
  echo 'Making sure replication role exists on Master'
  psql -U {{cfg.superuser.name}}  -h {{svc.leader.sys.ip}} -p {{cfg.port}} postgres >/dev/null 2>&1 << EOF
DO \$$
  BEGIN
  SET synchronous_commit = off;
  PERFORM * FROM pg_authid WHERE rolname = '{{cfg.replication.name}}';
  IF FOUND THEN
    ALTER ROLE "{{cfg.replication.name}}" WITH REPLICATION LOGIN PASSWORD '{{cfg.replication.password}}';
  ELSE
    CREATE ROLE "{{cfg.replication.name}}" WITH REPLICATION LOGIN PASSWORD '{{cfg.replication.password}}';
  END IF;
END;
\$$
EOF
}

local_xlog_position() {
  psql -U {{cfg.superuser.name}} -h localhost -p {{cfg.port}} postgres -t <<EOF | tr -d '[:space:]'
SELECT CASE WHEN pg_is_in_recovery()
  THEN GREATEST(pg_xlog_location_diff(COALESCE(pg_last_xlog_receive_location(), '0/0'), '0/0')::bigint,
                pg_xlog_location_diff(pg_last_xlog_replay_location(), '0/0')::bigint)
  ELSE pg_xlog_location_diff(pg_current_xlog_location(), '0/0')::bigint
END;
EOF
}

master_xlog_position() {
  psql -U {{cfg.superuser.name}} -h {{svc.leader.sys.ip}} -p {{cfg.port}} postgres -t <<EOF | tr -d '[:space:]'
SELECT pg_xlog_location_diff(pg_current_xlog_location(), '0/0')::bigint;
EOF
}

master_ready() {
  pg_isready -U {{cfg.superuser.name}} -h {{svc.leader.sys.ip}} -p {{cfg.port}}
}

bootstrap_replica_via_pg_basebackup() {
  echo 'Bootstrapping replica via pg_basebackup from leader '

  rm -rf {{pkg.svc_data_path}}/*
  pg_basebackup --pgdata={{pkg.svc_data_path}} --xlog-method=stream --dbname='postgres://{{cfg.replication.name}}@{{svc.leader.sys.ip}}:{{cfg.port}}/postgres'
}

bootstrap_replica_via_wale() {
  echo 'Bootstrapping replica via wal-e'

  rm -rf {{pkg.svc_data_path}}/*
  envdir {{pkg.svc_config_path}}/env wal-e backup-fetch {{pkg.svc_data_path}} LATEST
}

stop_wale_service() {
  if hab sup status | grep wal-e; then
    hab svc unload core/wal-e
  fi
}

start_wale_service() {
  echo "Starting wal-e to perform regular backups"
  mkdir -p /hab/svc/wal-e/
  cp {{pkg.svc_config_path}}/wal-e.toml /hab/svc/wal-e/user.toml
  hab svc load core/wal-e --group {{svc.group}}
}
