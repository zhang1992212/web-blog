---
title: thinkphp5源码分析一
date: 2018-09-01 12:22:52
tags: 
	- thinkphp5 
	- php
	- 源码分析
categories: 
    - PHP
id:
	- 1
---
#### 1 入口文件源代码(/public/index.php) 

----------

```php
 // [ 应用入口文件 ]
 // 定义应用目录
 define('APP_PATH', __DIR__ . '/../application/');
 // 加载框架引导文件
 require __DIR__ . '/../thinkphp/start.php';
```
