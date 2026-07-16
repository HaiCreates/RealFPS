@echo off
chcp 65001 >nul
title RealFPS - Windows Gaming Optimizer
color 07

set VERSION=1.0-beta
set BUILD=2026.07
set DEVELOPER=Nguyen Thanh Thien Hai


:: =====================================
:: REALFPS START
:: =====================================

call :ENV_CHECK
call :INTRO


:MENU

cls

echo.
call :PINK_LINE
call :CENTER "REALFPS"
call :CENTER "Windows Gaming Optimizer"
call :CENTER "Version %VERSION%"
call :PINK_LINE

echo.

echo SYSTEM STATUS
call :CHECK_POWER
call :CHECK_GAME
call :CHECK_DVR
call :CHECK_HAGS

echo.

echo =====================================
echo MENU
echo =====================================

echo.
echo [1] System Preparation
echo.
echo [2] RealFPS Tweaks
echo.
echo [3] Diagnostics
echo.
echo [4] Information
echo.
echo [0] Exit
echo.


set /p choice=Select Option: 


if "%choice%"=="1" goto PREPARATION
if "%choice%"=="2" goto TWEAKS
if "%choice%"=="3" goto DIAGNOSTICS
if "%choice%"=="4" goto INFORMATION
if "%choice%"=="0" exit


goto MENU







:: =====================================
:: INTRO
:: =====================================


:INTRO

cls

echo.
call :PINK_LINE
call :CENTER "REALFPS"
call :CENTER "Windows Gaming Optimizer"
call :PINK_LINE

echo.

echo Project:
echo RealFPS

echo.

echo Version:
echo %VERSION%

echo.

echo Build:
echo %BUILD%

echo.

echo Developer:
echo %DEVELOPER%

echo.

echo Philosophy:
echo Real Tweaks
echo Real Results
echo No Placebo

echo.

echo =====================================

echo RealFPS is a free and open-source
echo Windows optimization toolkit.

echo.

echo This project focuses on:
echo - Safe optimization
echo - Measurable improvements
echo - System transparency

echo.

echo =====================================

echo IMPORTANT:
echo Please run RealFPS as Administrator
echo for full functionality.

echo =====================================

pause

exit /b







:: =====================================
:: SYSTEM PREPARATION
:: =====================================


:PREPARATION

cls

echo.
call :PINK_LINE
call :CENTER "SYSTEM PREPARATION"
call :PINK_LINE

echo.

echo Prepare your system before tweaking.

echo.

echo [1] Create Restore Point

echo [2] Hardware Detection

echo [3] Recommended Settings

echo [4] Backup / Restore

echo.

echo [0] Back


echo.

set /p choice=Select Option: 


if "%choice%"=="1" goto RESTORE_POINT
if "%choice%"=="2" goto HARDWARE_SCAN
if "%choice%"=="3" goto RECOMMEND
if "%choice%"=="4" goto BACKUP_MENU
if "%choice%"=="0" goto MENU


goto PREPARATION







:: =====================================
:: RESTORE POINT
:: =====================================


:RESTORE_POINT

cls

echo.
echo Creating Restore Point...
echo.

powershell -command "Checkpoint-Computer -Description 'Before RealFPS Optimization' -RestorePointType MODIFY_SETTINGS"


if %errorlevel% neq 0 (
call :FAILED "Restore Point Failed"
goto PREPARATION
)


call :SUCCESS "Restore Point Created"

goto PREPARATION







:: =====================================
:: HARDWARE DETECTION
:: =====================================


:HARDWARE_SCAN

cls

echo.
call :PINK_LINE
call :CENTER "HARDWARE DETECTION"
call :PINK_LINE

echo.


echo CPU:

powershell -command "Get-CimInstance Win32_Processor | Select -ExpandProperty Name"


echo.

echo GPU:

powershell -command "Get-CimInstance Win32_VideoController | Select -ExpandProperty Name"


echo.

echo RAM:

powershell -command "[math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB,2); Write-Host GB"


echo.

echo Windows:

powershell -command "Get-CimInstance Win32_OperatingSystem | Select -ExpandProperty Caption"


pause

goto PREPARATION

:: =====================================
:: REALFPS TWEAKS MENU
:: =====================================


:TWEAKS

cls

echo.
call :PINK_LINE
call :CENTER "REALFPS TWEAKS"
call :PINK_LINE

