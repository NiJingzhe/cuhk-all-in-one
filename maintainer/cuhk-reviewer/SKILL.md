---
name: maintainer-reviewer
description: 审核 github.com/NiJingzhe/cuhk-all-in-one（CUHK 知识库）的开放 PR——执行审核清单、语义冲突实体扫描、打标签发结构化评论、按保守边界自动合并。Use when asked to review/审核 the cuhk-all-in-one knowledge repo's PRs, or when the daily review task fires. Not for PR reviews outside this repo.
---

# cuhk-reviewer — 知识库 PR 审核操作手册

**规则与裁决层级以仓库根 `REVIEW.md` 为准，本 skill 只负责"怎么执行"。** 审核对象：`NiJingzhe/cuhk-all-in-one` 的 open PR。

## 前置检查

1. 本地 clone：默认 `/Users/lildino/Project/ocws/cuhk-skill`（其他维护者以各自路径为准）。`git fetch origin && git checkout main && git pull --ff-only`。
2. `gh auth status` 确认认证。
3. `gh pr list --repo NiJingzhe/cuhk-all-in-one --state open` —— 无 open PR 直接结束。

## 每个 PR 的审核步骤

1. `gh pr view <N>` 读描述（必须含 Added/Modified/Deleted/Sources/Freshness 四段），`gh pr diff <N>` 读改动。
2. 逐项过 REVIEW.md 审核清单：
   - 格式：四段齐全 + 每个改动文件 frontmatter 符合 `knowledge/FORMAT.md`；
   - 公共性红线：diff 中扫个人事务/私人工具链关键词（日历同步、私人账号、某人的行程等）；
   - 路由范围：学科内容不得进 `knowledge/common/`，反之亦然；
   - 来源核验：Sources 里每个 URL `curl -sI` 查可达；官方数据类事实（时刻/班次）与 `knowledge/common/bus/` 现有数据比对，PR 声称官方已变更时必须附新公告链接。
3. **语义冲突扫描**：跑 `scripts/entity_scan.sh <PR号>`，得到"涉及实体 → main 与其他 open PR 中的出现位置"。对每个命中点判断是否构成 REVIEW.md 的情形 B（同文件不同段矛盾）/ 情形 C（跨文件跨 PR 矛盾）。
4. 按结论打标签（不存在先 `gh label create <name> --color <hex>`）：
   - `ready`（清单全过且无语义冲突）
   - `semantic-conflict`（命中 B/C）
   - `needs-source`（来源缺失/不可达/不支撑）
   - `needs-format`（格式或红线不达标）
5. 发结构化评论（模板见下）。

## 评论模板

```markdown
## 🤖 自动审核（YYYY-MM-DD）

| 清单项 | 结果 |
|---|---|
| 描述四段 | ✅/❌ |
| FORMAT frontmatter | ✅/❌ |
| 公共性红线 | ✅/❌ |
| 路由范围 | ✅/❌ |
| 来源核验 | ✅/⚠️（列出不可达或存疑的 URL） |
| 语义冲突扫描 | ✅ 无冲突 / ⚠️ 命中：<实体> × <位置>（情形 B/C） |

**结论**：<ready | semantic-conflict | needs-source | needs-format>
<给作者的一句话：缺什么、怎么改、依据裁决层级第几条>
```

## 合并（保守边界，绝不越过）

- **仅** `ready` 且**只新增文件**（不修改任何既有事实表/既有段落）→ 合并前重跑与其余 open PR 的实体比对 → `gh pr merge <N> --merge`。
- 修改既有事实表的 PR：**永不自动合并**，打 `ready` 后留给维护者人工确认。
- `semantic-conflict`：能按 REVIEW.md 裁决层级明确裁决的就裁决（评论中写明依据第几条），拿不准 → 转 issue 并 @ 维护者。

## 边界情况

- 作者 force-push 导致 diff 变化 → 重跑整个清单，旧结论作废。
- PR 作者 = 审核执行者（cron 场景下提交者是本机用户）→ 跳过自动合并，只发评论与标签，人工处理。
- 分叉冲突（PR 落后 main 很多）→ 评论提醒作者按 SYNC.md merge main，不代劳。

## 记录

- 本次处理逐条追加到 `personal/prs-review.md`（日期、PR 号、结论、是否合并、遗留冲突）。
- 结束时输出一行摘要：处理 N 个、自动合并 M 个、遗留冲突 K 个。
