#!/usr/bin/env sh

if [ "$AUTO_MIGRATION" = '1' ]; then
    sleep 5
    ./sql-migrate up -config db/conf.yml
fi
