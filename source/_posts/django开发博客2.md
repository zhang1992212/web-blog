---
title: django 开发博客 --- 创建新app (二)
date: 2020-05-25 14:02:24
tags:
    - django
    - python
    - 博客
categories:
    - PYTHON
---

### 一、 创建新APP
```bash
python startapp blog
```
###### 执行成功后 在项目目录下生成 blog 目录

<!-- more -->
### 二、 注册APP
```bash
vim GeekBlog/settings,py
```
###### 在INSTALLED_APPS里追加 blog
![](/media/editor/8_20191216113902837014.png)
### 三、 创建公共文件夹、创建通用model类文件
###### 在根目录下创建common文件夹（此文件夹下存放公共通用文件）
```bash
mkdir common
vim BaseModel.py
```
###### 在BaseModel中新增：
```python
from django.db import models
from django.utils.timezone import now
from django.core.validators import MaxValueValidator


class BaseModel(models.Model):
    DELETED = ((0, "否"), (1, "是"))

    id = models.AutoField(primary_key=True)
    deleted = models.SmallIntegerField('删除', default=0, choices=DELETED, validators=[MaxValueValidator(2)],
                                       editable=False)
    create_time = models.DateTimeField('创建时间', default=now, editable=False)
    update_time = models.DateTimeField('修改时间', default=now, editable=False)

    class Meta:
        abstract = True
```
### 四、 新增分类 model
###### 编辑blog/models.py
```bash
vim blog/models.py
```
###### 修改如下：
```python
from django.db import models
from common.BaseModel import BaseModel
from django.urls import reverse


# Create your models here.


class Category(BaseModel):
    """ 分类表 """
    name = models.CharField('名称', max_length=100, unique=True)
    parent_id = models.IntegerField('父级id', default=0, editable=False)

    class Meta:
        ordering = ['id']
        verbose_name = '分类'
        verbose_name_plural = verbose_name

    def get_absolute_url(self):
        return reverse('blog:category', kwargs={'id': self.id})
```
### 五、 执行migration 创建分类表
```bash
python manage.py makemigrations
python manage.py migrate
```
###### 执行成功后，查看数据库，发现blog_category表 创建成功
### 六、 后台注册blog模块下的category
###### 编辑blog/admin.py
```bash
vim blog/admin.py
```
###### 引入models中的Category模块并注册
```python
from blog.models import Category

# Register your models here.
admin.site.register(Category)
```

###### 刷新后台发现blog模块下的category已经显示出来了。
![](/media/editor/1_20191216140921062450.png)