echo.

echo [1] Power Management

echo.

echo [2] Gaming Optimization

echo.

echo [3] GPU Optimization

echo.

echo [4] Gaming Profiles

echo.

echo [0] Back


echo.

set /p choice=Select Option:


if "%choice%"=="1" goto POWER_MENU
if "%choice%"=="2" goto GAMING_MENU
if "%choice%"=="3" goto GPU_MENU
if "%choice%"=="4" goto PROFILE_MENU
if "%choice%"=="0" goto MENU


goto TWEAKS







:: =====================================
:: POWER MANAGEMENT
:: =====================================


:POWER_MENU

cls

echo.
call :PINK_LINE
call :CENTER "POWER MANAGEMENT"
call :PINK_LINE

echo.

call :CHECK_POWER

echo.

echo [1] Ultimate Performance

echo [2] High Performance

echo [3] Balanced

echo.

echo [0] Back


echo.

set /p choice=Select Option:


if "%choice%"=="1" goto ULTIMATE
if "%choice%"=="2" goto HIGH
if "%choice%"=="3" goto BALANCED
if "%choice%"=="0" goto TWEAKS


goto POWER_MENU





:ULTIMATE

powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749eb61


if %errorlevel% neq 0 (
call :FAILED "Ultimate Performance"
goto POWER_MENU
)


call :SUCCESS "Ultimate Performance Enabled"

goto POWER_MENU





:HIGH

powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c83d5


if %errorlevel% neq 0 (
call :FAILED "High Performance"
goto POWER_MENU
)


call :SUCCESS "High Performance Enabled"

goto POWER_MENU





:BALANCED

powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e


if %errorlevel% neq 0 (
call :FAILED "Balanced Power Plan"
goto POWER_MENU
)


call :SUCCESS "Balanced Power Plan Enabled"

goto POWER_MENU







:: =====================================
:: GAMING OPTIMIZATION
:: =====================================


:GAMING_MENU

cls

echo.
call :PINK_LINE
call :CENTER "GAMING OPTIMIZATION"
call :PINK_LINE

echo.

call :CHECK_GAME
call :CHECK_DVR

echo.

echo [1] Enable Game Mode

echo [2] Disable Game Mode

echo.

echo [3] Disable Xbox DVR

echo [4] Enable Xbox DVR


echo.

echo [0] Back


echo.

set /p choice=Select Option:


if "%choice%"=="1" goto GAME_ON
if "%choice%"=="2" goto GAME_OFF
if "%choice%"=="3" goto DVR_OFF
if "%choice%"=="4" goto DVR_ON
if "%choice%"=="0" goto TWEAKS


goto GAMING_MENU







:GAME_ON

reg add "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 1 /f >nul


call :SUCCESS "Game Mode Enabled"

goto GAMING_MENU







:GAME_OFF

reg add "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 0 /f >nul


call :SUCCESS "Game Mode Disabled"

goto GAMING_MENU







:DVR_OFF

reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >nul

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f >nul


call :SUCCESS "Xbox DVR Disabled"

goto GAMING_MENU







:DVR_ON

reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 1 /f >nul

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 1 /f >nul


call :SUCCESS "Xbox DVR Enabled"

goto GAMING_MENU

:: =====================================
:: GPU OPTIMIZATION
:: =====================================


:GPU_MENU

cls

echo.
call :PINK_LINE
call :CENTER "GPU OPTIMIZATION"
call :PINK_LINE

echo.

call :CHECK_HAGS

echo.

echo [1] Enable HAGS

echo [2] Disable HAGS

echo.

echo [0] Back


echo.

set /p choice=Select Option:


if "%choice%"=="1" goto HAGS_ON
if "%choice%"=="2" goto HAGS_OFF
if "%choice%"=="0" goto TWEAKS


goto GPU_MENU







:HAGS_ON

reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 2 /f >nul


if %errorlevel% neq 0 (
call :FAILED "Enable HAGS"
goto GPU_MENU
)


call :SUCCESS "HAGS Enabled - Restart Required"

goto GPU_MENU







:HAGS_OFF

reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 1 /f >nul


if %errorlevel% neq 0 (
call :FAILED "Disable HAGS"
goto GPU_MENU
)


call :SUCCESS "HAGS Disabled - Restart Required"

