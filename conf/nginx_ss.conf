#!/bin/bash
cat <<EOF
server {
    listen       ${PORT};
    listen       [::]:${PORT};

    root /wwwroot;

    location / {
        return 403;
    }
    location ${QR_Path} {
        root /wwwroot;
    }
    location = /${V2_Path} {
        if (\$http_upgrade != "websocket") { # WebSocket return this when negotiation fails 404
            return 404;
        }
        proxy_redirect off;
        proxy_pass http://127.0.0.1:2333;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host \$http_host;
        # Show real IP in v2ray access.log
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    }
}
EOF
