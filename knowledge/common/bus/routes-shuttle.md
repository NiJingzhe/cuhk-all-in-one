---
title: 校巴线路（Campus Shuttle 1/2/2S/3/4/8/N/H）
topic: bus
kind: fact-sheet
scope: common
audience: all
status: fresh
source:
  - name: CUHK Transport Office — 各线路页
    url: https://transport.cuhk.edu.hk/route/1/
verified:
  date: 2026-09-07
  method: 抓取官网 8 条校巴线路页（U 形站序图解析），与 2026-09-01 公告 TSP/ISI/2026/17 交叉比对
  by: ZCode session sess_a4f8620e-b4e8-4d18-a713-752b57a48cb9
freshness:
  stable_until: 2027-09-01
  expires_when: |
    - 官网出现任何线路调整公告（本校巴历史上每年 9 月前后大调一次）
    - 任一线路班次/站点与本文档不符
  check: |
    按 ../search-playbook.md"校园交通"条目，对涉及线路重抓 /route/<slug>/ 页比对站序与 rb-large 时段
confidence: high
---

# 校巴线路（免费，仅限师生；周一至六，公众假期除外）

发车分钟 (mins) 均指每小时内 X 分从**始发站**发车。站序为官方 U 形图解析结果，`→` 首尾相接为环线。

## 路线速查

| 线 | 走向 | 服务时段 | 发车(mins) | 快速定位 |
|---|---|---|---|---|
| 1 | 大学站环回主校园 | 07:40–18:55（周一至六） | :10/:25/:40/:55 | 主校园环线，班次最密 |
| 2 | 站前广场 ↔ 大学站（经新亚/联合） | 07:45–18:45（周一至六） | :15/#:45 | 去新亚/联合；#:45 班才停邵逸夫堂 |
| 2S | 同 2 但经 PGH 1 | 08:00–18:30（周一至六） | :00/:30 | 研究生宿舍 1 座直达新亚/联合 |
| 3 | 康本园 ↔ 站前广场（经逸夫书院） | 09:00–18:40（周一至六） | :00/:20/:40 | 去逸夫/陈震夏/十五座 |
| 4 | 康本园 ↔ 大学站（Campus Circuit） | 07:30–18:50（周一至六） | :10/:30/:50 | 覆盖最广的下行线 |
| 8 | 康本园 → 崇基（大环线） | 07:35–18:35（周一至六） | :15/:35/:55 | 唯一串起西部+新亚+逸夫的大环线 |
| N | 大学站夜间环回 | 19:00–23:30（周一至六） | :00/:15/:30/:45 | 夜间唯一校巴；:00 班停 PGH 1 |
| H | 大学站假日环回 | 08:20–23:20（**周日及公众假期**） | :00/:20/:40 | 假期版 N 线 |

> 核验：2026-09-07，来源：https://transport.cuhk.edu.hk/ 各线路页

## 1 — Main（主校园环回）

- 时段：07:40–18:55，周一至六（公众假期除外）；发车 :10/:25/:40/:55
- 站序（环线）：**Univ. Station** → Univ. Sports Centre → Sir Run Run Shaw Hall → Univ. Admin. Bldg. → S.H. Ho College → 回到 Univ. Station

## 2 — NA / UC（新亚/联合）

- 时段：07:45–18:45，周一至六；发车 :15、#:45
- 站序：**Station Piazza** → Univ. Sports Centre → Sir Run Run Shaw Hall → Fung King Hey Bldg. → United College (Upward) → New Asia College → United College (Downward) → Univ. Admin. Bldg. → S.H. Ho College → **Univ. Station**
- 特殊：**# 仅 :45 发车的班次停靠 Sir Run Run Shaw Hall**（官方注：Buses departing from 31 to 00 minutes will stop at Sir Run Run Shaw Hall）。赶时间别指望 :15 班在邵逸夫堂停下。

## 2S — NA / UC (S)（经 PGH 1 特快）

