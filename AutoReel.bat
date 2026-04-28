@echo off
set LOG=log.txt

:MAIN_LOOP

echo ================== START ==================
echo [%DATE% %TIME%] SCRIPT STARTED >> %LOG%

echo ==================================================
echo =============== GOOGLE KEEP FLOW =================
echo ==================================================

echo ===== Open Google Keep =====
echo [%DATE% %TIME%] Open Google Keep >> %LOG%
adb shell monkey -p com.google.android.keep -c android.intent.category.LAUNCHER 1 >> %LOG% 2>&1
timeout /t 3 /nobreak

echo ===== Refresh Keep =====
echo [%DATE% %TIME%] Refresh Keep >> %LOG%
adb shell input swipe 540 400 540 1200 300 >> %LOG% 2>&1
timeout /t 2 /nobreak

echo ===== Reels List =====
echo [%DATE% %TIME%] Reels List >> %LOG%
adb shell input tap 440 503 >> %LOG% 2>&1
timeout /t 2 /nobreak

echo ===== SELECT & COPY (1) =====
echo [%DATE% %TIME%] SELECT & COPY (1) >> %LOG%
call :SELECT_COPY

echo ===== Back to main (3x) =====
adb shell input keyevent 4 >> %LOG% 2>&1
timeout /t 1 /nobreak
adb shell input keyevent 4 >> %LOG% 2>&1
timeout /t 1 /nobreak
adb shell input keyevent 4 >> %LOG% 2>&1
timeout /t 1 /nobreak

echo ===== Open ReelMaker =====
echo [%DATE% %TIME%] Open ReelMaker >> %LOG%
adb shell monkey -p com.akx.reelmaker -c android.intent.category.LAUNCHER 1 >> %LOG% 2>&1
timeout /t 4 /nobreak


echo ===== Hold main to nav paste =====
echo [%DATE% %TIME%] Hold main to nav paste >> %LOG%
adb shell input swipe 484 686 484 686 1500 >> %LOG% 2>&1
timeout /t 1 /nobreak

echo ===== Main Text Paste =====
echo [%DATE% %TIME%] Main Text Paste >> %LOG%
adb shell input tap 148 576 >> %LOG% 2>&1
timeout /t 2 /nobreak

echo ===== Recents to Keep =====
echo [%DATE% %TIME%] Recents to Keep >> %LOG%
adb shell input keyevent 187 >> %LOG% 2>&1
timeout /t 1 /nobreak
adb shell input keyevent 187 >> %LOG% 2>&1
timeout /t 1 /nobreak

echo ===== Reels List =====
echo [%DATE% %TIME%] Reels List >> %LOG%
adb shell input tap 440 503 >> %LOG% 2>&1
timeout /t 2 /nobreak

echo ===== CheckBox =====
echo [%DATE% %TIME%] CheckBox >> %LOG%
adb shell input tap 194 582 >> %LOG% 2>&1
timeout /t 2 /nobreak

echo ===== SELECT & COPY (2) =====
echo [%DATE% %TIME%] SELECT & COPY (2) >> %LOG%
call :SELECT_COPY

echo ===== Recents to Web App =====
echo [%DATE% %TIME%] Recents to Web App >> %LOG%
adb shell input keyevent 187 >> %LOG% 2>&1
timeout /t 1 /nobreak
adb shell input keyevent 187 >> %LOG% 2>&1
timeout /t 1 /nobreak

echo ===== Hold sub to nav paste =====
echo [%DATE% %TIME%] Hold sub to nav paste >> %LOG%
adb shell input swipe 180 1285 180 1285 1500 >> %LOG% 2>&1
timeout /t 1 /nobreak

echo ===== Subtext Paste =====
echo [%DATE% %TIME%] Subtext Paste >> %LOG%
adb shell input tap 131 1200 >> %LOG% 2>&1
timeout /t 2 /nobreak

echo ===== Generate =====
echo [%DATE% %TIME%] Generate >> %LOG%
adb shell input tap 531 1564 >> %LOG% 2>&1
timeout /t 30 /nobreak

