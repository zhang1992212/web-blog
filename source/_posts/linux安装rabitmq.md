---
title: linux 源码安装 rabbitmq
date: 2018-06-25 15:46:03
tags:
    - linux
    - rabbitmq
categories:
    - LINUX
---

###一、安装erlang

1.利用yum安装erlang编译所依赖的环境 `yum -y install make gcc gcc-c++ kernel-devel m4ncurses-devel openssl-devel unixODBC-devel`
2.下载erlang 进行源码安装
    erlang官网地址：http://www.erlang.org/downloads
<!-- more -->
![这里写图片描述](https://img-blog.csdn.net/20180816103004551?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3NpbmF0XzI4MTU2ODMx/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)
下载完  文件名为 otp_src_21.0.tar.gz
3.解压并进行编译安装
```bash
    #解压
    tar -xvf otp_src_21.0.tar.gz
    #进入目录
    cd cd otp_src_21.0
    #编译
    ./configure  --prefix=/usr/local/erlang --without-javac
    #安装
    make && make install
    
```
###二、安装rabbitmq
 1. 下载rabbitmq
 rabbitmq官网下载地址 ： http://www.rabbitmq.com/download.html
 rabbitmq源码下载地址： http://www.rabbitmq.com/install-generic-unix.html
 ![这里写图片描述](https://img-blog.csdn.net/20180816105917789?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3NpbmF0XzI4MTU2ODMx/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)
![这里写图片描述](https://img-blog.csdn.net/20180816105927347?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3NpbmF0XzI4MTU2ODMx/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)
2.解压
```bash
    xz -d rabbitmq-server-generic-unix-3.7.7.tar.xz
    tar -xvf rabbitmq-server-generic-unix-3.7.7.tar
```
3.移动文件到系统目录下
```bash
    mv rabbitmq_server-3.7.7/  /usr/local/rabbitmq
```
###三、添加系统变量
```bash
    #打开环境变量文件
    vim /etc/profile
    #添加erlang rabbitmq 到环境变量
    export PATH=$PATH:/usr/local/erlang/bin
    export PATH=$PATH:/usr/local/rabbitmq/sbin
    #重新加载环境变量
    source /etc/profile
```
### 四、 启动web插件 启动rabbitmq
```bash
    #启动web插件 便于访问
    rabbitmq-plugins enable rabbitmq_management
    #启动rabbitmq服务
    rabbitmq-server
```
###五、添加远端登录账户
```bash
    #添加用户 admin  密码为 123456
    rabbitmqctl add_user admin 123456
    #将admin 设置为管理员权限
    rabbitmqctl set_user_tags admin administrator
    #将admin 设置为远端登录
    rabbitmqctl set_permissions -p / admin ".*" ".*" ".*"
```
###六、登录rabbitmq
访问地址： http://localhost:15672
![这里写图片描述](https://img-blog.csdn.net/20180816111555645?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3NpbmF0XzI4MTU2ODMx/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)
使用 admin  密码 123456 进行登录
![这里写图片描述](https://img-blog.csdn.net/20180816111636251?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3NpbmF0XzI4MTU2ODMx/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)
登录成功！！！
