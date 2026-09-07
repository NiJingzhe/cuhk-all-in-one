---
title: CUHK 官方信息搜索手册
topic: search-method
kind: procedure
scope: common
audience: all
status: fresh
source:
  - name: 各条目实测沉淀（交通 2026-09-07、小红书 2026-09-07 实抓验证）
    url: https://transport.cuhk.edu.hk/
verified:
  date: 2026-09-07
  method: 交通/小红书两个主条目均为当日实抓验证；其余为未核验线索并已单独标注置信度
  by: ZCode session sess_a4f8620e-b4e8-4d18-a713-752b57a48cb9
freshness:
  stable_until: 2027-09-01
  expires_when: |
    - 某条目指向的官网改版导致该方法失效（使用时发现就更新对应条目）
    - 小红书前端结构变化（选择器/ token 机制失效）
  check: |
    方法类文档无需定期复核；每次实际使用某条目成功/失败后，顺手更新该条目与 verified.date
confidence: high
---

# CUHK 官方信息搜索手册

知识库里没有、或疑似过期时，按本手册查官方信息。原则：**官方源优先，二手攻略只当线索**；查到会被再次问到的信息，沉淀成知识文档（按 `../FORMAT.md`）。

## 通用策略

1. **先猜官方域名**，直接访问比搜索引擎快：院系/部门官网几乎都在 `*.cuhk.edu.hk` 下。
2. **搜索引擎兜底**：`<关键词> site:cuhk.edu.hk`，中英文各试一次（公告常见"校巴服務最新安排"这类双语标题，正文多为英文）。
3. **公告正文常是图片**：CUHK 官网新闻的正文经常是一张 JPG（如班次调整公告）。用 `curl -o /tmp/x.jpg <图片URL>` 下载后当图片读，不要试图在 HTML 里找文字。
4. **注意信息时效**：官网页面按学年更新，Google 索引的旧页（如已取消的 1B 线路攻略）会长期存在；凡时刻类信息，以官网当前页面为准。

## 校园交通（已验证，2026-09-07）

**官方站**：https://transport.cuhk.edu.hk/（Transport Office）

| 要查什么 | 做法 |
|---|---|
| 某条线路的站点/班次 | 访问 `/route/<slug>/`，slug 对照表见下 |
| 最新调整公告 | 官网 news 区；公告编号格式 `TSP/ISI/2026/17`，正文图在 `/wp-content/uploads/news/Service_Information/` 下 |
| PSLB 小巴路线图 | https://transport.cuhk.edu.hk/wp-content/uploads/documents/PSLB_2025.pdf |

**Slug 对照表**（2026-09-07 验证）：

| 线路 | slug | 线路 | slug |
|---|---|---|---|
| 1 | `/route/1/` | N | `/route/n/` |
| 2 | `/route/2/` | H | `/route/h/` |
| 2S | `/route/1b/` ⚠️ | 5 | `/route/5/` |
| 3 | `/route/3/` | 6A | `/route/6/` |
| 4 | `/route/4/` | 6B | `/route/6b/` |
| 8 | `/route/8/` | 7 | `/route/7/` |
| PSLB Up | `/route/up/` | PSLB Down | `/route/down/` |

⚠️ `/route/1b/` 是已取消的 1B 的旧地址，现在挂 2S 内容；`/route/2s/` 是 404。

**线路页解析规则**（U 形站序图，2026-09-07 用官方文字版公告双重验证）：

- 页面容器：`route-stops-left` / `route-stops-right` / `route-stops-bottom`。
- 行驶顺序 = 底部标签（始发，`route-stop-bottom-text`）→ 左列**自下而上** → 右列**自上而下** → 底部标签（环线则回到同一标签）。
- 两端站在 `route-stop-bottom-text two-stops` 里的两个 `.first-stop` div。
- 服务时段在 `rb-2-1` 的 `rb-large` span（一条线可能有多个时段块，如周六班）；发车分钟在 `rb-2-2`；`#`/`＃` 前缀对应脚注（特殊停靠规则）。
- 站名后缀 `(Upward)`/`(Downward)` 表示书院的上山/下山方向站台。

**用 ego-browser 重抓时的坑**（来自实际爬取经验）：

- `serverFetch` 只返回文本，下载公告图要用 `curl`。
- `captureScreenshot('/path.png')` 第一参数是路径字符串；脚本内用 ESM `import`，别与 top-level await 混用 `require`。
- 或者直接 `curl` 整页 HTML 后按上面的容器规则解析，不必开浏览器。

## 小红书（社区攻略，"哪站下、怎么走"的第一来源）

官方渠道只有站名级信息，"某栋楼从哪站下、下车怎么走"这类经验主要在小红书。抓取方法（2026-09-07 实测验证）：

