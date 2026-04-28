@echo off
title Text2Reel One-Click Launcher

REM Start Flask server in its own CMD
start cmd /k "cd /d D:\Text2Reel2.0\server && python app.py"

REM Give Flask a second to stop being lazy
timeout /t 3 >nul

REM Open a NEW CMD, go to the folder, then run ngrok config
start cmd /k "cd /d D:\Text2Reel2.0\server && ngrok config add-authtoken 35JXOKa7o4QgWwCMzUZIKuquD7g_5XdEaqXAQJWV739HbA5QE"

REM Open a NEW CMD, go to the folder, then run ngrok
start cmd /k "cd /d D:\Text2Reel2.0\server && ngrok http 10000"

exit
