#!/bin/bash

YK_DEV=`qvm-usb | grep -i yubikey | cut -f1`

qvm-usb | grep ${YK_DEV} | grep "{attached"
if [ $? -eq 0 ]; then
   echo "[-] Detaching Yubikey"
   qvm-usb -d ${YK_DEV}
   sleep 1
fi

echo "[+] Attaching Yubikey to Personal"
qvm-usb -a personal ${YK_DEV}