1. **需要登录**。搜索页无登录会被"登录后查看搜索结果"弹窗挡住——用 ego-browser 打开搜索页后 `handOffTaskSpace` 交给用户扫码，登录完成用户确认后再 `takeOverTaskSpace` 继续。
2. **搜索**：`https://www.xiaohongshu.com/search_result?keyword=<关键词>&type=51`。用 ego-browser 时注意控制权归还后任务空间 ownership 会自动回 agent。
3. **笔记链接必须带 xsec_token**，否则报 300031"当前笔记暂时无法浏览"。token 在搜索结果卡片的 `a.cover` / `a.title` 的 href 里（`/search_result/<id>?xsec_token=...`），**不是**卡片里那个隐藏的 `/explore/<id>` 裸链接。
4. **提取内容**：笔记页（打开后 URL 会跳成 /explore/<id>?xsec_token=...）用选择器 `#detail-title`、`#detail-desc` 取正文，图片在 `[class*="note-detail"] img`，评论区在 `.comment-item`（问路帖的答案常在评论里）。
5. **图片下载**：CDN 图 URL 带时效签名（`/20260907xxxx/` 路径），**抓到后立刻 curl**，偶发 0 字节就刷新笔记页重取新签名 URL。webp 图片 agent 直接 Read 不了，先 `sips -s format jpeg` 转换。
6. **时效性**：社区攻略不随官方班次调整更新（如 2024 年攻略里的"1A"已是今天的 1 号线）。引用时必须与 `knowledge/common/bus/` 的官方数据交叉核验，旧线路名要显式调和。
7. 已知优质作者：**咖啡的刺客**（校巴直达教学楼/食堂系列）、**maritimeday**（步行实测帖）、**草莓舒芙蕾**（教育学楼群线路图）。

## 选课系统 CUSIS（学期固定信息的权威源头）

选课、课表、课程注册信息都在这里。**凡是"这学期我有什么课、在哪上"的问题，源头都是它。**

1. **站点**：<https://cusis.cuhk.edu.hk/>（PeopleSoft 系统），CUHK SSO 登录。
2. **Manage Classes 页** = 本人课表：每门课的上课日、时间、教室（缩写如 `Yasumoto LT7`、`CYT LT1B`、`WMW Mong Eng LT`）。新学期整理课程文件时从这里重读。
3. **教室缩写解码**：公共教室官方列表 <https://www.res.cuhk.edu.hk/teaching-timetable-classroom-booking/classroom-booking/list-of-communal-classrooms/>（注册处维护：楼栋、楼层、容量、缩写全称）。⚠️ 缩写楼名容易望文生义——`CYT` 是 Cheng Yu Tung 鄭裕彤樓，**不是**港大的 Chow Yei Ching 周亦卿楼；拿不准就用缩写全称搜官网。
4. **自动化坑**（PeopleSoft，2026-09 实测）：ego-browser 操作时弹出的 "Select a Value" 选择对话框内容在 iframe 里，`click('@N')` 会失效，要用 `js()` 点击 iframe 内的 anchor。

## Blackboard（作业/通知/讲义的实时信息源）

老师发通知、布置作业、传 PPT 都在这里。**这部分是实时信息，每次都现场查，绝不 bake 进知识库。**

1. **站点**：<https://blackboard.cuhk.edu.hk/ultra/stream>（Ultra 的 Stream 页 = 全部课程的最新动态聚合流），CUHK SSO 登录。
2. **结构**：Stream 看跨课程动态；进入具体课程后看 **Announcements**（老师通知、作业布置）、**Course Content**（PPT 讲义上传）、成绩在 Gradebook。
3. **Prebake vs Realtime 原则**（课程知识的分层铁律）：

   | 信息类型 | 处理方式 |
   |---|---|
  | 每学期固定：课表、教室、教授、考核方式（第一堂课大纲） | 沉淀进 `knowledge/msc-ai/lesson/` 课程文件（frontmatter `stable_until` 填学期结束日） |
   | 持续变化：通知、作业、截止日期、PPT 更新 | **永远现场查** Blackboard，不写入知识库 |

4. 课程文件里"教授/考核"字段标 ⚠️待核 的，来源就是这里（课程页 Faculty Information / Syllabus）——查到后回写课程文件并刷新 `verified` 块。

## 其他常用源（未核验线索，用时先确认域名）

| 主题 | 线索 | 置信 |
|---|---|---|
| 步行捷径/楼间路线 | **cuhk-shortcut-finder.lovable.app**（社区捷径图解站，含经康本园等路线；2026-09 从小红书攻略中确认可用） | medium |
| 图书馆 | lib.cuhk.edu.hk（开放时间、楼层指南） | medium |
| 注册与学籍 | 注册处（Registry）官网，add/drop、成绩、证明文件 | medium |
| 餐饮/校园设施 | 校园地图 campus map + CEDI/学生事务处页面 | low |

用这些线索时：确认域名解析正常、内容与问题相关后，把"已验证的 URL + 提取的事实"按 FORMAT 写入知识库，并把上表的置信度更新为 high。

## 学科专属信息源不进本手册

本手册只收录**全校通用**的信息源与方法。学科事务（项目官网、院系、选课系统、项目办公室等）由各学科路由维护**自己的 search playbook**，例如 `../msc-ai/search-playbook.md`——格式与本手册相同，只收该学科相关条目。遇到学科问题时优先查学科 playbook；发现某学科反复用到新的查询方法，就该给那个学科建 playbook。
