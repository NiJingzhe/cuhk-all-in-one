@echo off
rem personal-init - scaffold the private layer at %USERPROFILE%\.cuhk\personal (idempotent).
rem info.md fields are filled by the agent after asking the user; this only creates templates.
setlocal enabledelayedexpansion
set "PERSONAL_ROOT=%USERPROFILE%\.cuhk\personal"
if not exist "%PERSONAL_ROOT%\knowledge" mkdir "%PERSONAL_ROOT%\knowledge"

if not exist "%PERSONAL_ROOT%\info.md" (
  (
    echo ---
    echo degree: master            # undergrad ^| master ^| phd ^(ask user^)
    echo programme: ""             # programme name ^(ask user^)
    echo enabled_subjects:         # routing loads only these subject dirs; empty = all
    echo   - msc-ai
    echo updated:                  # fill with YYYY-MM-DD
    echo ---
    echo.
    echo # Personal notes
    echo.
    echo - ^(agent fills after asking user: degree, programme, entry term, usual area^)
  ) > "%PERSONAL_ROOT%\info.md"
  echo -^> Created %PERSONAL_ROOT%\info.md ^(template, needs user input^)
)

if not exist "%PERSONAL_ROOT%\prs.md" (
  (
    echo # My PR log
    echo.
    echo ^| Branch ^| PR ^| Status ^| Opened ^| Content ^|
    echo ^|---^|---^|---^|---^|---^|
  ) > "%PERSONAL_ROOT%\prs.md"
  echo -^> Created %PERSONAL_ROOT%\prs.md
)

echo OK personal root: %PERSONAL_ROOT%
exit /b 0
