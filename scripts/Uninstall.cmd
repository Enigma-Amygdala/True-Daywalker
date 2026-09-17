@echo off
setlocal
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Uninstall.ps1"
set "RC=%ERRORLEVEL%"
echo.
if not "%RC%"=="0" echo Uninstall did not complete. Review the message above.
pause
exit /b %RC%
