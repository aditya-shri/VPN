# Personal VPN
## Shadowsocks+V2Ray-plugin

Click the button below to deploy, and remember to order a Star if it works:

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://dashboard.heroku.com/new?template=https://github.com/developeranaz/Heroku-Easy-Free-VPN)
---

Native V2Ray deployment: <https://github.com/ygcaicn/v2ray-heroku>

---

## 0. Attention

Deployment requires registration of a heroku account, a ladder is required when registering a heroku account (otherwise the verification code cannot be brushed out), an email address that can receive verification codes normally (@qq.com, @163.com are not acceptable), gmail is conditional
Best, no conditions recommend outlook <https://login.live.com/> here.

## 1. Verification

After the server is deployed, click open app to display the webpage normally. After the address is filled with the path (for example: <https://test.herokuapp.com/static>), the 404 page is displayed, which means the deployment is successful.

## 2. Client Configuration


QR code address: 

<https://{YOUR-APP}.herokuapp.com/qr/vpn.png>

(Change **YOUR-APP** to your own app name, if you change QR_Path, also change the corresponding qr_img to the modified one)

Use the client to scan the QR code.

**or**

Configuration file address: 

<https://{YOUR-APP}.herokuapp.com/qr/> 

slash '/' is important at last of configuration file address.

Copy after opening and import it on the client.

**or**

Manual configuration:

```sh
Server: test.herokuapp.com (change test to your app name)
Port: 443
Password: The password filled in during deployment
Encry Method: RC4-MD5 (or other methods you fill in)
Plugin: v2ray
Plugin Transport mode: websocket-tls
Hostname: Same as Server
Path: The path you filled in during deployment
```

Those without a client can also download from here (Android):

[shadowsocks](https://github.com/shadowsocks/shadowsocks-android/releases/download/v5.0.5/shadowsocks--universal-5.0.5.apk) + [v2ray-plugin](https://github.com/shadowsocks/v2ray-plugin-android/releases/download/v1.3.1/v2ray-arm64-v8a-1.3.1.apk)

windows:

<https://github.com/shadowsocks/shadowsocks-windows/wiki/Shadowsocks-Windows-%E4%BD%BF%E7%94%A8%E8%AF%B4%E6%98%8E>

## 3. Update

To update the v2ray-plugin version, visit <https://dashboard.heroku.com/apps> and select the deployed app. If the VER variable is latest. Directly select More --> Restart all dynos, the program will restart automatically, and the progress can be confirmed through view Logs. (Update the specified version: Settings --> Reveal Config Varsapp -->VER, modify to the required version number, such as 1.2)

2020/03/01 The current version is working normally:

+ shadowsocks-libev: 3.3.4+ds-2(debian apt)

+ v2ray-plugin: v1.3.0

# Reference

https://github.com/ygcaicn/ss-heroku

https://github.com/xiangrui120/v2ray-heroku-undone

https://hub.docker.com/r/shadowsocks/shadowsocks-libev

https://github.com/shadowsocks/v2ray-plugin

## Originally Forked from https://github.com/aditya-shri/VPN
