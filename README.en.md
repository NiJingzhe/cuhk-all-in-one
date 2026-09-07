![CUHK all-in-one — share what you learn, keep what you prefer.](assets/cover.jpg)

[简体中文](README.md) | English

Stuff CUHK into a knowledge base that anyone — or any AI assistant — can query: how the campus shuttles work, which stop to get off for a building, where your class meets, and where to find official information.

## Why

I suffered from scattered information back at ZJU — answers buried in group chats, blog posts and word of mouth; everyone stepped in the same potholes, and every hard-won tip sank with the chat history. After coming to CUHK, I wanted to do something about it.

This project is a knowledge-sharing platform that **genuinely respects personal boundaries**, built on a **modern** collaboration model: every CUHKer willing to share knowledge and experience can contribute here and get help from others in return. And if some of your hard-won tips are just for yourself, you can keep them local and private — no strings attached. Sharing is kindness; keeping is a right.

## What it is

More than a human-readable wiki — an **AI-agent-ready skill pack**. Clone it, hand it to your AI assistant, and it can answer campus questions. Every fact carries its source, is verifiable, and knows when it expires:

| Path | Content |
|---|---|
| `knowledge/common/bus/` | Full campus transport data: shuttle / meet-class / minibus routes, timetables, stop sequences, and route planning |
| `knowledge/common/place/` | Place guides: which bus to take, where to alight, and how to walk from there (with real photos) |
| `knowledge/common/search-playbook.md` | Official information search handbook: CUSIS, Blackboard, and how to gather community guides from Xiaohongshu |
| `knowledge/msc-ai/` | Subject knowledge: course files, programme info, subject-level sources (other programmes can follow the same layout) |
| `personal/` | **Your private layer** (gitignored, never uploaded): tips you'd rather not publish live here, and it always takes precedence |

## Usage

```bash
npx github:NiJingzhe/cuhk-all-in-one
```

Installs into your local skills directory (`~/.agents/skills/cuhk-all-in-one`). The knowledge repo must live as a git clone — daily **updates are `git pull`** (each session the agent auto-syncs per [`SYNC.md`](SYNC.md)), contributions go through feat branches + PRs. Point your AI assistant (ZCode, Claude Code, etc.) at the directory — it loads knowledge per [`SKILL.md`](SKILL.md) and answers questions; on first use it asks for your programme and only loads the subjects you need. Details in [`SYNC.md`](SYNC.md).

## Get involved

Two ways, both respected:

- **Share** 🌱 — **fully automated**: at the end of a session you just say "yes, share it" — the agent opens the branch, groups the commits and files the PR for you per [`SYNC.md`](SYNC.md). **Local and `personal/` always come first; a PR is only created when you explicitly opt in**, otherwise everything stays on your machine. Shared findings are written per [`knowledge/FORMAT.md`](knowledge/FORMAT.md) (sourced, verifiable, expirable), and PRs are reviewed by a daily automation task plus maintainers per [`REVIEW.md`](REVIEW.md) (format, sources, and knowledge-level conflict adjudication).
- **Keep** 🔒 — put what you'd rather not publish into `personal/`. It stays yours, forever.

- **Become a maintainer** 🛠️ — reviewing PRs and adjudicating knowledge conflicts is a centralized bottleneck; help is welcome: resolve semantic conflicts, run quarterly freshness sweeps. Duties and how to apply are in [`REVIEW.md`](REVIEW.md), "Maintainers".

> One person's guide sinks with the chat log; a community's guide keeps growing. Your first PR is welcome.
