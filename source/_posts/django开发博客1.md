---
title: django 开发博客 --- 安装 (一)
date: 2020-03-25 15:46:21
tags:
---

# 安装django项目
### 一、  创建GeekBlog项目
```
django-admin startproject GeekBlog
```
###### 修改mysql配置项
```
cd GeekBlog
vim GeekBlog/settings.py
```
<!-- more -->
###### 找到 DATABASES 修改数据库配置

```
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'blog',
        'USER': '用户名',
        'PASSWORD': '密码',
        'HOST': '127.0.0.1',
        'PORT': 3306,
        'OPTIONS': {'charset': 'utf8mb4'},
    }
}
```
###### 修改django 中文显示 
```
LANGUAGE_CODE = 'zh-hans'

TIME_ZONE = 'Asia/Shanghai'
```
### 二、初始化数据库
###### 创建数据库，mysql数据库中执行:
```
CREATE DATABASE `geek_blog` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
```
###### 初始化数据库
```
./manage.py makemigrations
./manage.py migrate
```
###### 执行后如下图：
![](/media/editor/2_20191216111623270602.png)

### 三、初始化后台admin用户
```
python manage.py createsuperuser
```
![](/media/editor/3_20191216111923917038.png)
### 四、 启动服务器
###### 以8080端口开启服务器
```
python manage.py runserver 8080
```
![](/media/editor/4_20191216112437957520.png)
### 五、 访问页面
###### 访问前台
![](/media/editor/5_20191216112624819538.png)
###### 访问后台
![](/media/editor/6_20191216112651155150.png)
![](/media/editor/7_20191216112703516810.png)
