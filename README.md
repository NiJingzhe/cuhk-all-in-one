# cuhk-all-in-one

> **A campus knowledge commons built by CUHKers, for CUHKers — share what you learn, keep what you prefer.**

把中大装进一个任何人（和任何 AI 助手）都能查阅的知识库：校园巴士怎么坐、某栋楼从哪个站下、这门课在哪上、官方信息去哪查。

## 为什么做这个

我曾经在 ZJU 饱受信息分散的折磨——答案散落在群聊、攻略帖和口口相传里，每个人都在重复踩同样的坑，而踩过的坑又随着聊天记录一起沉底。来到 CUHK 之后，我想为此做一些什么。

所以我们建立了这个项目：一个**足够尊重个人意愿**的信息共享平台，和一种**足够现代**的协作模式——每一位愿意参与知识和经验共享的 CUHKer，都可以在这里贡献自己的力量，同时得到他人的帮助；如果你有些小经验暂时只想自己用，它同样支持你把它们保留在本地、不公开。分享是善意，保留是权利。

## 它是什么

这不只是给人看的 wiki，更是一个 **AI agent 可以直接使用的技能包（skill）**。clone 之后你的 AI 助手即可回答校园问题。所有知识都带来源、可验证、可判定过期：

| 目录 | 内容 |
|---|---|
| `knowledge/common/bus/` | 校园交通全量数据：校巴 / 上下课班车 / 收费小巴的线路、班次、站序与路线规划 |
| `knowledge/common/place/` | 地点到达指南：某栋楼坐什么车、在哪下、下车怎么走（含实景图） |
| `knowledge/common/search-playbook.md` | 官方信息搜索手册：CUSIS、Blackboard、小红书攻略抓取方法 |
| `knowledge/msc-ai/` | 学科知识：课程文件、项目信息、学科级信息源（其他学科照此建目录） |
| `personal/` | **你的私有层**（已被 .gitignore，永不上传）：不想公开的小经验放这里，同名文件永远以它为准 |

## 怎么用

```bash
git clone git@github.com:NiJingzhe/cuhk-all-in-one.git
```

把目录交给你的 AI 助手（如 ZCode / Claude Code 等），它会按 [`SKILL.md`](SKILL.md) 自动加载知识并回答问题。每次会话开始会自动同步 main、维护你的分支；首次使用会询问你的专业，只加载你需要的学科。细节见 [`SYNC.md`](SYNC.md)。

## 参与进来

两种方式，都值得尊重：

- **分享** 🌱 — 新经验按 [`knowledge/FORMAT.md`](knowledge/FORMAT.md) 的规范（带来源、可验证、可判定过期）写进对应目录，走 `feat/*` 分支开 PR 回 main，让下一个 CUHKer 少踩一个坑。PR 规范见 [`SYNC.md`](SYNC.md)。
- **保留** 🔒 — 不想公开的部分放进 `personal/`，永远只属于你。

> 一个人的攻略会沉底，一群人的攻略会生长。欢迎你的第一个 PR。
