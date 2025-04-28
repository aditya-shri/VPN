# Over the wall with Shadowsocks+SwitchyOmega

## Server
1. Buy a Cloud Host
	- DigitalOcean
	- AWS
	- Vultr
2. Solution 1: Using Original Shadowsocks
	1. Installing pip
        ```shell
        yum install python3-pip
        # or
        curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"
        python get-pip.py
        ```

        ```shell
        # update
        pip3 install --upgrade pip
        ```

	2. Installing shadowsocks
        ```shell
        pip3 install shadowsocks
        vim /etc/shadowsocks.json
        ```
	
        ```json
        {
            "server": "server_ip",//server ip address
            "server_port": 8388,//server port
            "local_address":"127.0.0.1",//local address
            "local_port":1080,//local port
            "port_password":{ //multiple port
                    "9001":"password9001",
                    "9002":"password9002",
                    "9003":"password9003",
                },
            "password": "password",//password
            "method": "aes-256-cfb",//encryption
            "timeout":600 //timeout
        }
        ```
        - Explanation:
            - "server": "123.123.123.123" :: server ip address
            - "server_port": 8388 :: server port
            - "local_address":"127.0.0.1" :: local ip address
            - "local_port":1080, :: local port
            - "port_password" :: port and password
            - "password": "password" :: password
            - "method": "aes-256-cfb" :: encrypt method, more details: [Password Tool](http://ucdok.com/project/generate_password.html)
            - "timeout":600 :: over time
		
	3. Configuring auto-start script
        ```shell
        vim /etc/systemd/system/shadowsocks.service
        ```
        
        ```service
        [Unit]
        Description=Shadowsocks
        
        [Service]
        TimeoutStartSec=0
        ExecStart=/usr/bin/ssserver -c /etc/shadowsocks.json
        
        [Install]
        WantedBy=multi-user.target
        ```
        
        ```shell
        # Start shadowsocks
        systemctl enable shadowsocks
        systemctl start shadowsocks
        systemctl status shadowsocks -l
        ```
	4. Auto install script
		```shell
		vim install-shadowsocks.sh, content of file from 
		```
		 
	    - install-shadowsocks.sh
            ```shell
            chmod +x install-shadowsocks.sh
            ./install-shadowsocks.sh
            ```

3. Solution 2: Using docker
	- Installing docker
        ```shell
        # CentOS Linux
        yum install docker
        systemctl enable docker
        systemctl start docker
        ```

        ```shell
        # CentOS Stream
        yum install -y yum-utils
        yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
        yum install docker-ce docker-ce-cli containerd.io
        systemctl start docker
        systemctl enable docker
        ```
	
	- Deploy shadowsocks
        ```shell
        docker run -dt --name ss -p 6443:6443 mritd/shadowsocks -s "-s 0.0.0.0 -p 6443 -m aes-256-cfb -k test123 --fast-open"
        ```

## Client
1. Linux
	1. Command Line Client on Linux
		1. Linux series
			- Debian/Ubuntu:
				```bash
				sudo apt-get install python-pip
				sudo pip install shadowsocks
				```

			- Fedora/Centos:
				```shell
				sudo yum install python-setuptools   
				#or   
				sudo dnf install python-setuptools
				sudo easy_install pip
				sudo pip install shadowsocks
				```

			 - OpenSUSE:
				```shell
				sudo zypper install python-pip
				sudo pip install shadowsocks
				```

			- Archlinux:
                ```shell
                sudo pacman -S python-pip
                sudo pip install shadowsocks
                ```

			sslocal is the client software and ssserver is the server software. On some Linux distros such as ubuntu, the shadowsocks client sslocal is installed under `usr/local/bin`. On Others such as Arch sslocal is installed under `/usr/bin`. 
			Your can use whereis command to find the exact location.
			```shell
			whereis sslocal
			sslocal: /usr/local/bin/sslocal
			```
		
		2. /etc/shadowsocks.json
			```json
			{
				"server":"server-ip",
				"server_port":8000,
				"local_address": "127.0.0.1",
				"local_port":1080,
				"password":"your-password",
				"timeout":600,
				"method":"aes-256-cfb"
			}
			```
		
			```shell
			# start
			sudo sslocal -c /etc/shadowsocks.json
			# To run in the background
			sudo sslocal -c /etc/shadowsocks.json -d start
			```
		
		3. /etc/rc.local
			```shell
			sudo vim /etc/rc.local
			sudo sslocal -c /etc/shadowsocks.json -d start
			# Check if It Works
			sudo systemctl status rc-local.service
			```

	2. Global Proxy
		- Install and Configure polipo
			```shell
			sudo apt install polipo
			sudo vim /etc/polipo/config
			```
			
			```vim
			logSyslog = true
			logFile = /var/log/polipo/polipo.log
			proxyAddress = "0.0.0.0"
			socksParentProxy = "127.0.0.1:1080"
			socksProxyType = socks5
			chunkHighMark = 50331648
			objectHighMark = 16384
			serverMaxSlots = 64
			serverSlots = 16
			serverSlots1 = 32
			```

		- Restart polipo
			`sudo systemctl restart polipo`

		- Export http_proxy and https_proxy
		    ```shell
			export http_proxy="http://127.0.0.1:8123/"
	 		export https_proxy="https://127.0.0.1:8123/"
			```
		- Testing
			`curl www.google.com`

2. Windows
	1. Download Shadowsocks client
	2. Configure: 
		1. UnZip
		2. Run Client
            - ![?](https://web.archive.org/web/20221206231805mp_/https://zhaorengui.github.io/assets/images/shadowsocks-20170123111902.png)

		3. Configure data in the client
            - ![?](https://web.archive.org/web/20221206231805mp_/https://zhaorengui.github.io/assets/images/shadowsocks-20170123111953.png)

		4. Start proxy
            - ![?](https://web.archive.org/web/20221206231805mp_/https://zhaorengui.github.io/assets/images/shadowsocks-20170123112126.png)

3. Android
	1. Download Shadowsocks client
	2. Configure the data in client
        - ![?](https://web.archive.org/web/20221206231805im_/https://zhaorengui.github.io/assets/images/shadowsocks-20170123141118.png)

4. IOS
	- Open "App Store", To search "shadowrocket". Current price: ￥12
	- Add server configure.

5. Mac OS X
	https://github.com/shadowsocks/ShadowsocksX-NG

## Browser Plugin: SwitchyOmega
1. Download Extension
2.  Configure
	- Set proxy
        - ![?](https://web.archive.org/web/20221206231805im_/https://zhaorengui.github.io/assets/images/switchyomega-01.png)
	- Set rules
        - ![?](https://web.archive.org/web/20221206231805im_/https://zhaorengui.github.io/assets/images/switchyomega-02.png)

		- Rules (Select any one):
		    - http://autoproxy-gfwlist.googlecode.com/svn/trunk/gfwlist.txt
		    - https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt


## Reference
- Web Archive page: [Link](https://web.archive.org/web/20221206231805/https://zhaorengui.github.io/network/software/2018/08/10/shadowsocks-switchyOmega-en/)