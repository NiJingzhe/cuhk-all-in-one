#!/usr/bin/env sh
# git-setup — 把 `npx skills add` 装出的副本原地 git 化（幂等），并同步上游。
# 只动 .git，绝不改动工作区文件；git clone 直装的目录跑它等于单纯 git 同步。
# 用法（skill 根目录）：sh scripts/git-setup.sh
set -eu
REPO_URL="https://github.com/NiJingzhe/cuhk-all-in-one.git"
cd "$(dirname "$0")/.."

if [ ! -d .git ]; then
  git init -q
  git symbolic-ref HEAD refs/heads/main
  git remote add origin "$REPO_URL" 2>/dev/null || git remote set-url origin "$REPO_URL"
  echo "-> Initialized git repo (origin = $REPO_URL)"
else
  git remote add origin "$REPO_URL" 2>/dev/null || git remote set-url origin "$REPO_URL"
fi

git fetch origin --quiet

if git rev-parse --verify -q HEAD >/dev/null 2>&1; then
  git merge --ff-only origin/main
else
  # 首次对齐：分支指向 origin/main，工作区文件保持原样（未提交的新知识会以 diff 形式保留）
  git reset origin/main -q
  echo "-> Aligned local main to origin/main (working files untouched)"
fi

echo "OK git ready: $(git log --oneline -1)"
