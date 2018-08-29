#!/usr/bin/env bash

if [ ! -f $1.pid ]; then
   echo '.pid file not found...'
   exit 1
fi

pkill -TERM -P `cat $1.pid`
rm $1.pid

echo 'kill ' $1 'service'

exit 0
