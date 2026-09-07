# 知识文档格式

每份知识文档 = YAML frontmatter（机器判读：能不能用、怎么复核）+ 正文（人/模型可读的事实）。任何 agent 写入或修改知识文档，都必须遵守本格式。

## Frontmatter 模板

```yaml
---
title: 校园巴士线路总表          # 中文标题
topic: bus                     # 主题域 slug，如 bus / library / registry / msc-ai-courses
kind: fact-sheet               # fact-sheet(数据表) | procedure(流程) | contact(联系方式) | policy(规则) | event(有时限的活动) | place(地点到达指南)
scope: common                  # common(全校) | msc-ai(学科)
audience: all                  # all | student | staff | msc-ai
status: fresh                  # fresh | stale（复核失败且无法更新时置 stale）
source:                        # 事实来源。可验证性的根基：每条可过期的事实都要能溯源到 URL
  - name: CUHK Transport Office
    url: https://transport.cuhk.edu.hk/route/2/
verified:                      # 最后一次人工/agent 核验记录
  date: 2026-09-07
  method: 抓取官网线路页并与 2026-09-01 官方公告 TSP/ISI/2026/17 交叉比对
  by: ZCode session sess_a4f8620e-b4e8-4d18-a713-752b57a48cb9
freshness:                     # 可判定过期：三个字段缺一不可
  stable_until: 2027-09-01     # 预计稳定到的日期（硬期限），超过必须复核。通常是下一学期开始日
  expires_when: |              # 过期条件（声明式，提前判过期）
    - 官网出现 2026/27 下学期及以后的班次调整公告
    - 任一观察事实（班次、站点、时刻）与本文档不符
  check: |                     # 复核方法（给 agent 的可执行步骤）
    按 knowledge/common/search-playbook.md 的"校园交通"条目重抓线路页比对
confidence: high                # high(官方来源直读) | medium(官方来源但表述含糊/二手) | low(经验推断,未核验)
---
```

## 引用约定（Obsidian 风格，防知识重复）

知识之间**用引用，不要复制**。班次、票价这类易变数据只存在于 bus 等基础文档里，其他文档（尤其 place/）引用它们：

```
[[<相对路径>#<标题>]]        例：[[../bus/routes-shuttle#2 — NA / UC（新亚/联合）]]
[[<相对路径>]]               引用整份文档
```

- 路径相对当前文件；标题必须与目标文件中的 `##` 标题逐字一致（含空格与标点）。
- 引用是"读取指令"：agent 回答前应真的打开被引用文档核对最新数值，而不是凭记忆复述。
- 写新知识前先搜一下库内是否已有该事实——有就引用，没有才新写。

## 正文约定

1. **可过期的事实用表格**，并在表格下一行标注核验信息：`> 核验：2026-09-07，来源：<URL>`。禁止把时刻写进散文句子里——表格才能逐格更新。
2. **经验推断必须显式隔离**：官方没有、但确实有用的经验（比如"在哪下车走哪边近"），放进单独的 `## 经验推断（非官方）` 小节，每条前加 ⚠️，回答用户时要如实说明。禁止把经验混写进官方数据表。
3. **双语**：中文叙述 + 保留官方英文原文（站名、规则原文），必要时附中文对照。官方原文照录优先于翻译——翻译错了没有救。
4. **一份文档一个主题**：宁可多个小文件，不要一个万能大文件。每个路由目录必须有 `README.md` 做索引（问题类型 → 该读哪个文件）。
5. **event 类文档**（迎新、讲座、截止日期）在 `freshness.stable_until` 写事件结束日；过期后不必删除，但 agent 不得当作有效信息引用。

## 判定"过期"的完整逻辑

```
today > stable_until            → 疑似过期，先复核
status: stale                   → 过期，先复核后才能用（并告知用户）
expires_when 任一条件成立        → 过期
kind: event 且事件已结束         → 过期
以上都不成立                     → 可直接引用，回答仍需带 verified.date
```

## 新建文档的最短路径

复制上面模板 → 填 source（没有 URL 的事实不允许入库）→ 正文表格写事实 → 按"下一学期开始日"填 stable_until → 更新所在路由的 README 索引。
