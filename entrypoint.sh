#!/bin/bash

QR_Path="/qr"

#V2Ray Configuration
V2_Path="/v2"
mkdir /wwwroot
mv /v2 /usr/bin/v2

if [ ! -d /etc/v2 ]; then  
  mkdir /etc/v2
fi

# TODO: bug when PASSWORD contain '/'
sed -e "/^#/d"\
    -e "s|\${PORT}|${PORT}|g"\
    /conf/v2config.json >  /etc/v2/config.json
echo /etc/v2/config.json
cat /etc/v2/config.json

sed -e "/^#/d"\
    -e "s/\${PORT}/${PORT}/g"\
    -e "s|\${V2_Path}|${V2_Path}|g"\
    -e "s|\${QR_Path}|${QR_Path}|g"\
    -e "$s"\
    /conf/nginx_ss.conf > /etc/nginx/conf.d/ss.conf 

if [ "${Domain}" = "no" ]; then
  echo "Aditya's Personal VPN"
else
  cat /etc/v2/config.json | qrencode -s 6 -o /wwwroot/vpn.png
fi

v2 --config="/etc/v2/config.json" &
rm -rf /etc/nginx/sites-enabled/default
nginx -g 'daemon off;'
