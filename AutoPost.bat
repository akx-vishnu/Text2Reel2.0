@echo off
set LOG=log.txt
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
pause
exit /b

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
