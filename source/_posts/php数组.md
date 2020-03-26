---
title: php数组
date: 2017-10-25 15:45:48
tags:
    - php
    - array
    - 数组
categires:
    - php
---

# PHP数组函数

1. array_flip() 反转数组中所有的键以及它们关联的值
---------------------------------
```php
    $a1=array("a"=>"red","b"=>"green","c"=>"blue","d"=>"yellow");
    $result=array_flip($a1);
    print_r($result);
```
## 输出结果：

``` bash
    Array ( [red] => a [green] => b [blue] => c [yellow] => d )
```
