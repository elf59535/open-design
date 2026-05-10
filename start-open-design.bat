@echo off
setlocal

cd /d "%~dp0"
title Open Design Launcher

where node >nul 2>nul
if errorlevel 1 (
  echo [ERROR] Node.js was not found in PATH.
  echo Please install Node.js 24.x, then run this launcher again.
  pause
  exit /b 1
)

where corepack >nul 2>nul
if errorlevel 1 (
  echo [ERROR] Corepack was not found in PATH.
  echo Please make sure your Node.js installation includes Corepack.
  pause
  exit /b 1
)

echo Starting Open Design...
echo Project: %CD%
echo.

start "Open Design Browser Opener" /min powershell -NoProfile -ExecutionPolicy Bypass -Command "$url='http://localhost:5173'; $deadline=(Get-Date).AddSeconds(90); while((Get-Date) -lt $deadline){ try { $r=Invoke-WebRequest -UseBasicParsing -Uri $url -TimeoutSec 2; if($r.StatusCode -ge 200){ Start-Process $url; break } } catch { Start-Sleep -Seconds 1 } }"

corepack pnpm tools-dev run web

echo.
echo Open Design has stopped. If this was unexpected, check the messages above.
pause
