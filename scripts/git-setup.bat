@echo off
rem git-setup - turn a `npx skills add` copy into a git repo (idempotent), then sync upstream.
rem Only touches .git, never working files. Usage (at skill root): scripts\git-setup.bat
setlocal
set REPO_URL=https://github.com/NiJingzhe/cuhk-all-in-one.git
cd /d "%~dp0.."

if not exist .git (
  git init -q || goto :fail
  git symbolic-ref HEAD refs/heads/main || goto :fail
  echo -> Initialized git repo
)
git remote add origin %REPO_URL% 2>nul || git remote set-url origin %REPO_URL%

git fetch origin --quiet || goto :fail

git rev-parse --verify -q HEAD >nul 2>&1
if errorlevel 1 (
  git reset origin/main -q || goto :fail
  echo -> Aligned local main to origin/main ^(working files untouched^)
) else (
  git merge --ff-only origin/main || goto :fail
)

echo OK git ready:
git log --oneline -1
exit /b 0

:fail
echo FAIL git-setup failed - report to user, do not silently skip.
exit /b 1
