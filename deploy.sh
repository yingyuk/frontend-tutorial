#!/bin/bash

# 项目根目录
directory="`pwd`"
dirname="`dirname $0`"
ROOTDIR=$directory/$dirname

echo "$ROOTDIR/tmp/.git"

cd $ROOTDIR

if [ -d "tmp/.git" ]; then
  # 之前拉取过 gh-pages 分支, 更新远程的代码
  cd tmp
  git checkout -b gh-pages
  git reset --hard
  git clean -df
  git pull -f
else
  # 没有拉取过, 就克隆 gh-pages 分支
  mkdir -p tmp
  git clone -b gh-pages https://github.com/yingyuk/frontend-tutorial.git tmp
fi

cd $ROOTDIR

echo
echo '请输入 git commit message:'
read commitMessage

# 推送到 master
git add .
git commit -m "feat($commitMessage): update at $(date +'%Y-%m-%d %H:%M:%S')"
git push origin master

# 生成最新最新的页面
make build

# 推送到 gh-pages
cp -rf tmp/.git/ _book/.git/
cd _book/
git add .
git commit -m "feat($commitMessage): update at $(date +'%Y-%m-%d %H:%M:%S')"
git push origin gh-pages

cd $directory