echo ===== Back to Keep =====
adb shell input keyevent 187 >> %LOG% 2>&1
timeout /t 1 /nobreak
adb shell input keyevent 187 >> %LOG% 2>&1
timeout /t 1 /nobreak

echo ===== CheckBox =====
adb shell input tap 194 582 >> %LOG% 2>&1
timeout /t 2 /nobreak

echo ===== SELECT & COPY (3) =====
call :SELECT_COPY

echo ===== Final CheckBox =====
adb shell input tap 194 582 >> %LOG% 2>&1
timeout /t 2 /nobreak

echo ===== Back to main (3x) =====
adb shell input keyevent 4 >> %LOG% 2>&1
timeout /t 1 /nobreak
adb shell input keyevent 4 >> %LOG% 2>&1
timeout /t 1 /nobreak
adb shell input keyevent 4 >> %LOG% 2>&1
timeout /t 1 /nobreak

echo ==================================================
echo ============== INSTAGRAM FLOW ====================
echo ==================================================

echo ===== Clear All Recents =====
adb shell input keyevent 187 >> %LOG% 2>&1
timeout /t 1 /nobreak
adb shell input tap 548 1506 >> %LOG% 2>&1
timeout /t 3 /nobreak

echo ===== Open Instagram =====
adb shell monkey -p com.instagram.android -c android.intent.category.LAUNCHER 1 >> %LOG% 2>&1
timeout /t 3 /nobreak

echo ===== Open Camera =====
adb shell input tap 68 188 >> %LOG% 2>&1
timeout /t 3 /nobreak

echo ===== Switch to Reels =====
adb shell input tap 534 1696 >> %LOG% 2>&1
timeout /t 2 /nobreak

echo ===== Open Recent Reel =====
adb shell input tap 531 888 >> %LOG% 2>&1
timeout /t 2 /nobreak

echo ===== Music Button =====
adb shell input tap 63 1635 >> %LOG% 2>&1
timeout /t 2 /nobreak

echo ===== Hold Music =====
adb shell input swipe 424 849 424 849 1500 >> %LOG% 2>&1
timeout /t 2 /nobreak

echo ===== Paste Music =====
adb shell input tap 173 764 >> %LOG% 2>&1
timeout /t 3 /nobreak

echo ===== Select Song =====
adb shell input tap 416 1009 >> %LOG% 2>&1
timeout /t 2 /nobreak

echo ===== Confirm Song =====
adb shell input tap 416 1009 >> %LOG% 2>&1
timeout /t 2 /nobreak

echo ===== Final Confirm =====
adb shell input tap 975 251 >> %LOG% 2>&1
timeout /t 3 /nobreak

echo ===== Extra Taps =====
adb shell input tap 895 1520 >> %LOG% 2>&1
timeout /t 2 /nobreak
adb shell input tap 810 1666 >> %LOG% 2>&1
timeout /t 2 /nobreak

echo ===== Clear Recents End =====
adb shell input keyevent 187 >> %LOG% 2>&1
timeout /t 2 /nobreak
adb shell input tap 548 1506 >> %LOG% 2>&1
timeout /t 2 /nobreak

echo DONE
echo [%DATE% %TIME%] ITERATION FINISHED >> %LOG%

timeout /t 4 /nobreak
goto MAIN_LOOP


:SELECT_COPY
echo ===== Select & Copy Start =====
echo [%DATE% %TIME%] Select & Copy Start >> %LOG%
adb shell input tap 347 522 >> %LOG% 2>&1
timeout /t 1 /nobreak
adb shell input tap 71 1011 >> %LOG% 2>&1
timeout /t 1 /nobreak
adb shell input tap 224 1017 >> %LOG% 2>&1
timeout /t 1 /nobreak
adb shell input tap 915 1167 >> %LOG% 2>&1
timeout /t 1 /nobreak
adb shell input tap 943 1334 >> %LOG% 2>&1
timeout /t 1 /nobreak
echo ===== Select & Copy End =====
echo [%DATE% %TIME%] Select & Copy End >> %LOG%
exit /b



