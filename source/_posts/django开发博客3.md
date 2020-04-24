---
title: django 开发博客 --- 博客首页 (三)
date: 2020-05-26 10:46:27
tags:
    - django
    - python
    - 博客
categories:
    - PYTHON
---

### 一、 设置html路径配置
###### 编辑GeekBlog/settings.py 配置TEMPLATES的DIRS， 这里设置的是根目录下的tempaltes目录
```python
TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [os.path.join(BASE_DIR, 'templates')],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]
```

<!-- more -->
### 二、设置首页控制器
###### 编辑blog/views.py
```python
from django.views.generic.list import ListView


# Create your views here.
class IndexView(ListView):
    # 首页
    # template_name属性用于指定使用哪个模板进行渲染
    template_name = 'blog/index.html'

    # context_object_name属性用于给上下文变量取名（在模板中使用该名字）
    context_object_name = 'blog_index'

    def get_queryset(self):
        return ''
```
### 三、 创建博客前台路由
###### 在blog目录下创建urls.py
```bash
vim blog/urls.py
```
###### 设置网站跟路由 定向到 IndexView方法下
```python
from django.urls import path
from . import views

app_name = 'blog'

urlpatterns = [
    path(r'', views.IndexView.as_view(), name='index'),
]
```
####### 将博客路由注册到根路由下
```bash
vim GeekBlog/urls.py
```
###### 将blog下的url引入
```python
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path(r'', include('blog.urls', namespace='blog'))
]
```
### 四、 配置博客首页
###### 在根目录下创建templates文件夹
###### 在templates下创建blog文件夹
###### 在blog下创建index.html

### 五、 博客前台布局文件创建  引入导航、底部
###### 在templates下创建layout文件夹（通用模板文件存放在此）
###### 创建base、nav、footer html文件
###### base.html 文件为布局文件 引入nav.html、footer.html
```python
{% include 'layout/nav.html' %}
{% include 'layout/footer.html' %}
```
#### 创建头部布局
###### 在base.html中添加
```python
{% block header %}

{% endblock %}
```
###### 在index.html 中重写
```python
{% block header %}
    新的头部
{% endblock %}
```
### 六、 配置博客导航
##### 1. 自定义tags
###### 在blog下创建templatetag文件夹，在templatetag下创建`blog_tag.py`和`__init__.py`文件

##### 2. 封装query tag
###### 在blog_tag.py 下 新增：
```python
from django import template

register = template.Library()


@register.simple_tag
def query(qs, **kwargs):
    """ template tag which allows queryset filtering. Usage:
          {% query books author=author as mybooks %}
          {% for book in mybooks %}
            ...
          {% endfor %}
    """
    return qs.filter(**kwargs)
```
##### 3. 封装自定义变量
###### 在blog下创建header.py (存放网站seo信息及导航信息)
```python
def seo_processor(requests):
    setting = get_blog_setting()
    value = {
        'SITE_NAME': setting.site_name,
        'SHOW_GOOGLE_AD': setting.show_google_ad,
        'GOOGLE_AD_CODES': setting.google_ad_codes,
        'SITE_SEO_DESCRIPTION': setting.site_seo_description,
        'SITE_DESCRIPTION': setting.site_description,
        'SITE_KEYWORDS': setting.site_keywords,
        'SITE_BASE_URL': requests.scheme + '://' + requests.get_host() + '/',
        'ARTICLE_SUB_LENGTH': setting.article_sub_length,
        'OPEN_SITE_COMMENT': setting.open_site_comment,
        'BEI_AN_CODE': setting.bei_an_code,
        'ANALYTICS_CODE': setting.analytics_code,
        "BEI_AN_CODE_GONG_AN": setting.gong_an_bei_an_code,
        "SHOW_GONG_AN_CODE": setting.show_gong_an_code,
        "CURRENT_YEAR": datetime.now().year
        #导航信息
        'nav_category_list': Category.objects.all(),
    }
    return value

```
###### 将网站变量注册到模板中
###### 编辑GeekBlog/settings.py
```python
TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [os.path.join(BASE_DIR, 'templates')],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
                # my common 变量
                'blog.header.get_nav',
            ],
        },
    },
]
```
###### 在html中使用
```python
{% load blog_tags %}
{% query category parent_id=0 deleted=0 as root_categorys %}

{% for node in root_categorys %}
{{ node.name }}
{% endfor %}
```
### 七、 配置侧边栏
###### 在blog/templatetags/blog_tags.py中加载siderbar.html
```python
@register.inclusion_tag('blog/tags/sidebar.html')
def load_sidebar():
    """
    加载侧边栏
    :return:
    """

    return {
        'a': 1
    }
```
###### 在templates/blog/tags下新建sidebar.html 在这个文件中写入侧边栏内容
