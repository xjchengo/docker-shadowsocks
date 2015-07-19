#!/bin/bash
set -e

OPTIONS=('SERVER' 'SERVER_PORT' 'PASSWORD' 'TIMEOUT' 'METHOD' 'WORKERS')

for option in "${OPTIONS[@]}"
do
    if [ "${!option}" ]; then
        if [ "$option" = 'SERVER_PORT' ] || [ "$option" = 'TIMEOUT' ] || [ "$option" = 'WORKERS' ]; then
            sed -i "s/\"${option,,}\":[^,]*/\"${option,,}\": ${!option}/" /etc/shadowsocks.json
        else
            sed -i "s/\"${option,,}\":[^,]*/\"${option,,}\": \"${!option}\"/" /etc/shadowsocks.json
        fi
    fi
done

exec "$@" -c /etc/shadowsocks.json
