#!/usr/bin/env bash
# Stop hook：每次 Claude 回合結束時，若專案有變更就自動 commit 並 push 到 origin。
cd "${CLAUDE_PROJECT_DIR:-$(dirname "$0")/../..}" || exit 0
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || exit 0

# 讓 Artifact 版本與 index.html 保持一致（去掉 html/head/body 外框）
if [ -f index.html ] && [ -d artifact ]; then
  grep -v -x -E '<!doctype html>|<html lang="zh-Hant">|<head>|<meta charset="utf-8">|<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">|</head>|<body>|</body>|</html>' \
    index.html > artifact/foldable-inspector.html
fi

[ -z "$(git status --porcelain)" ] && exit 0

git add -A
files=$(git diff --cached --name-only | head -5 | paste -sd ' ' -)
count=$(git diff --cached --name-only | wc -l | tr -d ' ')
git commit -q -m "Update ${files}$([ "$count" -gt 5 ] && echo " (+$((count - 5)) more)")" \
  -m "Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>" || exit 0

if GIT_TERMINAL_PROMPT=0 git push -q origin HEAD 2>/tmp/auto-push.err; then
  echo "{\"systemMessage\": \"已自動 commit 並 push：$(git log -1 --format=%h) ${files}\"}"
else
  echo "{\"systemMessage\": \"已 commit $(git log -1 --format=%h)，但 push 失敗，請手動執行 git push\"}"
fi
