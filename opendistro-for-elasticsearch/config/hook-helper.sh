#!/bin/bash

# TODO: Re-evaluate when hooks can run on their own thread
# Sleeps in hooks that are not the run hook
# are not a good practice because all hooks run in the Supervisor's
# main thread. In the future, this may change.
# See also: https://github.com/habitat-sh/habitat/issues/2364
# Wait so elasticsearch can start
create_credentials_delay() {
    CURL_STATUS="1"
    BREAKER=0
    while [ $CURL_STATUS != "0" ]; do
    sleep 5
    CURL_OUTPUT="$(curl -sk https://{{svc.me.sys.ip}}:{{svc.me.cfg.http-port}})"
    CURL_STATUS=$?
    if [[ $CURL_OUTPUT =~ .*Security\ not\ initialized.* ]]; then
        echo "inserting default credentials"
        set -e
        {{pkg.path}}/plugins/opendistro_security/tools/securityadmin.sh -h {{svc.me.sys.ip}} -p {{svc.me.cfg.transport-port}} -cacert {{pkg.svc_path}}/config/certificates/MyRootCA.pem -cert {{pkg.svc_path}}/config/certificates/admin.pem -key {{pkg.svc_path}}/config/certificates/admin.key -nhnv -icl -cd {{pkg.svc_path}}/config/securityconfig
        echo "Inserted default securityconfig"
        exit 0
    elif [ "$CURL_OUTPUT" == 'Unauthorized' ]; then
        echo "Authentication appears to already be setup, giving up"
        exit 0
    fi
    if [[ $BREAKER -gt 30 ]]; then
        echo "After 2.5 minutes Elasticsearch never responded to requests to insert data, giving up"
        exit 1
    fi
    BREAKER=$((BREAKER+1))
    done

    exit 0
}
