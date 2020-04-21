- [1.准备工作](#1准备工作)
- [2.购买流量转发服务](#2购买流量转发服务)
- [2.配置流量转发服务](#3配置流量转发服务)
  * [1.配置idc.wiki流量转发](#1配置idcwiki流量转发)
  * [2.Android](#2android)
  * [2.ios](#3ios需要自行购买或者使用共享账号安装)
  * [2.Mac](#4mac)

# 1.准备工作
- 1.需要一台没被墙的VPS（IPLC理论上是可以转发流量给被墙的VPS，目前手中没有被墙的VPS，无法进行测试）。
- 2.需要域名以及设置DNS解析，建议使用CloudFlare，其余的dns解析也可以。这里转发的是tls+ws流量，如果只是转发tcp vmess流量可以不用域名，但是vps会有被墙的风险，这里不推荐最基础tcp+vmess【如果有需要可以提issues】。
- 3.需要生成HTTPS证书，推荐使用通配符证书【通配符证书稍后完善】。
- 4.上面三个步骤参考 [点此链接查看](https://github.com/mack-a/v2ray-agent/blob/master/Cloudflare_Full.md)
- 5.必须保证在不用流量转发服务的情况可以使用tls+ws科学上网。
- 6.购买流量转发服务【idc.wiki】

# 2.购买流量转发服务
- 1.注册-->[idc.wiki](https://idc.wiki/aff.php?aff=1146)
- 2.注册完成后，服务-->购买新服务-->左侧显示菜单-->左侧列表最下面【流量转发服务】【建议购买150的服务，包含IPLC线路】

# 3.配置流量转发服务
## 1.配置idc.wiki流量转发
- 1.服务-->我的产品和服务-->管理产品-->添加普通转发&添加IPLC转发【普通和IPLC设置方式一样】
- 2.配置转发规则，这里只有一个点需要注意下一下【需转发地址，填写自己vps的ip以及https+ws的端口。】
```
# 示例
173.82.112.30:443
```
- 3.协议为TCP

## 2.配置&修改DNS解析【这里示例为CloudFlare】
- 1.idc.wiki 示例图
<img src="https://raw.githubusercontent.com/mack-a/v2ray-agent/master/fodder/idcwiki_traffic.png" width=400>

- 2.修改域名dns解析到中转服务ip
```
# 1.name是你的二级域名的blog部分【blog.example.com】
# 2.content则是上述示例图转发部分的ip
```
<img src="https://raw.githubusercontent.com/mack-a/v2ray-agent/master/fodder/cloudflare_idcwiki.png" width=400>

# 4.修改客户端
- 修改客户端端口部分【端口修改为中转IP的端口，例如上述的12187】
- 其余客户端类似，在保证ws+tls正常使用的情况下配置流量转发服务客户端只需要修改即可。
<img src="https://raw.githubusercontent.com/mack-a/v2ray-agent/master/fodder/Quantumult_Setting.png" width=400>
