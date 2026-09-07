#!/usr/bin/env node
'use strict';
// npx github:NiJingzhe/cuhk-all-in-one — 把知识库 clone 到本机 skills 目录。
// 注意：知识库必须以 git clone 形态存在（贡献/同步流程依赖 git，见 SYNC.md），
// 因此本安装器执行 clone 而非文件拷贝；日常更新走 SYNC.md 的 git 同步，不走 npx。
const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');
const os = require('os');

const DEST = path.join(
  process.env.CUHK_SKILLS_DIR || path.join(os.homedir(), '.agents', 'skills'),
  'cuhk-all-in-one'
);
const REPO = 'https://github.com/NiJingzhe/cuhk-all-in-one.git';

if (fs.existsSync(path.join(DEST, '.git'))) {
  console.log(`已存在：${DEST}`);
  console.log('更新不要重跑本命令——进入该目录执行 git pull --ff-only（同步/贡献流程见 SYNC.md）。');
  process.exit(0);
}
execSync(`git clone "${REPO}" "${DEST}"`, { stdio: 'inherit' });
if (fs.existsSync(path.join(DEST, 'SKILL.md'))) {
  console.log(`✅ cuhk-all-in-one 已安装：${DEST}`);
  console.log('日常使用与更新见 SKILL.md 与 SYNC.md（贡献请走 feat 分支 + PR）。');
} else {
  console.error('❌ 安装异常：clone 完成但未找到 SKILL.md');
  process.exit(1);
}
