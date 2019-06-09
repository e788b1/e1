#!/bin/bash

# wget http://downloads.openwrt.org.cn/PandoraBox/Xiaomi-Mini-R1CM/stable/PandoraBox-ralink-mt7620-xiaomi-mini-squashfs-sysupgrade-r1024-20150608.bin
# mtd -r write PandoraBox-ralink-mt7620-xiaomi-mini-squashfs-sysupgrade-r1024-20150608.bin OS1
# mtd -r write PandoraBox-ralink-mt7620-xiaomi-mini-squashfs-sysupgrade-r1024-20150608.bin firmware
# passwd root wifi
# local dns 223.6.6.6
# opkg update
# opkg install curl
# opkg install --force-depends aria2


## rc.local
# dnsmasq

curl --connect-timeout 5 --retry 5 -ko /tmp/dnsmasq.d/bogus-nxdomain.china.conf \
   https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/bogus-nxdomain.china.conf
curl --connect-timeout 5 --retry 5 -ko /tmp/dnsmasq.d/accelerated-domains.china.conf \
    https://raw.githubusercontent.com/felixonmars/dnsmasq-china-list/master/accelerated-domains.china.conf

## google
curl --connect-timeout 5 --retry 5 -ko /tmp/hosts/racaljk.hosts \
    https://raw.githubusercontent.com/racaljk/hosts/master/hosts
/etc/init.d/dnsmasq restart

## aria2
mkdir /tmp/aria2
touch /tmp/aria2/aria2.session
cat > /tmp/aria2/aria2.conf << "EOF"
dir=/mnt/sda1/Downloads
input-file=/tmp/aria2/aria2.session
save-session=/tmp/aria2/aria2.session

disable-ipv6=true
enable-rpc=true
rpc-allow-origin-all=true
rpc-listen-all=true
continue=true

max-concurrent-downloads=2
max-connection-per-server=5
min-split-size=10M
split=5
max-overall-download-limit=0
max-download-limit=0
max-overall-upload-limit=0
max-upload-limit=0
EOF

aria2c --conf-path=/tmp/aria2/aria2.conf -D
exit 0
