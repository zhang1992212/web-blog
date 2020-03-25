---
title: PHPSTORM XDEBUG 调试配置
date: 2020-03-25 15:45:37
tags:
---

#### 1.  php配置文件配置

![这里写图片描述](https://imgconvert.csdnimg.cn/aHR0cDovL2ltZy5ibG9nLmNzZG4ubmV0LzIwMTcxMTI3MTQzNTAyMTEx?x-oss-process=image/format,png)   
 
 xdebug.remote_host  phpstorm所在客户端ip
 xdebug.remote_port  xdebug连接端口
 xdebug.idekey   IDE的KEY 

<!-- more -->
 
 ![这里写图片描述](https://imgconvert.csdnimg.cn/aHR0cDovL2ltZy5ibG9nLmNzZG4ubmV0LzIwMTcxMTI3MTUxODA4MjEy?x-oss-process=image/format,png)
 
 重启php-fpm
#### 2.  phpstorm配置####
打开 File --> Settings --> Languages & Frameworks --> PHP
![这里写图片描述](https://imgconvert.csdnimg.cn/aHR0cDovL2ltZy5ibG9nLmNzZG4ubmV0LzIwMTcxMTI3MTQ0NjA0NDM1?x-oss-process=image/format,png)  

点击...  进行配置远程服务器的php
![这里写图片描述](https://imgconvert.csdnimg.cn/aHR0cDovL2ltZy5ibG9nLmNzZG4ubmV0LzIwMTcxMTI3MTUyMDA4NDYw?x-oss-process=image/format,png)

配置完成后点击ok

点击菜单栏中的Debug   debug port 就是php配置文件中xdebug.remote_port所配置的端口
![这里写图片描述](https://imgconvert.csdnimg.cn/aHR0cDovL2ltZy5ibG9nLmNzZG4ubmV0LzIwMTcxMTI3MTQ1MTMyNzE5?x-oss-process=image/format,png) 


点击菜单栏中的Debug下面的DBgp Proxy  
IDE key  就是php配置文件中的 xdebug.idekey 所配置的key
HOST  就是远端服务器的地址 我这里配置的是域名
Port 就是php配置文件中xdebug.remote_port所配置的端口

![这里写图片描述](https://imgconvert.csdnimg.cn/aHR0cDovL2ltZy5ibG9nLmNzZG4ubmV0LzIwMTcxMTI3MTQ1NTE3NTI1?x-oss-process=image/format,png)  

打开PHP下的Services  选择xdebug  把本地项目映射到远端服务器的项目上

![这里写图片描述](https://imgconvert.csdnimg.cn/aHR0cDovL2ltZy5ibG9nLmNzZG4ubmV0LzIwMTcxMTI3MTQ1OTQwNDA1?x-oss-process=image/format,png)


打开菜单栏中的 run --> Edit Configuration
![这里写图片描述](https://imgconvert.csdnimg.cn/aHR0cDovL2ltZy5ibG9nLmNzZG4ubmV0LzIwMTcxMTI3MTUwMjExMDc0?x-oss-process=image/format,png)  

点击+号  添加   选择配置好的service 和 默认打开浏览器

![这里写图片描述](https://imgconvert.csdnimg.cn/aHR0cDovL2ltZy5ibG9nLmNzZG4ubmV0LzIwMTcxMTI3MTUwNDI1MDA1?x-oss-process=image/format,png)  

#### 3.  xdebug调试####
在所需要调试的代码前面 单击 出现红点
[外链图片转存中...(img-QhfY9vIB-1576464026166)]  

点击绿色小虫子  开始调试   按F8进行逐行调试
![这里写图片描述](https://imgconvert.csdnimg.cn/aHR0cDovL2ltZy5ibG9nLmNzZG4ubmV0LzIwMTcxMTI3MTUwODM5NzY0?x-oss-process=image/format,png)  
  
#### 4.  postman xdebug调试####

只需要在post的数据中加上  XDEBUG_SESSION_START = PHPSTORM 就可以进行调试了
 ![这里写图片描述](https://imgconvert.csdnimg.cn/aHR0cDovL2ltZy5ibG9nLmNzZG4ubmV0LzIwMTcxMTI3MTUxMzQ5NTYx?x-oss-process=image/format,png)