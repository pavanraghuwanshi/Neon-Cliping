@echo off
setlocal
title NeonClipping Launcher

echo ========================================================
echo               NEONCLIPPING LAUNCHER
echo ========================================================
echo.

if exist "%~dp0neonclipping\app.py" (
    cd /d "%~dp0neonclipping"
) else (
    cd /d "%~dp0"
)

if exist "bin" (
    set "PATH=%CD%\bin;%PATH%"
)

powershell -NoProfile -Command "if (-not (Get-Process ollama -ErrorAction SilentlyContinue)) { Start-Process ollama -ArgumentList 'serve' -WindowStyle Hidden }" >nul 2>&1

echo Starting NeonClipping studio...
echo Opening browser: http://127.0.0.1:8770
echo.

start "" http://127.0.0.1:8770

if exist ".venv\Scripts\python.exe" (
    .venv\Scripts\python.exe app.py
) else (
    echo [.venv missing, setting up...]
    python -m venv .venv
    .venv\Scripts\python.exe -m pip install -r requirements.txt
    .venv\Scripts\python.exe app.py
)

if errorlevel 1 (
    echo.
    echo [ERROR] App band ho gayi ya error aayi.
    pause
)
