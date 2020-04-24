---
title: thinkphp5源码分析三 应用启动
date: 2018-09-01 18:22:52
tags: 
    - thinkphp5 
    - php
    - 源码分析
categories: 
    - PHP
---

#### 框架引导文件源代码 (/thinkphp/start.php)

```php
// 执行应用
App::run()->send();
```
<!-- more -->
##### 1.应用启动（/thinkphp/library/think/App.php）

```php
//初始化请求实例
is_null($request) && $request = Request::instance();
```
##### 2.添加APP命名空间（app => /application）

```php
//添加app命名空间
if (defined('APP_NAMESPACE')) {
 self::$namespace = APP_NAMESPACE;
}
Loader::addNamespace(self::$namespace, APP_PATH);
```
##### 3.初始化应用

```php
// 初始化应用
 $config       = self::init();
```

```php
// 定位模块目录
  $module = $module ? $module . DS : '';

  // 加载初始化文件
  if (is_file(APP_PATH . $module . 'init' . EXT)) {
    include APP_PATH . $module . 'init' . EXT;
  } elseif (is_file(RUNTIME_PATH . $module . 'init' . EXT)) {
    include RUNTIME_PATH . $module . 'init' . EXT;
  } else {
  $path = APP_PATH . $module;
  // 加载模块配置
  $config = Config::load(CONF_PATH . $module . 'config' . CONF_EXT);

  // 读取数据库配置文件
  $filename = CONF_PATH . $module . 'database' . CONF_EXT;
  Config::load($filename, 'database');
  // 读取扩展配置文件
  if (is_dir(CONF_PATH . $module . 'extra')) {
     $dir   = CONF_PATH . $module . 'extra';
     $files = scandir($dir);
     foreach ($files as $file) {
        if (strpos($file, CONF_EXT)) {
             $filename = $dir . DS . $file;
             Config::load($filename, pathinfo($file, PATHINFO_FILENAME));
          }
      }
   }
   // 加载应用状态配置
   if ($config['app_status']) {
       $config = Config::load(CONF_PATH . $module . $config['app_status'] . CONF_EXT);
     }
   // 加载行为扩展文件(中间件 权限控制可以配置加在这里)
   if (is_file(CONF_PATH . $module . 'tags' . EXT)) {
       Hook::import(include CONF_PATH . $module . 'tags' . EXT);
    }
    // 加载公共文件
    if (is_file($path . 'common' . EXT)) {
        include $path . 'common' . EXT;
    }

    // 加载当前模块语言包
    if ($module) {
       Lang::load($path . 'lang' . DS . Request::instance()->langset() . EXT);
    }
```
##### 4.绑定模块、控制器

```php
if (defined('BIND_MODULE')) {
     // 模块/控制器绑定
     BIND_MODULE && Route::bind(BIND_MODULE);
} elseif ($config['auto_bind_module']) {
       // 入口自动绑定
    $name = pathinfo($request->baseFile(), PATHINFO_FILENAME);
    if ($name && 'index' != $name && is_dir(APP_PATH . $name)) {
            Route::bind($name);
     }
}
```
##### 5.加载语言

```php
// 默认语言
Lang::range($config['default_lang']);
if ($config['lang_switch_on']) {
    // 开启多语言机制 检测当前语言
    Lang::detect();
}
$request->langset(Lang::range());

// 加载系统语言包
Lang::load([
    THINK_PATH . 'lang' . DS . $request->langset() . EXT,
    APP_PATH . 'lang' . DS . $request->langset() . EXT,
]);
```
##### 6.获取应用调度信息

```php
// 获取应用调度信息
$dispatch = self::$dispatch;

if (empty($dispatch)) {
    // 进行URL路由检测
    $dispatch = self::routeCheck($request, $config);
}
```
##### 7.记录路由和请求信息

```php
// 记录路由和请求信息
if (self::$debug) {
    Log::record('[ ROUTE ] ' . var_export($dispatch, true), 'info');
    Log::record('[ HEADER ] ' . var_export($request->header(), true), 'info');
    Log::record('[ PARAM ] ' . var_export($request->param(), true), 'info');
}
```
##### 8.构造页面输出 （查看thinkphp5 源码分析四 数据构造）

```php
 // 请求缓存检查
 $request->cache($config['request_cache'], $config['request_cache_expire'],        
 $config['request_cache_except']);
 // 查看thinkphp5 源码分析四 数据构造
 $data = self::exec($dispatch, $config);
```
##### 9.清空Loader类的实例化

```php
// 清空Loader类的实例化
Loader::clearInstance();
```
##### 10.输出数据

```php
// 输出数据到客户端
if ($data instanceof Response) {
    // 是否是 response 的实例
    $response = $data;
} elseif (!is_null($data)) {
    // 默认自动识别响应输出类型
    $isAjax   = $request->isAjax();
    $type     = $isAjax ? Config::get('default_ajax_return') : Config::get('default_return_type');
    $response = Response::create($data, $type);
} else {
    $response = Response::create();
}
```
##### 11.发送数据到客户端

```php
// 处理输出数据
$data = $this->getContent();
// Trace调试注入
if (Env::get('app_trace', Config::get('app_trace'))) {
    Debug::inject($this, $data);
}

if (200 == $this->code) {
    $cache = Request::instance()->getCache();

    if ($cache) {
        $this->header['Cache-Control'] = 'max-age=' . $cache[1] . ',must-revalidate';
        $this->header['Last-Modified'] = gmdate('D, d M Y H:i:s') . ' GMT';
        $this->header['Expires']       = gmdate('D, d M Y H:i:s', $_SERVER['REQUEST_TIME'] + $cache[1]) . ' GMT';
        Cache::set($cache[0], [$data, $this->header], $cache[1]);
    }
}

if (!headers_sent() && !empty($this->header)) {
    // 发送状态码
    http_response_code($this->code);
    // 发送头部信息
    foreach ($this->header as $name => $val) {
        if (is_null($val)) {
            header($name);
        } else {
            header($name . ':' . $val);
        }
    }
}

//输出数据
echo $data;

if (function_exists('fastcgi_finish_request')) {
    // 提高页面响应
    fastcgi_finish_request();
}

// 监听response_end
Hook::listen('response_end', $this);

// 清空当次请求有效的数据
if (!($this instanceof RedirectResponse)) {
    //清空SESSION
    Session::flush();
}
```
