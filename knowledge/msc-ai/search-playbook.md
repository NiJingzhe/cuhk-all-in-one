---
title: MSc AI 信息源手册（学科级 search playbook）
topic: msc-ai-search
kind: procedure
scope: msc-ai
audience: msc-ai
status: fresh
source:
  - name: 初始线索（自 Common playbook 迁入，未逐一核验）
    url: https://www.engg.cuhk.edu.hk/
verified:
  date: 2026-09-07
  method: 目前全部是未核验线索；每条实测后更新该条目置信度并回写本块
  by: ZCode session sess_a4f8620e-b4e8-4d18-a713-752b57a48cb9
freshness:
  stable_until: 2027-09-01
  expires_when: 条目指向的站点改版/失效，或项目更名（如毕业要求的学年变化）
  check: 方法类文档无需定期复核；每次实际使用某条目成功/失败后，顺手更新该条目与 verified.date
confidence: low
---

# MSc AI 信息源手册

学科级 search playbook：只收 **MSc AI 相关**的信息源与查法。全校通用的方法（官方域名优先、公告常是图片、小红书抓取等）见 `[[../common/search-playbook]]`，此处不重复。

## 信息源

| 主题 | 线索 | 置信 |
|---|---|---|
| 项目官网 | **mscai.erg.cuhk.edu.hk** — 课程名录 /programme structure/People/FAQ；页脚：项目办 mscai@cuhk.edu.hk，何善衡工程楼 606 室（2026-09-07 抓取验证，正式条目见 [[programme]]） | high |
| 工程学院 | engg.cuhk.edu.hk（学院通知、活动） | medium |
| 选课系统 | CUSIS（cusis.cuhk.edu.hk）Manage Classes = 课表权威来源；用法见 [[../common/search-playbook]] 的 CUSIS 条目 | high |
| 作业/通知 | Blackboard（blackboard.cuhk.edu.hk/ultra/stream）——**实时信息现场查**；用法与 prebake 边界见 [[../common/search-playbook]] 的 Blackboard 条目 | high |
| 课程评价参考 | cutopia.app（学生评价，社区性质） | low |
| 项目办邮箱 | mscai@cuhk.edu.hk（选课/毕业/休学等问题邮件优先） | high |

## 使用规则

1. 核实某条目 → 更新置信度、补充确切 URL，回写 `verified` 块。
2. 查到"会被再次问到"的事实（截止日期、项目办联系方式、毕业要求、教授是谁、考核方式）→ 按 `../FORMAT.md` 沉淀：项目层信息进 [[programme]]，课程层信息进 `lesson/<课程>.md`。
3. 反复用到的学科查询方法 → 补进本手册，不塞进 Common。
