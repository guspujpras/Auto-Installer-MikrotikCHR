#!/bin/bash -e

echo "=== MikroTik 6.49.19 Installer ==="
echo
sleep 3
wget https://download.mikrotik.com/routeros/6.49.19/chr-6.49.19.img.zip -O chr.img.zip  && \
gunzip -c chr.img.zip > chr.img  && \
STORAGE=`lsblk | grep disk | cut -d ' ' -f 1 | head -n 1` && \
echo STORAGE is $STORAGE && \
ETH=`ip route show default | sed -n 's/.* dev \([^\ ]*\) .*/\1/p'` && \
echo ETH is $ETH && \
ADDRESS=`ip addr show $ETH | grep global | cut -d' ' -f 6 | head -n 1` && \
echo ADDRESS is $ADDRESS && \
GATEWAY=`ip route list | grep default | cut -d' ' -f 3` && \
echo GATEWAY is $GATEWAY && \
sleep 5 && \
dd if=chr.img of=/dev/$STORAGE bs=4M oflag=sync && \
echo "=== DONE ==="
sleep 3
echo "=== REBOOT VPS===" 
echo "1"
echo "2"
echo "3" && \
echo 1 > /proc/sys/kernel/sysrq && \
echo b > /proc/sysrq-trigger && \
