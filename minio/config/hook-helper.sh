#!/bin/bash

# This helper optimizes minio hooks by:
# * extracting toml variables to bash
# * creating helper methods
# * keeping secrets out: https://github.com/habitat-sh/habitat/issues/6076
#
# Expected be sourced by all hooks at very early stage

standalone="{{ cfg.standalone }}"
expected="{{ cfg.expected }}"
use_ssl="{{ cfg.use_ssl }}"
ssl_cert_pw="{{ cfg.ssl_cert_pw }}"

# This hook is used for caching last known good configuration
run_good_hook="{{pkg.svc_static_path}}/run-good"

# This meta hook is used for restart detection
meta_restart_hook="{{pkg.svc_config_path}}/restart-hook.txt"

# For aws cli
export AWS_ACCESS_KEY_ID="{{cfg.key_id}}"
export AWS_SECRET_ACCESS_KEY="{{cfg.secret_key}}"

# For minio server
export MINIO_ACCESS_KEY="{{cfg.key_id}}"
export MINIO_SECRET_KEY="{{cfg.secret_key}}"

if [ -n "$ssl_cert_pw" ]; then
    export MINIO_CERT_PASSWD="$ssl_cert_pw"
fi

# Generate Expected Members
# {{#eachAlive svc.members as |member|}}
svc_members="$svc_members http://{{member.sys.hostname}}{{../pkg.svc_data_path}}"
# {{/eachAlive}}
svc_count=$(echo "$svc_members" | wc -w)

# Generate Explicit Members
# {{#each cfg.members as |member|}}
explicit_members="$explicit_members {{member}}"
# {{/each}}
explicit_count=$(echo "$explicit_members" | wc -w)

# Helper methods

# Can't calculate PID on the early stage, so defer it by method
minio_pid() {
    cat "{{pkg.svc_pid_file}}"
}

# Copy certificates from ring
copy_certs() {
    cert_dir="{{pkg.svc_config_path}}/certs"
    priv_key="{{pkg.svc_files_path}}/private.key"
    pub_key="{{pkg.svc_files_path}}/public.crt"

    mkdir -p $cert_dir

    cp $priv_key $cert_dir
    cp $pub_key $cert_dir
}

# TODO: Re-evaluate when hooks can run on their own thread
# Sleeps in hooks that are not the run hook
# are not a good practice because all hooks run in the Supervisor's
# main thread. In the future, this may change.
# See also: https://github.com/habitat-sh/habitat/issues/2364
#
# Wait a little so minio can initialize
minio_splay_delay() {
    if [ "$standalone" == "true" ]; then
        # In standalone mode more likely it starts quickly
        sleep 1
    else
        sleep $((RANDOM % 5 + 5))
    fi
}

create_bucket() {
    if [ "$use_ssl" == "true" ]; then
        aws_s3="aws --endpoint-url https://localhost:9000 --no-verify-ssl s3api"
    else
        aws_s3="aws --endpoint-url http://localhost:9000 s3api"
    fi

    if $aws_s3 list-buckets | grep "{{cfg.bucket_name}}" > /dev/null; then
        echo "Minio bucket is up to date."
    else
        echo "Creating minio bucket {{cfg.bucket_name}}."
        $aws_s3 create-bucket --bucket "{{cfg.bucket_name}}"
    fi
}

# If something in restart-hook.txt will change then reload hook will restart service
checksum_restart_hook() {
    sha256sum $meta_restart_hook > $meta_restart_hook.sha256
}

check_restart_hook() {
    sha256sum -c $meta_restart_hook.sha256 --status 2> /dev/null
}