goto GPU_MENU







:: =====================================
:: GAMING PROFILES
:: =====================================


:PROFILE_MENU

cls

echo.
call :PINK_LINE
call :CENTER "GAMING PROFILES"
call :PINK_LINE

echo.

echo [1] Competitive Gaming Mode

echo [2] Balanced Gaming Mode

echo [3] Battery Saving Mode

echo.

echo [0] Back


echo.

set /p choice=Select Option:


if "%choice%"=="1" goto COMPETITIVE
if "%choice%"=="2" goto BALANCED_MODE
if "%choice%"=="3" goto BATTERY_MODE
if "%choice%"=="0" goto TWEAKS


goto PROFILE_MENU







:COMPETITIVE

cls

echo.
echo Applying Competitive Gaming Mode...
echo.


:: Ultimate Performance

powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749eb61


:: Enable Game Mode

reg add "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 1 /f >nul


:: Disable Xbox DVR

reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >nul


reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f >nul


call :SUCCESS "Competitive Gaming Mode Applied"

goto PROFILE_MENU







:BALANCED_MODE

cls

echo.
echo Applying Balanced Gaming Mode...
echo.


powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e


reg add "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 1 /f >nul


call :SUCCESS "Balanced Gaming Mode Applied"

goto PROFILE_MENU







:BATTERY_MODE

cls

echo.
echo Applying Battery Saving Mode...
echo.


powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e


reg add "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 0 /f >nul


call :SUCCESS "Battery Saving Mode Applied"

goto PROFILE_MENU







:: =====================================
:: DIAGNOSTICS
:: =====================================


:DIAGNOSTICS

cls

echo.
call :PINK_LINE
call :CENTER "REALFPS DIAGNOSTICS"
call :PINK_LINE

echo.


echo CPU:

powershell -command "Get-CimInstance Win32_Processor | Select-Object -ExpandProperty Name"


echo.

echo GPU:

powershell -command "Get-CimInstance Win32_VideoController | Select-Object -ExpandProperty Name"


echo.

echo RAM:

powershell -command "[math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB,2); Write-Host GB"


echo.

echo Windows:

powershell -command "Get-CimInstance Win32_OperatingSystem | Select-Object -ExpandProperty Caption"


echo.

echo GPU Driver:

powershell -command "Get-CimInstance Win32_VideoController | Select-Object -ExpandProperty DriverVersion"


echo.

echo Disk:

powershell -command "Get-PSDrive C | Select-Object Used,Free"


echo.

echo Network:

ping 8.8.8.8 -n 4


call :LOG "Diagnostics Completed"


pause

goto MENU

:: =====================================
:: INFORMATION
:: =====================================


:INFORMATION

cls

echo.
call :PINK_LINE
call :CENTER "REALFPS INFORMATION"
call :PINK_LINE

echo.

echo [1] About RealFPS

echo [2] Developer Info

echo [3] Generate Report

echo.

echo [0] Back


echo.

set /p choice=Select Option:


if "%choice%"=="1" goto ABOUT
if "%choice%"=="2" goto DEV_INFO
if "%choice%"=="3" goto REPORT
if "%choice%"=="0" goto MENU


goto INFORMATION







:ABOUT

cls

echo.
call :PINK_LINE
call :CENTER "ABOUT REALFPS"
call :PINK_LINE

echo.

echo RealFPS is a free and open-source
echo Windows Gaming Optimization Toolkit.

echo.

echo Project:
echo RealFPS

echo.

echo Version:
echo %VERSION%

echo.

echo Developer:
echo %DEVELOPER%

echo.

echo Philosophy:
echo Real Tweaks
echo Real Results
echo No Placebo

pause

goto INFORMATION







:DEV_INFO

cls

echo.
call :PINK_LINE
call :CENTER "DEVELOPER INFORMATION"
call :PINK_LINE

echo.

echo Project:
echo RealFPS

echo.

echo Developer:
echo %DEVELOPER%

echo.

echo Build:
echo %BUILD%

echo.

echo Language:
echo Windows Batch Script


pause

goto INFORMATION







:REPORT

cls

echo Creating RealFPS Report...


