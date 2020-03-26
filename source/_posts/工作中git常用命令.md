---
title: 工作中git常用命令
date: 2017-10-25 15:29:57
tags: 
    - git
    - 命令
categorites: 
    - git
---

#### 1. 克隆远端项目到本地

```bash
git clone git地址
```
#### 2.从远端获取项目

```bash
git fetch origin
```
<!-- more -->
#### 3.切换到要使用的分支

```bash
git checkout 分支名
```
#### 4.更新本地文件
 
```bash
git pull
```
#### 5.添加修改文件

```bash
git add .
```
#### 6.提交到本地文件

```bash
git commit -m "备注"
```
#### 7.提交到远端

```bash
git push origin 分支名
```
#### 8.合并分支

```bash
git merge --no-ff 分支名
```
#### 9.查看git状态

```bash
git status
```
#### 10.查看本地文件修改

```bash
git diff 文件名
```
#### 11.查看git日志

```bash
git log
```
