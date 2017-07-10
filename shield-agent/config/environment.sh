#!/bin/bash

{{ #if bind.daemon.first }}
{{ #with bind.daemon.first }}
SHIELD_ENDPOINT='https://{{sys.ip}}:{{cfg.port}}'
SHIELD_API_TOKEN='{{cfg.provisioning_key}}'
{{~/with}}
{{else}}
SHIELD_ENDPOINT='{{cfg.shield_endpoint}}'
SHIELD_API_TOKEN='{{cfg.provisioning_key}}'
{{ /if }}
