init_pgpass() {
  export PGPASSFILE="{{pkg.svc_config_path}}/.pgpass"
  chmod 0600 {{pkg.svc_config_path}}/.pgpass
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

ensure_dir_ownership() {
  echo 'Making sure hab user owns var, config and data paths'
  chown -RL hab:hab {{pkg.svc_var_path}}
  chown -RL hab:hab {{pkg.svc_config_path}}
  chown -RL hab:hab {{pkg.svc_data_path}}
}
