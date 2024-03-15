#!/bin/bash

QR_Path="/qr"
mkdir wwwroot

sed -e "/^#/d"\
    -e "s/\${PORT}/${PORT}/g"\
    -e "s|\${QR_Path}|${QR_Path}|g"\
    -e "$s"\
    /conf/nginx_ss.conf > /etc/nginx/conf.d/ss.conf 

sed -e "/^#/d"\
    -e "s/\${PORT}/443/g"\
    /conf/config.json > /etc/v2ray/config.json 

if [ "${Domain}" = "no" ]; then
  echo "Aditya's Personal VPN"
else
  cat /etc/v2ray/config.json | qrencode -s 6 -o /wwwroot/vpn.png
fi

v2ray run -c /etc/v2ray/config.json &
rm -rf /etc/nginx/sites-enabled/default
nginx -g 'daemon off;'
