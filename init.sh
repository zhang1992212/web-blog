#!/usr/bin/env sh
cd /data/git
appName = "web-blog"
if [ ! -d "$appName" ]; then
    echo '初始化版本库...'
    git clone git@github.com:zhang1992212/web-blog.git $appName
    cd $appName
    echo '初始化框架'
    chown -R www:www .
else
    cd $appName
fi

read -p '请输入要发布的分支名称[master]:' branch

echo "拉取远程分支信息"
git fetch

echo "切换版本库分支到：$branch"
git checkout ${branch:-master}

echo '拉取分支代码...'
git pull git@github.com:zhang1992212/web-blog.git ${branch:-master}

if [ ! -d "node_modules" ]; then
	echo "安装hexo..."
	npm install hexo --save
fi

echo "清理html"
hexo clean

echo "生成html"
hexo deploy

echo "同步html"
rsync -avzp --delete $exclude --exclude=.git /data/git/web-blog/public/ /data/geek/web-blog

echo "发布完成"