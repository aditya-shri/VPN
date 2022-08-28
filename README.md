# Personal VPN
## Shadowsocks+V2Ray-plugin

Click the button below to deploy, and remember to Star if it works:

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)
---

## 0. Attention

- Deployment can be done on any server with the help of DockerFile. 
- Heroku Deployment requires registration of a heroku account, a email is required when registering a heroku account (otherwise the verification code cannot be brushed out). 
- If app gets ban on Heroku, try forking and then deploying OR deploy using Heroku-CLI.

The environment variables required are:
```json
Domain   : The domain of your server without the schema(https, http etc)
Password : Password you want to set for the Shadowsocks VPN service
```

## 1. Verification

After the server is deployed, open app to display the webpage normally. After the address is filled with the path (for example: <https://{Domain}/static>), the 404 page is displayed, which means the deployment is successful.

## 2. Client Configuration

### QR code address: 
``` 
https://{Domain}/qr 
```

(Change {Domain} to your own app server url.)

Use the client (Shadowsocks recommended) to scan the QR code.

**or**

### Use 'ss' address: 
```
https://{Domain}/ss
```
(Change {Domain} to your own app name)

Copy the details after opening and import it to the client.

**or**

### Manual configuration (Config file):

```json
{
	"server" : "{Domain}",
	"server_port" : 443,
	"local_port" : 1080,
	"password":"{password}",
	"timeout":300,
	"method":"chacha20-ietf-poly1305",
	"mode": "tcp_only",
	"fast_open":false,
	"reuse_port":true,
	"no_delay":true,
	"plugin": "v2ray-plugin",
	"plugin_opts":"path=/v2;host={Domain};tls",
	"remarks" : "Private VPN"
}
```
Change {Domain} with your server url and {password} with your password.

## Clients

### Android 

[shadowsocks](https://github.com/shadowsocks/shadowsocks-android/releases/latest/download/shadowsocks--universal-5.1.9.apk)

[v2ray-plugin](https://github.com/shadowsocks/v2ray-plugin-android/releases/latest/download/v2ray-arm64-v8a-1.3.1.apk)

### Windows

<https://github.com/shadowsocks/shadowsocks-windows/wiki/Shadowsocks-Windows-%E4%BD%BF%E7%94%A8%E8%AF%B4%E6%98%8E>

### Linux

[shadowsocks-libev](https://github.com/shadowsocks/shadowsocks-libev)

Install this library and use the following command to connect to VPN:
```
ss-local -c "config file location on your system"
```
Then use any proxy script to route your system requests through your VPN
Ex:
- [Proxy SwitchyOmega](https://chrome.google.com/webstore/detail/proxy-switchyomega/padekgcemlokbadohgkifijomclgjgif?hl=en) : This extension can be used in chrome
- Polipo : Routes all of the network through your proxy

### Reference Guide for client setup
[Guide](https://zhaorengui.github.io/network/software/2018/08/10/shadowsocks-switchyOmega-en/)

# Reference

[ShadowSocks-libev](https://hub.docker.com/r/shadowsocks/shadowsocks-libev)

[V2-Ray Plugin](https://github.com/shadowsocks/v2ray-plugin)
