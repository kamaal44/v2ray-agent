# v2ray-agent
- 本项目旨在更好的学习新知识，采用CDN+TLS+Nginx+v2ray进行伪装并突破防火墙。
- 本教程一键脚本适合全新机器以及小白用户。
- 如果需要手动搭建并且学习搭建步骤，可以从 [1.准备工作](#1准备工作) 开始查看。
- 同时还包含优化方案（CNAME优化、DNS优化、断流优化、bbr、bbr plus【阻塞拥堵算法，加快对流量的处理】）、其余设置（开机启动）、docker镜像。
- 未来还会加上docker脚本、面板、k8s等容器方面的内容。

## 有问题或者有想要加的功能可以在issus提交或者可以加入下方的电报群
[点击此链接加入电报群](https://t.me/joinchat/L68JqRQMroH78jqLI1HdcA)
* * *
# 目录
- [技能点列表](#技能点列表)
- [一键脚本](#一键脚本)
  * [1.自动模式](#1自动模式)
  * [2.手动模式](#2手动模式)
- [1.准备工作](#1准备工作)
  * [1.注册cloudflare](#1注册cloudflare)
  * [2.注册godaddy并购买域名](#2注册godaddy并购买域名)
  * [3.修改godaddy域名的DNS解析](#3修改godaddy域名的dns解析)
    + [1.登录cloudflare，添加域名](#1登录cloudflare添加域名)
    + [2.选择套餐](#2选择套餐)
    + [3.根据提示修改godaddy的dns解析](#3根据提示修改godaddy的dns解析)
  * [4.增加cloudflare域名解析](#4增加cloudflare域名解析)
  * [5.修改godaddy SSL/TLS](#5修改godaddy-ssltls)
- [2.vps配置Nginx、https](#2vps配置nginxhttps)
  * [1.安装Nginx](#1安装Nginx)
  * [2.nginx配置文件](#2nginx配置文件)
  * [3.生成https](#3生成https)
- [3.配置v2ray](#3配置v2ray)
  * [1.安装v2ray](#1安装v2ray)
  * [2.v2ray配置文件](#v2ray配置文件)
  * [3.启动v2ray](#3启动v2ray)
- [4.客户端](#4客户端)
  * [1.MacOS](#1macos)
  * [2.windows](#2windows)
- [备注](#备注使用前查看)
  * [1.推荐使用v2ray+CDN的方式](#1推荐使用v2ray-cdn的方式)
      + [1.优点](#1优点)
      + [2.缺点](#2缺点)
      + [3.数据包解析](#3数据包解析)
      + [4.建议](#4建议)
  * [2.速度首选V2Ray TCP方式](#2速度首选v2ray-tcp方式)
  * [3.本地网络环境不稳定首选mKCP](#3本地网络环境不稳定首选mkcp)
  * [4.目前不推荐使用ss、ssr](#4目前不推荐使用ss-ssr)
- [维护进程[todo List]](#维护进程todo-list)
  * [1.一键脚本](#1一键脚本)
    + [1.自动模式](#1自动模式)
    + [2.手动模式](#2手动模式)

* * *
### 优化方案
- [优化v2ray【断流、CNAME自选ip、dnsmasq自定义dns实现cname自选ip】](https://github.com/mack-a/v2ray-agent/blob/master/optimize_V2Ray.md)
- [其余设置【开机自启、bbr加速】](https://github.com/mack-a/v2ray-agent/blob/master/settings.md)

### [使用Docker](https://github.com/mack-a/v2ray-agent/blob/master/Docker/Docker.md)
* * *

# 技能点列表
- [bandwagonhost[Ubuntu、Centos、Debian]链接一](https://bandwagonhost.com)
- [bandwagonhost[Ubuntu、Centos、Debian]链接二](https://bwh1.net)【境外vps或者其他vps厂商】
- [freenom](https://freenom.com/)【免费域名】
- [godaddy](https://www.godaddy.com/)【域名厂商】
- [cloudflare](cloudflare.com)【CDN】
- [letsencrypt](https://letsencrypt.org/)【HTTPS】
- [Nginx](https://www.nginx.com/)【反向代理】
- [V2Ray](v2ray.com)【代理工具】

# 一键脚本
- <span style='color:red'>执行一键脚本的前提是下面的 【1.准备工作】完成并正确</span>
```
bash <(curl -L -s https://raw.githubusercontent.com/mack-a/v2ray-agent/master/install.sh)
```

## 1.自动模式
- 只需要输入域名即可
- 仔细检查【1.准备工作】正确
<img src="https://raw.githubusercontent.com/mack-a/v2ray-agent/master/fodder/一键脚本自动模式.png" width=400>

## 2.手动模式
- 可以指定需要执行的内容
<img src="https://raw.githubusercontent.com/mack-a/v2ray-agent/master/fodder/一键脚本手动模式.png" width=400>

* * *

# 1.准备工作
## 1.注册[cloudflare](cloudflare.com)
## 2.注册[godaddy](https://www.godaddy.com/)并购买域名或者使用免费域名[freenom](https://freenom.com/)
- 这里使用godaddy作为示例
- 域名可选择xyz结尾的国际域名，可采用多字符乱码的方式组合域名，(比如wk1c.xyz)首年大概8RMB左右，第二年可以直接买一个新的。

## 3.修改godaddy域名的DNS解析
### 1.登录cloudflare，添加域名
<img src="https://raw.githubusercontent.com/mack-a/v2ray-agent/master/fodder/cloudflare.png" width=400>

### 2.选择套餐
- 如果仅仅只享受科学上网功能，选择free即可
- 如果需要更好的网络环境、更快的速度，可选择相应的套餐
<img src="https://raw.githubusercontent.com/mack-a/v2ray-agent/master/fodder/cloudflare_plan.png" width=400>

### 3.根据提示修改godaddy的dns解析
- cloudflare提示界面
<img src="https://raw.githubusercontent.com/mack-a/v2ray-agent/master/fodder/cloudflare_dns.png" width=400>

- godaddy DNS管理，根据上面的cloudflare提示界面修改为相应的dns
<img src="https://raw.githubusercontent.com/mack-a/v2ray-agent/master/fodder/godayddy_dns.png" width=400>

## 4.增加cloudflare域名解析
- 添加域名解析(记录)，可以选择二级域名，这样就可以一个月解析到不同的服务器，name填写你要解析的二级域名的host部分，比如ls.example.com 只填写ls即可
<img src="https://raw.githubusercontent.com/mack-a/v2ray-agent/master/fodder/cloudflare_record_dns.png" width=400>

## 5.修改godaddy SSL/TLS
- 如果vps选择使用https，需要把类型修改为Full
<img src="https://raw.githubusercontent.com/mack-a/v2ray-agent/master/fodder/cloudflare_tls.png" width=400>

# 2.vps配置Nginx、https
## 1.安装Nginx
```
yum install nginx
```
## 2.nginx配置文件

- 1.下载配置文件并替换默认文件
```
cd /etc/nginx&&rm -rf /etc/nginx/nginx.conf&&wget https://raw.githubusercontent.com/mack-a/v2ray-agent/master/config/nginx.conf
# 如果缺少wget 则执行下面的命令，然后重复上面的命令
yum install wget
```
- 将下载好的文件中关于ls.xxx.xyz的内容都替换成你的二级域名

## 3.生成https

- 1.安装acme.sh
```
curl https://get.acme.sh | sh
% Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                               Dload  Upload   Total   Spent    Left  Speed
100   671  100   671    0     0    680      0 --:--:-- --:--:-- --:--:--   679
% Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                               Dload  Upload   Total   Spent    Left  Speed
100  112k  100  112k    0     0   690k      0 --:--:-- --:--:-- --:--:--  693k
[Fri 30 Dec 01:03:32 GMT 2016] Installing from online archive.
[Fri 30 Dec 01:03:32 GMT 2016] Downloading https://github.com/Neilpang/acme.sh/archive/master.tar.gz
[Fri 30 Dec 01:03:33 GMT 2016] Extracting master.tar.gz
[Fri 30 Dec 01:03:33 GMT 2016] Installing to /home/user/.acme.sh
[Fri 30 Dec 01:03:33 GMT 2016] Installed to /home/user/.acme.sh/acme.sh
[Fri 30 Dec 01:03:33 GMT 2016] Installing alias to '/home/user/.profile'
[Fri 30 Dec 01:03:33 GMT 2016] OK, Close and reopen your terminal to start using acme.sh
[Fri 30 Dec 01:03:33 GMT 2016] Installing cron job
no crontab for user
no crontab for user
[Fri 30 Dec 01:03:33 GMT 2016] Good, bash is found, so change the shebang to use bash as preferred.
[Fri 30 Dec 01:03:33 GMT 2016] OK
[Fri 30 Dec 01:03:33 GMT 2016] Install success!
```

- 2.生成https证书
```
# 替换ls.xxx.xyz为自己的域名
sudo ~/.acme.sh/acme.sh --issue -d ls.xxx.xyz --standalone -k ec-256

# 如果提示Please install socat tools first.则执行，安装完成后继续重复执行上面的命令
yum install socat
```

- 3.安装证书
```
# 替换ls.xxx.xyz为自己的域名
~/.acme.sh/acme.sh --installcert -d ls.xxx.xyz --fullchainpath /etc/nginx/ls.xxx.xyz.crt --keypath /etc/nginx/ls.xxx.xyz.key --ecc
```

- 4.修改/etc/nginx/nginx.conf
```
# 将下面这部分前面的#去掉，并将ssl_certificate、ssl_certificate_key修改成自己的路径

# listen 443 ssl;
# ssl_certificate /etc/nginx/ls.xx.xyz.crt;
# ssl_certificate_key /etc/nginx/ls.xx.xyz.key;
# server_name ls.xx.xyz
```

- 5.每一次生成https证书后有效期只有三个月，需要快过期时更新（剩余七天内可以重新生成）
```
# 替换ls.xxx.xyz为自己的域名
sudo ~/.acme.sh/acme.sh --renew -d ls.xxx.xyz --force --ecc
```

# 3.配置v2ray
## 1.安装v2ray

```
bash <(curl -L -s https://install.direct/go.sh)
```

## 2.v2ray配置文件

- 下载config_ws_tls.json
```
cd&&wget https://raw.githubusercontent.com/mack-a/v2ray-agent/master/config/config_ws_tls.json
```

- 配置文件的id可以自己生成一个新的，替换即可
```
/usr/bin/v2ray/v2ctl  uuid
```

## 3.启动v2ray
```
/usr/bin/v2ray/v2ray -config ./config_ws_tls.json&
```

# 4.客户端
## 1.MacOS
- 下载V2RayU[点我下载](https://github.com/yanue/V2rayU/releases/download/1.4.1/V2rayU.dmg)
- 下载后打开，服务器设置，修改address即可
<img src="https://raw.githubusercontent.com/mack-a/v2ray-agent/master/fodder/v2rayU_服务器配置.png" width=400>

- pac设置，添加下面的链接
```
https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt
```

- 选择使用Pac模式，即可
## 2.windows
- 下载v2rayN[点我下载](https://github.com/2dust/v2rayN/releases/download/2.44/v2rayN.zip)
- 使用方法 [点我查看](https://github.com/233boy/v2ray/wiki/V2RayN%E4%BD%BF%E7%94%A8%E6%95%99%E7%A8%8B)

<hr/>
<h3>到这里就配置完成，可以测试是否能上被q的网站,如果可以使用可以测试上方的优化方案</h3>
<hr/>

# 备注
## 1.推荐使用v2ray+CDN的方式
### 1.优点
- 1.防止境外vps被墙
- 2.由于CDN的方式是通过完全模拟正常网站，也可以是说本来就是一个正常的网站，同时又使用正常的CDN厂商（全球最大），有很多的外贸以及国外公司使用，墙一般不敢ban这些ip
- 3.可以用于被墙vps的搭建
- 4.相对来说更加安全

### 2.缺点
- 1.配置过程复杂
- 2.知识点相对比较多
- 3.维护相对复杂
- 4.由于CloudFlare不是国内的CDN厂商，速度相对来说慢一些（可以尝试CNAME优化方案[CNAME因为要使用国内的dns，相对于来说有风险]、或者使用自定义dns服务器[分享相对小一些]）

### 3.数据包解析
- 1.首先运营商以及GFW获取到的数据包，无法作为中间人进行攻击（中间人可以直接获取到v2ray的加密数据包）
- 2.即使获取到数据包之后，还需要对数据包进行解密，所以证书推荐使用第三方的，而不使用官方提供的，用了TLS加密的数据不是说不能解密，而是需要耗费巨大的时间以及运算能力
- 3.解密完成后 还需要对v2ray加密的数据进行解密、嗅探等操作
- 4.不建议使用不明来历的机场，如果机场主是国内的某些关系户，你用的代理相当于实名翻墙（违法）

### 4.建议
- 1.注意隐私保护（今日不同往日）
- 2.建议只用做学习以及娱乐使用，不建议发表一些敏感言论（不管是诋毁自己所在的国家，还是诋毁别的国家）
- 3.不建议人身攻击（有被起底的先例）

## 2.速度首选V2Ray TCP方式
- 1.本脚本目前不支持（后续可能会添加）

## 3.本地网络环境不稳定首选mKCP
- 1.本脚本目前不支持（后续可能会添加）

## 4.目前不推荐使用ss、ssr

# 维护进程[todo List]
## 1.一键脚本
### 1.自动模式
- [x] 1.检查系统版本是否为Ubuntu、Centos、Debian
- [x] 2.安装工具包
- [x] 3.检测nginx是否安装并配置
- [x] 4.检测https是否安装并配置
- [x] 5.检测V2Ray是否安装并配置
- [x] 6.生成vmess、二维码链接
- - [x] 1.shadowrocket
- - [ ] 2.Quantumult
- [x] 7.启动服务并退出脚本
- [ ] 8.HTTPS续签
- [ ] 9.开机自启动
- [ ] 10.面板搭建
- - [ ] 1.在线创建、删除、修改账户
- - [ ] 2.一键管理Nginx、TLS
- - [ ] 3.开机自启动
- - [ ] 4.流量控制
- - [ ] 5.日志查看
- [x] 11.docker[开箱即用]
- [x] 12.自定义DNS服务器替换CNAME优化方案
- [ ] 13.k8s+docker一键构建V2Ray Nginx【目前在做】

### 2.手动模式
- [x] 1.检查系统版本是否为Ubuntu、Centos、Debian
- [x] 2.安装工具包
- [x] 3.检测nginx是否安装并配置
- [x] 4.检测https是否安装并配置
- [x] 5.检测V2Ray是否安装并配置
- [x] 6.启动服务并退出脚本
- [x] 7.卸载安装的所有内容
- [x] 8.查看配置文件路径
- [x] 9.生成Vmess链接
- [x] 10.返回主目录
- [x] 11.退出脚本

## 1.手动搭建
- [x] 手动搭建
