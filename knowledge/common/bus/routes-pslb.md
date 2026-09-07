---
title: PSLB 收费小巴（Shuttle Minibus Up/Down）
topic: bus
kind: fact-sheet
scope: common
audience: all
status: fresh
source:
  - name: CUHK Transport Office — PSLB Up/Down 线路页
    url: https://transport.cuhk.edu.hk/route/up/
verified:
  date: 2026-09-07
  method: 抓取官网 Up/Down 线路页（U 形站序图解析，含全部 Service Hours 时段块）
  by: ZCode session sess_a4f8620e-b4e8-4d18-a713-752b57a48cb9
freshness:
  stable_until: 2027-09-01
  expires_when: |
    - 票价、时段或站点与本文档不符
    - 官网出现小巴调整公告
  check: |
    按 ../search-playbook.md"校园交通"条目，重抓 /route/up/ 与 /route/down/
confidence: high
---

# PSLB 收费小巴（$5.5，公众可乘）

往返**大学站（港铁）↔ 山上宿舍区**的穿梭小巴。唯一对公众开放、也是唯一收费的校内班车线路——新生拖行李出站上山，基本靠它。

- 票价：**$5.5**（官方线路页标注 Fare $5.5；支付方式以车上为准）
- 行李：**禁止大件行李上车**（路窄，No Standing Allowed Light Bus）——两个大箱子可能被拒载，建议打车或走。
- 官方路线图 PDF：https://transport.cuhk.edu.hk/wp-content/uploads/documents/PSLB_2025.pdf

## Up（上山：大学站 → 宿舍区）

- 时段：**08:30–23:00，每日（周一至周日及公众假期）**；发车 :00/:30
- 站序：**Univ. Station (PSLB)** → Wong Foo Yuan Bldg. → C.C. Staff Quarters C → Academic Bldg. No.1 → University Health Centre (Upward)* → Sir Run Run Shaw Hall → University Library / Art Museum → Fung King Hey Bldg. → United College (Upward) → New Asia College (Upward) → Residences No. 3 (Upward) → Lee Woo Sing College → U.C. Staff Residence → Residence No. 15 → **Residences No.10 & 11**
- \* 保健处：**仅周一至五 08:30–17:30 时段内的班次停靠**（公众/大学假期除外）。

## Down（下山：宿舍区 → 大学站）

官方共两个时段块：

| 时段 | 适用日 | 发车(mins) |
|---|---|---|
| 07:00–08:15 | 周一至六（公众假期除外） | :00/:15/:30/:45 |
| 08:45–21:15 | 周日及公众假期 | :15/:45 |

- 站序：**Residences No.10 & 11** → Residence No. 15 → U.C. Staff Residence → Chan Chun Ha Hostel → Residences No. 3 (Downward) → New Asia College (Downward) → United College (Downward) → Univ. Admin. Bldg. → University Health Centre (Downward)* → Ho Sin-Hang Engineering Bldg. → Academic Bldg. No.1 → C.C. Staff Quarters C → Ho Tim Bldg. → Y.I.A.P. (PSLB) → **Univ. Station (PSLB)**
- \* 官方在第二时段块标注：周一至五 08:45–17:45 的班次停大学保健处（公众/大学假期除外）。

> 核验：2026-09-07，来源：https://transport.cuhk.edu.hk/route/up/ 与 /route/down/

## ⚠️ 已知官方信息含糊处（confidence: medium）

工作日**白天 08:45–17:45** 的下山班次没有独立的时段块——官方页面只在周日/假日块里附了"周一至五 08:45–17:45 停保健处"的注，暗示工作日日间存在 Down 班次，但时刻未明示。**早高峰（07:00–08:15）之外的工作日下山需求，回答时要说明这一点**，并建议：参考路线图 PDF、或改乘校巴 3/4 号（下山到站前广场/大学站）。此疑问可在复核时顺带向 Transport Office 求证。
