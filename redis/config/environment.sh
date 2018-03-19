#!/bin/bash

{{ #if bind.shield.first }}
{{ #with bind.shield.first }}
SHIELD_ENDPOINT='https://{{sys.ip}}:{{cfg.port}}'
SHIELD_API_TOKEN='{{cfg.provisioning_key}}'
{{~/with}}
{{else}}
SHIELD_ENDPOINT='{{cfg.shield_endpoint}}'
SHIELD_API_TOKEN='{{cfg.shield_provisioning_key}}'
{{ /if }}
