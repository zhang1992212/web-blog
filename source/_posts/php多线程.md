---
title: php多线程
date: 2018-03-25 15:45:17
tags:
    - 多线程
    - php
categires:
    - php
---

```php
//$num是控制开启进程的数量
$num = 8;
for ($i = 0; $i <$num ; $i++) {
    // 通过pcntl得到一个子进程的PID
    $pid = pcntl_fork ();
    if ($pid == - 1) {
        // 错误处理：创建子进程失败时返回-1.
        die ( 'could not fork!' );
    } elseif ($pid > 0) {
        // 父进程逻辑,等待子进程中断，防止子进程成为僵尸进程。
        // WNOHANG为非阻塞进程，具体请查阅pcntl_wait PHP官方文档
        pcntl_wait($status,WNOHANG);
        // $i--;
    } else {
        echo 'process ' . $i . "\n";
        echo getmypid()."\n";
        //调用实际业务逻辑方法
        run($i);
        echo "success\n";
        exit(0);
    }
}

function run($i) {
    //这里是业务逻辑
    echo $i . PHP_EOL;  
}
```
