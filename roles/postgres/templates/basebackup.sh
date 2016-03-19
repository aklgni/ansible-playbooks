#!/usr/bin/env bash
# Recovery script for streaming replication.
# This script assumes that DB node 0 is primary, and 1 is standby.
#
datadir=$1
desthost=$2
destdir=$3
{% if 'pg-master' in group_names %}
host={{ hostvars[groups['pg-master'][0]]['ansible_fqdn']  }}
{% else %}
host={{ hostvars[groups['pg-slave'][0]]['ansible_fqdn'] }}
{% endif %}

PG_REPL_USER="rep"
PSQL=/usr/pgsql/bin/psql

$PSQL -c "SELECT pg_start_backup('Streaming Replication', true)" postgres

ssh -o "StrictHostKeyChecking no" -T postgres@$desthost mv $destdir/basebackup.sh $destdir/../
ssh -o "StrictHostKeyChecking no" -T postgres@$desthost rm -rf $destdir/
echo   "ssh -T postgres@$desthost pg_basebackup -D $destdir -Fp -Xs -v -P -h $host -U $PG_REPL_USER"  >> /tmp/aaaa
ssh -o "StrictHostKeyChecking no" -T postgres@$desthost pg_basebackup -D $destdir -Fp -Xs -v -P -h $host -U $PG_REPL_USER
ssh -o "StrictHostKeyChecking no" -T postgres@$desthost mv $destdir/../basebackup.sh $destdir/

ssh -o "StrictHostKeyChecking no" -T postgres@$desthost mv $destdir/recovery.done $destdir/recovery.conf
ssh -o "StrictHostKeyChecking no" -T postgres@$desthost "sed -i \"s/[# ]*primary_conninfo[ ]*=.*/primary_conninfo = 'host=$host port=5432 user=$PG_REPL_USER'/g\" $destdir/recovery.conf"

$PSQL -c "SELECT pg_stop_backup()" postgres
