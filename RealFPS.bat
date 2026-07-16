@echo off
title RealFPS - Windows Gaming Optimizer
color 0A

set VERSION=1.0-beta
set BUILD=2026.07
set DEVELOPER=Nguyen Thanh Thien Hai

rem =====================================
rem RealFPS - Windows Gaming Optimizer
rem Version: %VERSION%
rem Build: %BUILD%
rem Developer: %DEVELOPER%
rem Purpose:
rem Safe gaming optimization toolkit
rem Only measurable optimizations
rem No placebo tweaks
rem =====================================

call :ENV_CHECK

:MENU
cls
echo.
echo =====================================
echo      RealFPS v%VERSION%
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

echo STATUS
call :CHECK_POWER
call :CHECK_GAME
call :CHECK_DVR
call :CHECK_HAGS
echo.


echo POWER
echo [1] Ultimate Performance
echo [2] High Performance
echo [3] Balanced
call :CHECK_POWER
echo.


echo GAMING
echo [4] Enable Game Mode
echo [5] Disable Game Mode
call :CHECK_GAME
echo.


echo Xbox DVR
echo [6] Disable Xbox DVR
echo [7] Enable Xbox DVR
call :CHECK_DVR
echo.


echo SYSTEM
echo [8] Create Restore Point
echo [11] Scan System Information
echo [12] Backup RealFPS Settings
echo [13] Restore RealFPS Settings

echo DIAGNOSTICS
echo [14] Gaming System Check
echo.


echo PROFILES
echo [15] Competitive Gaming Mode
echo [16] Balanced Gaming Mode
echo [17] Battery Saving Mode
echo.


echo GPU
echo [9] Enable HAGS
echo [10] Disable HAGS
call :CHECK_HAGS


echo INFORMATION
echo [18] About RealFPS
echo [19] Hardware Detection
echo [20] Recommended Settings
echo [21] Generate Report
echo [22] Developer Info
echo.


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

if "%choice%"=="11" goto SYSTEM_SCAN

if "%choice%"=="12" goto BACKUP
if "%choice%"=="13" goto RESTORE_BACKUP

if "%choice%"=="14" goto DIAGNOSTICS

if "%choice%"=="15" goto COMPETITIVE
if "%choice%"=="16" goto BALANCED_MODE
if "%choice%"=="17" goto BATTERY_MODE

if "%choice%"=="18" goto ABOUT
if "%choice%"=="19" goto HARDWARE_SCAN
if "%choice%"=="20" goto RECOMMEND
if "%choice%"=="21" goto REPORT
if "%choice%"=="22" goto DEV_INFO

if "%choice%"=="9" goto HAGS_ON
if "%choice%"=="10" goto HAGS_OFF

if "%choice%"=="0" exit


echo.
echo Invalid option.
pause
exit /b

rem =====================================
rem POWER MANAGEMENT
rem =====================================

:ULTIMATE

powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749eb61

if %errorlevel% neq 0 (
    call :FAILED "Ultimate Performance"
    goto MENU
)

call :SUCCESS "Ultimate Performance Enabled"
goto MENU



:HIGH

powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c83d5

if %errorlevel% neq 0 (
    call :FAILED "High Performance"
    goto MENU
)

call :SUCCESS "High Performance Enabled"
goto MENU



:BALANCED

powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e

if %errorlevel% neq 0 (
    call :FAILED "Balanced Power Plan"
    goto MENU
)

call :SUCCESS "Balanced Power Plan Enabled"
goto MENU

rem =====================================
rem GAME MODE
rem =====================================

:GAMEON

reg add "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 1 /f >nul

if %errorlevel% neq 0 (
    call :FAILED "Enable Game Mode"
    goto MENU
)

call :SUCCESS "Game Mode Enabled"
goto MENU



:GAMEOFF

reg add "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 0 /f >nul

if %errorlevel% neq 0 (
    call :FAILED "Disable Game Mode"
    goto MENU
)

call :SUCCESS "Game Mode Disabled"
goto MENU

rem =====================================
rem XBOX DVR
rem =====================================

:DVR_OFF

reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f >nul

if %errorlevel% neq 0 (
    call :FAILED "Disable Xbox DVR"
    goto MENU
)

call :SUCCESS "Xbox DVR Disabled"
goto MENU



:DVR_ON

reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 1 /f >nul

if %errorlevel% neq 0 (
    call :FAILED "Enable Xbox DVR"
    goto MENU
)

call :SUCCESS "Xbox DVR Enabled"
goto MENU



:SYSTEM_SCAN

cls

echo.
echo =====================================
echo        RealFPS System Scan
echo =====================================
echo.


echo CPU:
powershell -command "Get-CimInstance Win32_Processor | Select-Object -ExpandProperty Name"

