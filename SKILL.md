---
name: cuhk
description: "CUHK 香港中文大学校园生活知识库 — 校内巴士（校巴/上下课班车/收费小巴）班次站点与路线规划、校园公共服务、MSc AI 项目事务，以及查找 CUHK 官方信息的方法。Use whenever the user asks about CUHK campus life, campus shuttle or bus routes and schedules, or how to get somewhere on campus（中大校巴、班車、怎么去某栋楼、在哪下车）; new student orientation matters; MSc AI programme questions; or how to look up official CUHK information — even if they don't say \"CUHK\" explicitly."
---

# CUHK Campus Knowledge

帮助 CU 新生（尤其 non-native students）快速搞定校园服务和事务。技能包含两层：

1. **Baked knowledge**（`knowledge/`）— 已核验、写死在技能里的知识：事实数据（如校巴班次）、地点到达指南，以及查信息的方法（Common 路由的 `knowledge/common/search-playbook.md`）。回答时优先用，省去重复搜索。
2. **Search playbook**（即 `knowledge/common/search-playbook.md`，归在 Common 路由下）— 知识库没有现成答案时，教你去哪里、怎么找到官方信息。

## 会话开始与个人层（规范见 `SYNC.md`）

- **会话第一件事**：按 `SYNC.md` 同步——fetch origin 快进 main，按 `personal/prs.md` 逐个维护未结 PR（已 merged/closed 删本地 feat 分支；仍 open 则 merge 最新 main 后 push）。
- **首次使用**：确认 .gitignore 含 `personal/` → 创建 `personal/` → 询问用户学位层次与专业写入 `personal/info.md` → 询问是否停用其他学科路由（推荐在 info.md 的 enabled_subjects 里禁用，不物理删除）。
- **知识加载铁律**：`personal/` 下存在同相对路径文件时，**一律以 personal 为准**。
- **会话结束前**：新产生的知识问用户是否分享——愿意则开 `feat/*` 分支 + 结构化 PR（标题带 UTC 时间戳）并登记进 prs.md；不愿意则把新增/修改文件落到 `personal/` 同相对路径并 `git restore` 工作区。

## 路由

| 问题涉及 | 读 |
|---|---|
| 校巴 / 班车 / 小巴 / 校园交通 / 怎么去某地 / 在哪下车 | `knowledge/common/bus/README.md`；具体某栋楼 → `knowledge/common/place/README.md` |
| 其他全校性服务（图书馆、食堂、注册、签证……） | `knowledge/common/README.md` — 若无对应文档，转 `knowledge/common/search-playbook.md` |
| MSc AI 项目事务 / 某门课何时何地上课 | `knowledge/msc-ai/README.md`（项目信息）与 `knowledge/msc-ai/lesson/README.md`（课程索引）；作业/通知/成绩实时查 Blackboard，不 bake |
| 上面都没有 | `knowledge/common/search-playbook.md`（学科专属问题则查该学科自己的 search playbook，没有就照 Common 的方法给它建一个），查到后考虑沉淀为新文档（见下） |

## 新鲜度协议（必须遵守）

知识文档全部带 frontmatter（格式见 `knowledge/FORMAT.md`）。回答前先看：

1. **今天 > `freshness.stable_until`** → 该文档可能过期。先按 `freshness.check` 的方法复核，复核通过才可引用；来不及复核就明确告诉用户"此数据最后核验于 X，可能已过期"。
2. **用户提到"新安排/改线/改时间"或问题落在学期切换点（1 月 / 9 月）附近** → 视为可能过期，同样先复核。
3. **复核后**：更新文档正文中变化的事实 + 刷新 `verified` 块（日期、方法）。知识库因此自愈；这是每个使用者的义务，不是可选项。
4. 复核发现对不上且查不到新说法 → 把 `status` 改为 `stale` 并在正文顶部加一行"⚠️ 已发现与官方不符，待更新"。

## 回答规范

- 时刻/站点类回答**必须**带出处：来源 URL + `verified.date`，例如"（据 transport.cuhk.edu.hk，核验于 2026-09-07）"。
- 标注 `confidence: low` 或 ⚠️经验推断 的内容，回答时要说明这是经验建议而非官方数据。
- 路线规划类问题：给出方案时说清楚"坐几点的什么线、在哪上、在哪下、下车后怎么走"；多方案时按"换乘少 → 等待短"排序，并给一句风险提示（如末班车时间）。

## 沉淀规则

search playbook 查到的新信息，凡是"会被再次问到"的（班次、截止日期、办公室位置等），按 `knowledge/FORMAT.md` 的模板写成新文档放进对应路由目录，并更新该路由的 README 索引。只回答一次的东西不用沉淀。

**公共性红线**：本技能会被分享，内容必须按"任何同学可用"的口径书写——**禁止写入个人事务与私人工具链**（个人日历/笔记同步、私人账号与订阅、某个人的行程安排等）。涉及"我的课表/我的课程"这类数据时，写数据本身和公开来源（如"取自 CUSIS 课表"），不要写个人的加工流程。
