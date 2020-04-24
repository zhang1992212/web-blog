---
title: Centos7安装go语言环境
date: 2020-01-25 15:45:07
tags: 
    - GO
    - Centos7
categories: 
    - GO
---

#### 下载、安装
安装包下载地址为：`https://golang.org/dl/`
##### 解压安装

    1、下载源码包：go1.8.3.linux-amd64.tar.gz

    2、将下载的源码包解压至 /usr/local目录。
<!-- more -->
    `tar -C /usr/local -xzf go1.8.3.linux-amd64.tar.gz`
    3、将 /usr/local/go/bin 目录添加至PATH环境变量：

```bash
vim /etc/profile
export PATH=$PATH:/usr/local/go/bin
source /etc/profile
```
4、查看版本信息
![这里写图片描述](https://imgconvert.csdnimg.cn/aHR0cDovL2ltZy5ibG9nLmNzZG4ubmV0LzIwMTcwNzE4MTAzMTQ1NjAx?x-oss-process=image/format,png)
