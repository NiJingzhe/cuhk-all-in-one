# SYNC — 仓库同步与知识贡献规范

本仓库 = **公共知识库**（main 分支，大家共享）+ 每个人的**私有层**（`~/.cuhk/personal`，在用户主目录、不在仓库里，永不上传）。所有使用本 skill 的用户与 agent 都遵守本文件。

## 仓库与安装

- 公共仓库：**https://github.com/NiJingzhe/cuhk-all-in-one**。两种装法，装完运行时**等价**：
  1. **`npx skills add NiJingzhe/cuhk-all-in-one`**（推荐；加 `-g` 装全局）— 自动适配各 agent 的 skills 目录（Claude Code / ZCode / Codex 等）。装出的是文件副本，首次会话 agent 运行 `scripts/git-setup.sh`（Windows 用 `scripts\git-setup.bat`）把它**原地 git 化**，此后 fork/PR/同步与 clone 形态完全一致。
  2. **`npx cuhk-all-in-one`**（npm 薄安装器，内部执行 git clone 到本机 skills 目录）或手动 `git clone` — 天然 git 形态。**不要用 Download ZIP**——同步流程依赖 git。
- **私有层路径**：`~/.cuhk/personal`（Windows：`%USERPROFILE%\.cuhk\personal`）。它不在仓库里，`npx skills update`、`git pull`、重装都碰不到它。
- **铁律级警告：禁止用 `npx skills update` 更新**——它整目录重刷，会连 `.git` 和未分享的改动一起清掉。更新只有一条路：会话启动协议里的 git 同步。
- 依赖：git（建议 ≥2.28）；GitHub CLI（`gh auth status` 确认已登录，开 PR 用）。
- **Push 权限假设**：**默认没有**。仓库是 public（人人可读、可 fork），但只有显式加为 collaborator 的账号才能直推主仓库分支；其他用户一律走 **fork 流程**（见「愿意分享 → 开 PR」第 1 步）——启动协议每次必检 gh 的原因就在这里：fork 和开 PR 都靠 gh。维护者备忘：日后若把同学加为 collaborator，又想强制一切改动走 PR 审核，需给 main 开 branch protection（当前未开，有写权限者可直推 main）。
- 维护者备忘：npm 包 `cuhk-all-in-one` 只是安装器外壳（`files` 白名单只含 `bin.js`）——知识更新与 npm 无关、无需重发；仅当改动 `bin.js`/安装流程时才需要本地 `npm publish` 同步外壳。

## 首次使用（一次性，按顺序执行）

1. **建私有层**：运行 `scripts/personal-init.sh`（Windows 用 `scripts\personal-init.bat`）→ 在 `~/.cuhk/personal/` 生成 `info.md`、`prs.md` 模板（已存在则自动跳过）。
2. **旧版迁移**：若 skill 目录里残留旧版 `personal/` 目录（历史版本把私有层放在仓库内），把其中**全部内容**并入 `~/.cuhk/personal/`（同名文件以较新者为准），然后把旧目录改名 `personal.migrated-bak` 留底。今后 skill 目录里**不应存在** `personal/`。
3. **询问用户**：学位层次（本科/硕士/博士）+ 专业名称。写入 `~/.cuhk/personal/info.md`。
4. 询问是否停用其他学科的知识目录。**推荐做法**：在 `info.md` 的 `enabled_subjects` 里只保留自己的学科，路由会跳过未启用目录（索引效率一样提升，且不动 git 跟踪的文件）。不建议物理删除学科目录——它们被 git 跟踪，删除会让工作区永久变脏、每次同步都冲突。

## 每次会话开始（同步流程，硬性前置——任何知识回答之前先跑完）

> 与 SKILL.md 的「会话启动协议」一致：本流程与用户问什么无关，哪怕只问一句小事也要先跑完；任何一步失败必须当场向用户报告，禁止静默略过。

1. **环境自检**：`gh auth status` 可用（不可用 → 如实告知用户"本会话无法开 PR"，后续分享流程相应降级）。
2. **git 化与同步**：运行 `scripts/git-setup.sh`（Windows 用 `scripts\git-setup.bat`）——无 `.git` 则原地 git 化，然后 fetch 并快进到 `origin/main`。
3. 读取 `~/.cuhk/personal/prs.md` 中登记的**每个**未结 PR：
   - 已 merged / closed → 删除本地对应 feat 分支，从 prs.md 移除该条记录；
   - 仍 open → 切换到该 feat 分支，`merge origin/main`（冲突处理见下文），push 更新远端，然后回到 main。
