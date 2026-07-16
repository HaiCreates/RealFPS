@echo off
title RealFPS - Windows Gaming Optimizer
color 0A

net session >nul 2>&1
if %errorLevel% neq 0 (
    echo.
    echo Please run RealFPS as Administrator.
    pause
    exit /b
)

:MENU
cls
echo.
echo =====================================
echo      RealFPS v0.1-alpha
echo   Windows Gaming Optimizer
echo =====================================
echo.
echo    Only Measurable Optimizations
echo.
echo    Real Tweaks
echo    Real Results
echo    No Placebo
echo.
echo    Created by Nguyen Thanh Thien Hai
echo.
echo POWER
echo [1] Ultimate Performance
echo [2] High Performance
echo [3] Balanced
echo.
echo GAMING
echo [4] Enable Game Mode
echo [5] Disable Game Mode
echo.
echo [6] Disable Xbox DVR
echo [7] Enable Xbox DVR
echo.
echo [0] Exit
echo.
set /p choice=Choose an option: 

if "%choice%"=="1" goto ULTIMATE
if "%choice%"=="2" goto HIGH
if "%choice%"=="3" goto BALANCED
if "%choice%"=="4" goto GAMEON
if "%choice%"=="5" goto GAMEOFF
if "%choice%"=="6" goto DVR_OFF
if "%choice%"=="7" goto DVR_ON
if "%choice%"=="0" exit

echo.
echo Invalid option.
pause
goto MENU

:ULTIMATE
powercfg /setactive 68106fd7-5d79-4e17-8e48-713ab7c45207
echo.
echo Ultimate Performance Enabled
pause
goto MENU

:HIGH
powercfg /setactive 1f10358b-c5f5-4b94-b01d-5e82dc3e83f4
echo.
echo High Performance Enabled
pause
goto MENU

:BALANCED
powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e
echo.
echo Balanced Enabled
pause
goto MENU

:GAMEON
reg add "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 1 /f >nul
echo.
echo Game Mode Enabled
pause
goto MENU

:GAMEOFF
reg add "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 0 /f >nul
echo.
echo Game Mode Disabled
pause
goto MENU

:DVR_OFF
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f >nul
echo.
echo Xbox DVR Disabled
pause
goto MENU

:DVR_ON
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 1 /f >nul
echo.
echo Xbox DVR Enabled
pause
goto MENU
