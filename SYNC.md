# SYNC — 仓库同步与知识贡献规范

本仓库 = **公共知识库**（main 分支，大家共享）+ 每个人的**私有层**（`personal/`，已被 .gitignore，永不上传）。所有使用本 skill 的用户与 agent 都遵守本文件。

## 仓库与安装

- 公共仓库：**https://github.com/NiJingzhe/cuhk-all-in-one**。安装 = `npx github:NiJingzhe/cuhk-all-in-one`（内部执行 git clone 到本机 skills 目录；也可手动 `git clone`，但**不要用 Download ZIP**——同步流程依赖 git），仓库根就是 skill 根。
- 依赖：git；GitHub CLI（`gh auth status` 确认已登录，开 PR 用）。
- **Push 权限假设**：**默认没有**。仓库是 public（人人可读、可 fork），但只有显式加为 collaborator 的账号才能直推主仓库分支；其他用户一律走 **fork 流程**（见「愿意分享 → 开 PR」第 1 步）——启动协议每次必检 gh 的原因就在这里：fork 和开 PR 都靠 gh。维护者备忘：日后若把同学加为 collaborator，又想强制一切改动走 PR 审核，需给 main 开 branch protection（当前未开，有写权限者可直推 main）。

## 首次使用（一次性，按顺序执行）

1. **检查 .gitignore 含 `personal/`**。没有就立刻加上——这一步防止私人信息被提交到公共仓库，**必须做，不可跳过**。
2. 创建 `personal/` 目录（结构见文末；`info.md`、`prs.md` 模板见文末）。
3. **询问用户**：学位层次（本科/硕士/博士）+ 专业名称。写入 `personal/info.md`。
4. 询问是否停用其他学科的知识目录。**推荐做法**：在 `personal/info.md` 的 `enabled_subjects` 里只保留自己的学科，路由会跳过未启用目录（索引效率一样提升，且不动 git 跟踪的文件）。不建议物理删除学科目录——它们被 git 跟踪，删除会让工作区永久变脏、每次同步都冲突。

## 每次会话开始（同步流程，第一件事）

前提：工作区干净（有未提交改动先提交到当前 feat 分支或暂存）。

1. `git fetch origin`，将本地 main 快进到 `origin/main`。
2. 读取 `personal/prs.md` 中登记的**每个**未结 PR：
   - 已 merged / closed → 删除本地对应 feat 分支，从 prs.md 移除该条记录；
   - 仍 open → 切换到该 feat 分支，`merge origin/main`（冲突处理见下文），push 更新远端，然后回到 main。
3. 全部处理完后停在 main。
4. 网络失败可跳过同步，但必须告知用户"本次未同步，本地知识可能落后于 main"。

## 会话中的知识沉淀

1. 新知识按 `knowledge/FORMAT.md` 写进**正常目录**的对应位置（此时只是工作区 diff，不提交）。
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
5. 把 PR 编号、分支名记入 `personal/prs.md`。回到 main。

> 开出的 PR 会由每日自动任务与维护者按 [`REVIEW.md`](REVIEW.md) 审核与裁决（格式、来源核验、语义冲突）。审核通过并合并后，下次会话开始时同步流程会自动清理本地 feat 分支。

### 不愿分享 → 落入 personal/

1. **新增的文件** → 移动到 `personal/` 下**同名相对路径**（`knowledge/common/place/x.md` → `personal/knowledge/common/place/x.md`）。
2. **修改的文件** → 把修改后的完整副本存到 `personal/` 同名相对路径（原文件保持 main 版本）。
3. **`git restore` 还原工作区**，确保回到干净的 main——diff 不允许留在工作区。
4. prs.md 无需记录（没有远端产物）。

## 铁律：personal 优先

- 读任何知识文档前，若 `personal/` 下存在同相对路径文件，**一律以 personal 版本为准**。这条优先级高于 main 上的任何内容。
- 代价：被覆盖的文件收不到上游更新。每次同步时，对 personal 覆盖的每个文件检查 main 是否有更新，有则提示用户"上游有更新，是否查看差异/合并"。

## 冲突处理

- feat 分支 merge main 冲突：**公共知识以 main 为准，贡献内容以 feat 为准**；解不动就停下来问用户，不要强行自动合并。
- `personal/` 永不提交、永不推送：.gitignore 兜底 + 提交前 `git status` 自查（不应出现任何 `personal/` 条目）。

## personal/ 目录结构

```
personal/
├── info.md      # 学位层次、专业、启用的学科路由（模板见下）
├── prs.md       # 我开的 PR 登记（模板见下）
└── knowledge/…  # 未分享的私有知识（与仓库根同构的相对路径）
```

**info.md 模板**：

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