echo.
echo GPU:
powershell -command "Get-CimInstance Win32_VideoController | Select-Object -ExpandProperty Name"

echo.
echo RAM:
powershell -command "[math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB,2)"
echo GB

echo.
echo Windows:
powershell -command "Get-CimInstance Win32_OperatingSystem | Select-Object -ExpandProperty Caption"

echo.
echo Architecture:
powershell -command "Get-CimInstance Win32_OperatingSystem | Select-Object -ExpandProperty OSArchitecture"


echo.
echo Power Plan:
powercfg /getactivescheme


echo.
pause
goto MENU

rem =====================================
rem BACKUP SYSTEM
rem =====================================

:BACKUP

echo Creating Backup...

reg export "HKCU\Software\Microsoft\GameBar" RealFPS_GameMode_Backup.reg /y

reg export "HKCU\System\GameConfigStore" RealFPS_DVR_Backup.reg /y

reg export "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" RealFPS_GameDVR_Backup.reg /y

reg export "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" RealFPS_HAGS_Backup.reg /y

if %errorlevel% neq 0 (
    echo HAGS Backup Skipped
)


call :SUCCESS "Backup Created"

goto MENU



:RESTORE_BACKUP

echo Restoring Backup...


if exist RealFPS_GameMode_Backup.reg (
reg import RealFPS_GameMode_Backup.reg
)

if exist RealFPS_DVR_Backup.reg (
reg import RealFPS_DVR_Backup.reg
)

if exist RealFPS_GameDVR_Backup.reg (
reg import RealFPS_GameDVR_Backup.reg
)

if exist RealFPS_HAGS_Backup.reg (
reg import RealFPS_HAGS_Backup.reg
)


call :SUCCESS "Backup Restored - Restart Recommended"

goto MENU



:RESTORE

echo.
echo Creating Restore Point...

powershell -command "Checkpoint-Computer -Description 'Before RealFPS Tweak' -RestorePointType MODIFY_SETTINGS"

if %errorlevel% neq 0 (
    call :FAILED "Create Restore Point"
    goto MENU
)

call :SUCCESS "Restore Point Created"
goto MENU

rem =====================================
rem GPU HARDWARE ACCELERATION
rem =====================================

:HAGS_ON

reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 2 /f >nul

if %errorlevel% neq 0 (
    call :FAILED "Enable HAGS"
    goto MENU
)

call :SUCCESS "HAGS Enabled - Restart Required - Admin Needed"
goto MENU



:HAGS_OFF

reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 1 /f >nul

if %errorlevel% neq 0 (
    call :FAILED "Disable HAGS"
    goto MENU
)

call :SUCCESS "HAGS Disabled - Restart Required - Admin Needed"
goto MENU



:LOG

echo [%date% %time%] %~1 >> RealFPS_Log.txt

exit /b



:DIAGNOSTICS

cls

echo.
echo =====================================
echo      RealFPS Gaming Diagnostics
echo =====================================
echo.


echo CPU:
powershell -command "Get-CimInstance Win32_Processor | Select-Object -ExpandProperty Name"


echo.
echo GPU:
powershell -command "Get-CimInstance Win32_VideoController | Select-Object -ExpandProperty Name"


echo.
echo RAM:
powershell -command "(Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB"


echo.
echo Windows:
powershell -command "Get-CimInstance Win32_OperatingSystem | Select-Object Caption"


echo.
echo System:
powershell -command "Get-CimInstance Win32_OperatingSystem | Select-Object OSArchitecture"


echo.
echo GPU Driver:
powershell -command "Get-CimInstance Win32_VideoController | Select-Object DriverVersion"


echo.
echo Disk:
powershell -command "Get-PSDrive C | Select-Object Used,Free"


echo.
echo Network Test:
ping 8.8.8.8 -n 4


call :LOG "SYSTEM DIAGNOSTICS COMPLETED"

pause
goto MENU



:COMPETITIVE

echo.
echo Applying Competitive Gaming Mode...


rem Ultimate Performance
powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749eb61


rem Enable Game Mode
reg add "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 1 /f >nul


rem Disable Xbox DVR
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >nul

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f >nul

if %errorlevel% neq 0 (
    call :FAILED "Competitive Gaming Mode"
    goto MENU
)

call :SUCCESS "Competitive Gaming Mode Applied"

goto MENU



:BALANCED_MODE

echo.
echo Applying Balanced Gaming Mode...


powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e


reg add "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 1 /f >nul

if %errorlevel% neq 0 (
    call :FAILED "Balanced Gaming Mode"
    goto MENU
)

call :SUCCESS "Balanced Gaming Mode Applied"

goto MENU



:BATTERY_MODE

echo.
echo Applying Battery Saving Mode...


powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e


reg add "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 0 /f >nul

if %errorlevel% neq 0 (
    call :FAILED "Battery Saving Mode"
    goto MENU
)

call :SUCCESS "Battery Saving Mode Applied"

goto MENU



:ABOUT

cls

echo.
echo =====================================
echo             About RealFPS
echo =====================================
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
echo Only Measurable Optimizations
echo No Placebo Tweaks
echo.

pause
goto MENU



:HARDWARE_SCAN

cls

echo.
echo =====================================
echo        RealFPS Hardware Detection
echo =====================================
echo.


echo CPU:
powershell -command "Get-CimInstance Win32_Processor | Select-Object -ExpandProperty Name"


echo.
echo GPU:
powershell -command "Get-CimInstance Win32_VideoController | Select-Object -ExpandProperty Name"


echo.
echo RAM:
powershell -command "[math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB,2); Write-Host 'GB'"


echo.
echo SYSTEM TYPE:

powershell -command "Get-CimInstance Win32_SystemEnclosure | Select-Object ChassisTypes"


echo.
echo WINDOWS:

powershell -command "Get-CimInstance Win32_OperatingSystem | Select-Object Caption"


echo.
echo ARCHITECTURE:

powershell -command "Get-CimInstance Win32_OperatingSystem | Select-Object OSArchitecture"


call :LOG "Hardware Detection Completed"


pause
goto MENU



:RECOMMEND

cls

echo.
echo =====================================
echo       RealFPS Recommendation
echo =====================================
echo.


echo Checking system...


for /f %%a in ('powershell -command "(Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB -as [int]"') do set RAM=%%a


echo.
echo RAM:
echo %RAM% GB


echo.
echo Recommended Settings:
echo.


if %RAM% GEQ 16 (
    echo [OK] RAM is suitable for gaming
) else (
    echo [INFO] Consider closing background apps
)


echo.
echo Gaming:
echo.
echo [OK] Enable Game Mode
echo [OK] Disable Xbox DVR
echo [OK] Keep GPU Driver Updated


echo.
echo Power Recommendation:
echo.


echo Laptop:
echo - Use Balanced for daily use
echo - Use High Performance while plugged in


echo.
echo Competitive Gaming:
echo - Use Competitive Profile


call :LOG "Recommendation Generated"


pause
goto MENU

rem =====================================
rem REPORT GENERATOR
rem =====================================

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
echo Date:
echo %date% %time%

echo.
echo ======================
echo HARDWARE
echo ======================

echo.
echo CPU:
powershell -command "Get-CimInstance Win32_Processor ^| Select -ExpandProperty Name"

echo.
echo GPU:
powershell -command "Get-CimInstance Win32_VideoController ^| Select -ExpandProperty Name"

echo.
echo RAM:
powershell -command "[math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory/1GB,2); Write-Host GB"


echo.
echo ======================
echo OPTIMIZATION STATUS
echo ======================

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

reg query "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode 2>nul


echo.
echo ======================
echo END REPORT
echo ======================

) > RealFPS_Report.txt


call :LOG "Report Generated"

echo.
echo Report Created:
echo RealFPS_Report.txt

pause

goto MENU



:ENV_CHECK

cls

echo.
echo =====================================
echo       RealFPS Environment Check
echo =====================================
echo.


echo Checking Windows...

for /f "tokens=*" %%a in ('ver') do echo %%a

echo.
echo Checking PowerShell...

powershell -command "Write-Host PowerShell OK"


if %errorlevel% neq 0 (
    echo PowerShell ERROR
    pause
    exit
)


echo.
echo Checking PowerCFG...

powercfg /getactivescheme >nul

if %errorlevel% neq 0 (
    echo PowerCFG ERROR
    pause
    exit
)

echo PowerCFG OK


echo.
echo Checking Registry...

reg query "HKCU\Software" >nul

if %errorlevel% neq 0 (
    echo Registry ERROR
    pause
    exit
)

echo Registry OK


echo.
echo System Ready

timeout /t 2 >nul

goto MENU



:DEV_INFO

cls

echo.
echo =====================================
echo Developer Information
echo =====================================
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
echo Language:
echo Windows Batch Script

pause
goto MENU



:SUCCESS

call :LOG "SUCCESS - %~1"

echo.
echo =====================================
echo [SUCCESS] %~1
echo =====================================
pause
exit /b



:FAILED

call :LOG "FAILED - %~1 Error Code: %errorlevel%"

echo.
echo =====================================
echo [FAILED] %~1
echo Error Code: %errorlevel%
echo =====================================
pause
exit /b



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
) else if "%hags%"=="0x1" (
    echo HAGS: OFF
) else (
    echo HAGS: DEFAULT
)

exit /b