- 时段：08:00–18:30，周一至六；发车 :00/:30
- 站序：**Station Piazza** → Postgraduate Hall 1 → Univ. Sports Centre → Sir Run Run Shaw Hall → Fung King Hey Bldg. → United College (Upward) → New Asia College → United College (Downward) → Univ. Admin. Bldg. → S.H. Ho College → Postgraduate Hall 1 → **Univ. Station**
- 2026-09-01 新线（替代取消的 1B 的 PGH 1 走向）。

## 3 — Shaw（逸夫方向）

- 时段：09:00–18:40，周一至六；发车 :00/:20/:40
- 站序：**Y.I.A.P.** → Univ. Sports Centre → Science Centre → Fung King Hey Bldg. → Wu Yee Sun College (Upward) → Shaw College (Upward) → CW Chu College (Downward) → Residence No. 15 → U.C. Staff Residence → Chan Chun Ha Hostel → Shaw College (Downward) → Wu Yee Sun College (Downward) → Univ. Admin. Bldg. → S.H. Ho College → **Station Piazza**

## 4 — Campus（环回下行）

- 时段：07:30–18:50，周一至六；发车 :10/:30/:50
- 站序：**Y.I.A.P.** → Campus Circuit East (Upward) → CW Chu College (Upward) → Area 39 (Upward) → CW Chu College (Downward) → Residence No. 15 → U.C. Staff Residence → Chan Chun Ha Hostel → Shaw College (Downward) → Wu Yee Sun College (Downward) → New Asia College → United College (Downward) → Univ. Admin. Bldg. → S.H. Ho College → **Univ. Station**

## 8 — Western（西部大环线）

- 时段：07:35–18:35，周一至六；发车 :15/:35/:55
- 站序：**Y.I.A.P.** → Campus Circuit East (Upward) → CW Chu College (Upward) → Area 39 (Upward) → CW Chu College (Downward) → U.C. Staff Residence → Chan Chun Ha Hostel → Shaw College (Downward) → Wu Yee Sun College (Downward) → Univ. Admin. Bldg. → Science Centre → New Asia Circle → United College (Downward) → Wu Yee Sun College (Upward) → Shaw College (Upward) → Area 39 (Downward) → Campus Circuit North → Campus Circuit East (Downward) → Univ. Station → Station Piazza → **Chung Chi Teaching Bldg.**
- 特殊：**非教学日不停 Univ. Station，改停 Station Piazza & Chung Chi Teaching Bldg.**（官方注：During non-teaching days, buses will stop at Station Piazza & Chung Chi Teaching Bldg. (without stopping at Univ. Station)）

## N — Night（夜间环回）

- 时段：19:00–23:30，周一至六；发车 :00/:15/:30/:45
- 站序（环线）：**Univ. Station** → Postgraduate Hall 1 → Univ. Sports Centre → Sir Run Run Shaw Hall → New Asia Circle → United College (Downward) → Wu Yee Sun College (Upward) → Shaw College (Upward) → Area 39 (Upward) → CW Chu College (Downward) → Residence No. 15 → U.C. Staff Residence → Chan Chun Ha Hostel → Shaw College (Downward) → Wu Yee Sun College (Downward) → New Asia College → United College (Downward) → Univ. Admin. Bldg. → S.H. Ho College → Postgraduate Hall 1 → 回到 Univ. Station
- 特殊：**仅 :00 发车的班次停靠 Postgraduate Hall 1**（官方注：Buses departing at 00 minute will stop at Postgraduate Hall 1；其余班次在 PGH 1 是否停靠官方未说明，不要向用户打包票）。

## H — Holidays（假日环回）

- 时段：08:20–23:20，**周日及公众假期**；发车 :00/:20/:40
- 站序：与 N 线相同（环线，经 PGH 1 两度停靠）
- 特殊：**仅 :00 发车的班次停靠 Postgraduate Hall 1 及 Area 39 (Upward)**。2026-09-01 起不再停 Residence No.10。
