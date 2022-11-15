# Personal VPN
### Based on Shadowsocks with V2-Raу-plugin

Click the button below to deploy, and remember to Star if it works:

[![Heroku](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

[![Railway](https://railway.app/button.svg)](https://railway.app/new/template/zN4vrb)

---

## 0. Attention

- Deployment can be done on any server with the help of DockerFile. 
- Heroku Deployment requires registration of a heroku account, a email is required when registering a heroku account (otherwise the verification code cannot be brushed out). 
- If app gets ban on Heroku, try forking and then deploying OR deploy using Heroku-CLI. When deploying using Heroku-cli, remember to set stack to container.

The environment variables required are:
```txt
Domain   : The domain of your server without the schema(https, http etc). Ex: test.com, not https://test.com
Password : Password you want to set for the Shadowsocks VPN service
PORT	 : Server port, if not already defined by server provider(like Heroku,Railway provides)
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
(Change {Domain} to your own app server url.)

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
	"plugin": "v2raу-plugin",
	"plugin_opts":"path=/v2;host={Domain};tls",
	"remarks" : "Private VPN"
}
```
Change {Domain} with your server url and {password} with your password.

## 3. Clients

### Android 

[shadowsocks](https://play.google.com/store/apps/details?id=com.github.shadowsocks&hl=en_IN&gl=US)

[v2-raу-plugin](http://bit.ly/3g5QjkP)

### Windows

[ShadowSocks-Windows](https://github.com/shadowsocks/shadowsocks-windows/releases/download/4.4.1.0/Shadowsocks-4.4.1.0.zip)

[V2-Raу Plugin](http://bit.ly/3Ew0pER)

Extract and keep v2-raу plugin in the same folder as shadowsocks.

### Linux

[shadowsocks-libev](https://github.com/shadowsocks/shadowsocks-libev)

[V2-Raу Plugin](http://bit.ly/3Ah7O8B)

Install the shadowsocks library, download and move the v2-raу plugin in '/usr/bin' and use the following command to connect to VPN:
```
ss-local -c "config file location on your system"
```
Then use any proxy script to route your system's requests through your VPN.
Ex:
- [Proxy SwitchyOmega](https://chrome.google.com/webstore/detail/proxy-switchyomega/padekgcemlokbadohgkifijomclgjgif?hl=en) : This extension can be used in chrome
- Polipo : Routes all of the network through your proxy

### Reference Guide for client setup
[Guide](https://zhaorengui.github.io/network/software/2018/08/10/shadowsocks-switchyOmega-en/)

# Reference

[ShadowSocks-libev](https://hub.docker.com/r/shadowsocks/shadowsocks-libev)

[V2-Ray Plugin](http://bit.ly/3tyt2uJ)
