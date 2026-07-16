@echo off
title RealFPS - Windows Gaming Optimizer
color 0A

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

echo STATUS
call :CHECK_POWER
call :CHECK_GAME
call :CHECK_DVR
echo.

echo POWER
echo [1] Ultimate Performance
echo [2] High Performance
echo [3] Balanced
call :CHECK_POWER
echo.

echo SYSTEM
echo [8] Create Restore Point
echo.

echo GAMING
echo [4] Enable Game Mode
echo [5] Disable Game Mode
call :CHECK_GAME

echo.
echo [6] Disable Xbox DVR
echo [7] Enable Xbox DVR
call :CHECK_DVR

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
if "%choice%"=="8" goto RESTORE
if "%choice%"=="0" exit

echo.
echo Invalid option.
pause
goto MENU

:ULTIMATE
powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749eb61
echo.
echo Ultimate Performance Enabled
pause
goto MENU

:HIGH
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
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

:RESTORE

echo.
echo Creating Restore Point...

powershell -command "Checkpoint-Computer -Description 'Before RealFPS Tweak' -RestorePointType MODIFY_SETTINGS"

echo.
echo Restore Point Created
pause
goto MENU

:CHECK_POWER

for /f "tokens=4" %%a in ('powercfg /getactivescheme') do set power=%%a

echo Power Plan: %power%

exit /b


:CHECK_GAME

for /f "tokens=3" %%a in ('reg query "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled 2^>nul') do set gm=%%a

if "%gm%"=="0x1" (
    echo Game Mode: ON
) else (
    echo Game Mode: OFF
)

exit /b


:CHECK_DVR

for /f "tokens=3" %%a in ('reg query "HKCU\System\GameConfigStore" /v GameDVR_Enabled 2^>nul') do set dvr=%%a

if "%dvr%"=="0x1" (
    echo Xbox DVR: ON
) else (
    echo Xbox DVR: OFF
)

exit /b