4. 全部处理完后停在 main，`git status` 必须干净（有脏 diff 先归位：属于 feat 分支的提交上去，其余按「不愿分享」落 personal 后还原工作区）。
5. 网络失败可跳过同步，但必须告知用户"本次未同步，本地知识可能落后于 main"。

## 会话中的知识沉淀

1. 新知识按 `knowledge/FORMAT.md` 写进 skill 目录的对应位置（此时只是工作区 diff，不提交）。
2. 工作接近尾声时，**询问用户是否愿意分享**这些新经验回公共仓库。

### 愿意分享 → 开 PR

1. **无 push 权限者先 fork**（collaborator 可跳过本步）：在本地 clone 内执行 `gh repo fork --remote`——以你的账号创建 fork，并添加名为 `fork` 的 git remote；此后所有 `git push` 推到 `fork`（`git push -u fork feat/xxx`）。
2. 从最新 main 开分支：`feat/<语义化短名>`（如 `feat/place-yasumoto-lt`）。
3. **分组提交**：一个逻辑组一个 commit（如每个地点文档一个 commit，playbook 更新一个 commit）。
4. push 分支，向 **main** 开 PR：
   - push 目标：collaborator 用 `origin`；fork 用户推自己的 `fork`
   - 开 PR：`gh pr create --repo NiJingzhe/cuhk-all-in-one --base main`（fork 用户加 `--head <你的用户名>:<分支名>`）
   - **标题**：`[YYYY-MM-DDTHH:MMZ] <语义化描述>`（UTC 时间戳，如 `[2026-09-07T14:30Z] add place guide for Yasumoto IAP`）
   - **描述**（严格结构化，缺一不可）：
     ```markdown
     ### Added
     - knowledge/common/place/yasumoto-iap.md
     ### Modified
     - knowledge/common/place/README.md
     ### Deleted
     - （无）
     ### Sources
     - https://… （每条核验过的来源）
     ### Freshness
     - 新增文档 stable_until: 2027-09-01
     ```
5. 把 PR 编号、分支名记入 `~/.cuhk/personal/prs.md`。回到 main。

> 开出的 PR 会由每日自动任务与维护者按 [`REVIEW.md`](REVIEW.md) 审核与裁决（格式、来源核验、语义冲突）。审核通过并合并后，下次会话开始时同步流程会自动清理本地 feat 分支。

### 不愿分享 → 落入 personal/

1. **新增的文件** → 移动到 `~/.cuhk/personal/` 下**同名相对路径**（`knowledge/common/place/x.md` → `~/.cuhk/personal/knowledge/common/place/x.md`）。
2. **修改的文件** → 把修改后的完整副本存到 `~/.cuhk/personal/` 同名相对路径（skill 目录里保持 main 版本）。
3. **还原 skill 目录**：`git restore . && git clean -fd knowledge/`——diff 不允许留在 skill 目录，它会被下一次同步或重装清掉，等于丢失。
4. prs.md 无需记录（没有远端产物）。

## 铁律：personal 优先

- 读任何知识文档前，若 `~/.cuhk/personal/` 下存在同相对路径文件，**一律以 personal 版本为准**。这条优先级高于 main 上的任何内容。
- 代价：被覆盖的文件收不到上游更新。每次同步时，对 personal 覆盖的每个文件检查 main 是否有更新，有则提示用户"上游有更新，是否查看差异/合并"。
- 私有层永远只存在于 `~/.cuhk/personal`：**永不**出现在 skill 目录里，永不提交、永不推送（它根本不在仓库内）。

## 冲突处理

- feat 分支 merge main 冲突：**公共知识以 main 为准，贡献内容以 feat 为准**；解不动就停下来问用户，不要强行自动合并。
- personal 层在仓库外，天然无 git 冲突；skill 目录内不允许残留任何未归位 diff。

## 私有层目录结构

```
~/.cuhk/personal/          （Windows: %USERPROFILE%\.cuhk\personal）
├── info.md      # 学位层次、专业、启用的学科路由
├── prs.md       # 我开的 PR 登记
├── prs-review.md # （可选，维护者）个人审核记录
└── knowledge/…  # 未分享的私有知识（与仓库根同构的相对路径）
```

**info.md 模板**（`scripts/personal-init.*` 自动生成，agent 询问用户后回填）：

```markdown
---
degree: master            # undergrad | master | phd
programme: MSc AI         # 专业名称
enabled_subjects:         # 路由只加载这些学科目录；留空数组 = 全部启用
  - msc-ai
updated: 2026-09-07
---
```

**prs.md 模板**：

```markdown
# 我的 PR 登记

| 分支 | PR | 状态 | 开启日期 | 内容 |
|---|---|---|---|---|
| feat/place-yasumoto-lt | #12 | open | 2026-09-07 | 康本园地点指南 |
```