(
echo =====================================
echo        RealFPS System Report
echo =====================================

echo.
echo Version:
echo %VERSION%

echo.
echo Developer:
echo %DEVELOPER%

echo.

echo CPU:

powershell -command "Get-CimInstance Win32_Processor ^| Select -ExpandProperty Name"

echo.

echo GPU:

powershell -command "Get-CimInstance Win32_VideoController ^| Select -ExpandProperty Name"

echo.

echo RAM:

powershell -command "[math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory/1GB,2)"

echo.

echo Power:

powercfg /getactivescheme


echo.

echo Game Mode:

reg query "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled


echo.

echo Xbox DVR:

reg query "HKCU\System\GameConfigStore" /v GameDVR_Enabled


echo.

echo HAGS:

reg query "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode 2^>nul


) > RealFPS_Report.txt


call :SUCCESS "Report Generated"


goto INFORMATION







:: =====================================
:: BACKUP SYSTEM
:: =====================================


:BACKUP_MENU

cls

echo.
call :PINK_LINE
call :CENTER "BACKUP AND RESTORE"
call :PINK_LINE

echo.

echo [1] Backup RealFPS Settings

echo [2] Restore Settings

echo.

echo [0] Back


echo.

set /p choice=Select Option:


if "%choice%"=="1" goto BACKUP
if "%choice%"=="2" goto RESTORE_BACKUP
if "%choice%"=="0" goto PREPARATION


goto BACKUP_MENU







:BACKUP

echo Creating Backup...


reg export "HKCU\Software\Microsoft\GameBar" RealFPS_GameMode_Backup.reg /y >nul

reg export "HKCU\System\GameConfigStore" RealFPS_DVR_Backup.reg /y >nul

reg export "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" RealFPS_GameDVR_Backup.reg /y >nul

reg export "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" RealFPS_HAGS_Backup.reg /y >nul


call :SUCCESS "Backup Created"


goto BACKUP_MENU







:RESTORE_BACKUP

echo Restoring Backup...


if exist RealFPS_GameMode_Backup.reg reg import RealFPS_GameMode_Backup.reg

if exist RealFPS_DVR_Backup.reg reg import RealFPS_DVR_Backup.reg

if exist RealFPS_GameDVR_Backup.reg reg import RealFPS_GameDVR_Backup.reg

if exist RealFPS_HAGS_Backup.reg reg import RealFPS_HAGS_Backup.reg


call :SUCCESS "Restore Completed"


goto BACKUP_MENU







:: =====================================
:: RECOMMENDATION
:: =====================================


:RECOMMEND

cls

echo.
call :PINK_LINE
call :CENTER "RECOMMENDED SETTINGS"
call :PINK_LINE

echo.


for /f %%a in ('powershell -command "[math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory/1GB)"') do set RAM=%%a


echo RAM:
echo %RAM% GB


echo.

if %RAM% GEQ 16 (
echo [OK] System suitable for gaming
) else (
echo [INFO] Close background apps
)


echo.

echo Recommended:

echo - Enable Game Mode

echo - Disable Xbox DVR

echo - Update GPU Driver

echo - Use High Performance while plugged in


pause

goto PREPARATION







:: =====================================
:: ENV CHECK
:: =====================================


:ENV_CHECK

cls

echo.
echo =====================================
echo RealFPS Environment Check
echo =====================================

echo.

echo Checking PowerShell...

powershell -command "Write-Host PowerShell OK"


echo.

echo Checking PowerCFG...

powercfg /getactivescheme >nul


echo.

echo System Ready

timeout /t 2 >nul

exit /b







:: =====================================
:: DISPLAY FUNCTIONS
:: =====================================


:PINK_LINE

echo ==================================================

exit /b







:CENTER

echo                 %~1

exit /b







:SUCCESS

echo.
echo =====================================
echo [SUCCESS] %~1
echo =====================================

call :LOG "SUCCESS - %~1"

pause

exit /b







:FAILED

echo.
echo =====================================
echo [FAILED] %~1
echo =====================================

call :LOG "FAILED - %~1"

pause

exit /b







:LOG

echo [%date% %time%] %~1 >> RealFPS_Log.txt

exit /b







:: =====================================
:: STATUS CHECK
:: =====================================


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







:CHECK_HAGS

for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode 2^>nul') do set hags=%%a


if "%hags%"=="0x2" (
echo HAGS: ON
) else (
echo HAGS: DEFAULT
)

exit /b
