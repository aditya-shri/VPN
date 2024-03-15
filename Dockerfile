FROM debian:sid

RUN set -ex\
    && apt update -y \
    && apt upgrade -y \
    && apt install -y wget unzip qrencode\
    && apt install -y nginx\
    && apt autoremove -y

RUN mkdir -p /etc/v2ray /usr/local/share/v2ray /var/log/v2ray
COPY v2/v2ray /usr/bin/
COPY v2/geoip.dat v2/geosite.dat /usr/local/share/v2ray/

COPY conf/ /conf
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
CMD /entrypoint.sh