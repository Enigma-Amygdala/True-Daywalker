@echo off
setlocal
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0Install.ps1"
set "RC=%ERRORLEVEL%"
echo.
if not "%RC%"=="0" echo Installation did not complete. Review the message above.
pause
exit /b %RC%
