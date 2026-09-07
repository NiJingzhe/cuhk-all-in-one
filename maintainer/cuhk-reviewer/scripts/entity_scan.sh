#!/usr/bin/env bash
# entity_scan.sh <PR号> — 从 PR diff 提取知识实体（文件 slug、课程代码、wiki 引用、目录引用），
# 并报告该实体在 main 与其他 open PR 中的出现位置。辅助语义冲突判断（REVIEW.md 情形 B/C），
# 输出只是线索，矛盾与否须由审核者按裁决层级人工判定。
set -uo pipefail
PR="${1:?usage: entity_scan.sh <PR号>}"
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
cd "$ROOT"
git fetch -q origin

TMP="$(mktemp -d)"
gh pr diff "$PR" > "$TMP/pr.diff"

# 其他 open PR（缓存 diff，避免重复请求）
OTHERS="$(gh pr list --repo NiJingzhe/cuhk-all-in-one --state open --json number --jq '.[].number' | grep -vx "$PR" || true)"
for P in $OTHERS; do gh pr diff "$P" > "$TMP/other_$P.diff" 2>/dev/null || true; done

# 实体 token：改动文件路径、课程代码、wiki 引用、目录引用
TOKENS="$({ 
  grep -oE '^diff --git a/\S+' "$TMP/pr.diff" | sed 's|^diff --git a/||; s| b/.*||'
  grep -oiE '\b(AIMS|IERG|CSCI|ELEG|SEEM|ENGG|FTEC|IEMS|AIST|CMSC|ROSE)[0-9]{4}\b' "$TMP/pr.diff"
  grep -oE '\[\[[^]]+\]\]' "$TMP/pr.diff" | tr -d '[]'
  grep -oE '(place|bus|lesson)/[A-Za-z0-9_-]+' "$TMP/pr.diff"
} | sed 's|\.md$||' | sort -u | grep -v '^$' || true)"

echo "== PR #$PR 涉及实体 =="
echo "$TOKENS"
echo

echo "== 同实体出现位置 =="
while IFS= read -r T; do
  [ -z "$T" ] && continue
  echo "--- token: $T"
  git grep -l -F "$T" origin/main -- knowledge/ 2>/dev/null | sed 's/^/    [main] /'
  for P in $OTHERS; do
    [ -s "$TMP/other_$P.diff" ] && grep -qF "$T" "$TMP/other_$P.diff" && echo "    [open PR #$P] 命中"
  done
done <<< "$TOKENS"
echo
echo "== done（命中≠冲突：是否矛盾按 REVIEW.md 裁决层级人工判定）=="
