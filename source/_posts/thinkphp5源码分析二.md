---
title: thinkphp5源码分析二 框架引导
date: 2018-09-01 14:22:52
tags: 
    - thinkphp5 
    - php
    - 源码分析
categories: 
    - PHP
id:
	- 2
---

#### 框架引导文件源代码 (/thinkphp/start.php)

##### 1.引入基础文件（/thinkphp/base.php）

```php
// 加载基础文件
require __DIR__ . '/base.php';
```
###### 基础文件（/thinkphp/base.php）

<!-- more -->
##### 2.定义系统常量

```php
define('THINK_VERSION', '5.0.9');
define('THINK_START_TIME', microtime(true));
define('THINK_START_MEM', memory_get_usage());
define('EXT', '.php');
define('DS', DIRECTORY_SEPARATOR);
defined('THINK_PATH') or define('THINK_PATH', __DIR__ . DS);
define('LIB_PATH', THINK_PATH . 'library' . DS);
define('CORE_PATH', LIB_PATH . 'think' . DS);
define('TRAIT_PATH', LIB_PATH . 'traits' . DS);
defined('APP_PATH') or define('APP_PATH', dirname($_SERVER['SCRIPT_FILENAME']) . DS);
defined('ROOT_PATH') or define('ROOT_PATH', dirname(realpath(APP_PATH)) . DS);
defined('EXTEND_PATH') or define('EXTEND_PATH', ROOT_PATH . 'extend' . DS);
defined('VENDOR_PATH') or define('VENDOR_PATH', ROOT_PATH . 'vendor' . DS);
defined('RUNTIME_PATH') or define('RUNTIME_PATH', ROOT_PATH . 'runtime' . DS);
defined('LOG_PATH') or define('LOG_PATH', RUNTIME_PATH . 'log' . DS);
defined('CACHE_PATH') or define('CACHE_PATH', RUNTIME_PATH . 'cache' . DS);
defined('TEMP_PATH') or define('TEMP_PATH', RUNTIME_PATH . 'temp' . DS);
defined('CONF_PATH') or define('CONF_PATH', APP_PATH); // 配置文件目录
defined('CONF_EXT') or define('CONF_EXT', EXT); // 配置文件后缀
defined('ENV_PREFIX') or define('ENV_PREFIX', 'PHP_'); // 环境变量的配置前缀
// 环境常量
define('IS_CLI', PHP_SAPI == 'cli' ? true : false);
define('IS_WIN', strpos(PHP_OS, 'WIN') !== false);
```
##### 3.载入Loader类(/thinkphp/library/think/Loader.php)

```php
// 载入Loader类
require CORE_PATH . 'Loader.php';
```
##### 4.加载环境变量配置文件（/.env）

```php
// 加载环境变量配置文件
if (is_file(ROOT_PATH . '.env')) {
    $env = parse_ini_file(ROOT_PATH . '.env', true);
    foreach ($env as $key => $val) {
        $name = ENV_PREFIX . strtoupper($key);
        if (is_array($val)) {
            foreach ($val as $k => $v) {
                $item = $name . '_' . strtoupper($k);
                putenv("$item=$v");
            }
        } else {
            putenv("$name=$val");
        }
    }
}
```
##### 5.注册自动加载

```php
// 注册自动加载
\think\Loader::register();
```
Loader类（/thinkphp/library/think/Loader.php） 
##### 6. 注册系统自动加载

```php
// 注册系统自动加载
spl_autoload_register($autoload ?: 'think\\Loader::autoload', true, true);
```
##### 7.注册命名空间定义

```php
// 注册命名空间定义
 self::addNamespace([
    'think'    => LIB_PATH . 'think' . DS,
    'behavior' => LIB_PATH . 'behavior' . DS,
    'traits'   => LIB_PATH . 'traits' . DS,
 ]);
```
![这里写图片描述](https://imgconvert.csdnimg.cn/aHR0cDovL2ltYWdlczIwMTUuY25ibG9ncy5jb20vYmxvZy8xMDQwMzc4LzIwMTcwNi8xMDQwMzc4LTIwMTcwNjIxMTcxNDUxNDc2LTIwNjc5Mjk3MTQucG5n?x-oss-process=image/format,png)
##### 8. 加载类库映射文件（/runtime/classmap.php）

```php
 // 加载类库映射文件
 if (is_file(RUNTIME_PATH . 'classmap' . EXT)) {
    self::addClassMap(__include_file(RUNTIME_PATH . 'classmap' . EXT));
 }
```
##### 9.composer自动加载（/vendor/composer/）

```php
// Composer自动加载支持
 if (is_dir(VENDOR_PATH . 'composer')) {
     self::registerComposerLoader();
 }
```
##### 10.自动加载extend目录（/extend）

```php
// 自动加载extend目录
self::$fallbackDirsPsr4[] = rtrim(EXTEND_PATH, DS);
```
##### 11.注册错误和异常处理机制（/thinkphp/library/think/Error.php）

```php
// 报告所有错误
error_reporting(E_ALL);
//设置用户自定义的错误处理程序
set_error_handler([__CLASS__, 'appError']);
// 设置用户定义的异常处理函数
set_exception_handler([__CLASS__, 'appException']);
//定义PHP程序执行完成后执行的函数
register_shutdown_function([__CLASS__, 'appShutdown']);
```
##### 12.加载惯例配置文件(/thinkphp/convention.php)

```php
 // 加载惯例配置文件
 \think\Config::set(include THINK_PATH . 'convention' . EXT);
```
