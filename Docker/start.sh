#!/usr/bin/env bash

/usr/src/v2ray/v2ray -config /usr/src/v2ray/config_ws.json &

nginx -g 'daemon off;'
