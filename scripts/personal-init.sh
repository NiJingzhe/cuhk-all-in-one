#!/usr/bin/env sh
# personal-init — 创建私有层脚手架 ~/.cuhk/personal/（幂等；已存在则跳过）。
# info.md 的 degree/programme/enabled_subjects 由 agent 询问用户后填写，脚本只建模板。
# Windows 路径为 %USERPROFILE%\.cuhk\personal（用 scripts/personal-init.bat）。
set -eu
PERSONAL_ROOT="${HOME}/.cuhk/personal"
mkdir -p "$PERSONAL_ROOT/knowledge"

if [ ! -f "$PERSONAL_ROOT/info.md" ]; then
  cat > "$PERSONAL_ROOT/info.md" <<'EOF'
---
degree: master            # undergrad | master | phd（待询问用户）
programme: ""             # 专业名称（待询问用户）
enabled_subjects:         # 路由只加载这些学科目录；留空数组 = 全部启用
  - msc-ai
updated:                  # 填写日期 YYYY-MM-DD
---

# 个人信息

- （agent 询问用户后补充：学位、专业、入学学期、常驻区域等）
EOF
  echo "-> Created $PERSONAL_ROOT/info.md (template, needs user input)"
fi

if [ ! -f "$PERSONAL_ROOT/prs.md" ]; then
  cat > "$PERSONAL_ROOT/prs.md" <<'EOF'
# 我的 PR 登记

| 分支 | PR | 状态 | 开启日期 | 内容 |
|---|---|---|---|---|
EOF
  echo "-> Created $PERSONAL_ROOT/prs.md"
fi

echo "OK personal root: $PERSONAL_ROOT"
