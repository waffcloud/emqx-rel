#!/bin/bash -eu

## Build cuttlefish executable
cd ${REBAR_BUILD_DIR}/lib/cuttlefish
make

cd ${REBAR_BUILD_DIR}

## Collect config files, some are direct usable
## some are relx-overlay templated
rm -rf conf
mkdir -p conf/plugins
for conf in lib/*/etc/*.conf* ; do
    if [ "emqx.conf" = "${conf##*/}" ]; then
        cp ${conf} conf/
    elif [ "acl.conf" = "${conf##*/}" ]; then
        cp ${conf} conf/
    elif [ "ssl_dist.conf" = "${conf##*/}" ]; then
        cp ${conf} conf/
    else
        cp ${conf} conf/plugins/
    fi
done

## Collect all schema files
mkdir -p conf/schema
for schema in lib/*/priv/*.schema; do
    cp ${schema} conf/schema/
done

