#!/bin/bash

hosts=$1

dos2unix -n $hosts /tmp/hosts.unix


cat /tmp/hosts.unix |\
    sed '/localhost/d' |\
    sed '/broadcasthost/d' |\
    sed '/^$/d' | sed '/^\s*$/d' | sed '/^\s*#/d' |\
    awk '{print "address=/"$2"/"$1}' \
    > $hosts"-dnsmasq.conf" && echo "success"
