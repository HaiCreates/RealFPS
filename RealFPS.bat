@echo off
chcp 65001 >nul
title RealFPS - Windows Gaming Optimizer
color 07

set "VERSION=1.0-beta"
set "BUILD=2026.07"
set "DEVELOPER=Nguyen Thanh Thien Hai"


:: =====================================
:: REALFPS START
:: =====================================

call :ENV_CHECK
call :INTRO


:: =====================================
:: MAIN MENU
:: =====================================

:MENU

cls

echo.
echo ==================================================

call :CENTER_PINK "REALFPS"
call :CENTER_WHITE "Windows Gaming Optimizer"
call :CENTER_WHITE "Version %VERSION%"

echo ==================================================

echo.

echo STATUS
call :CHECK_POWER
call :CHECK_GAME
call :CHECK_DVR
call :CHECK_HAGS

echo.

echo ==================================================
call :CENTER_PINK "MENU"
echo ==================================================

echo.

call :CENTER "[1] Start Optimization        [2] Diagnostics"
call :CENTER "[3] Information               [0] Exit"

echo.


set /p choice=Select Option: 


if "%choice%"=="1" goto START_OPTIMIZATION
if "%choice%"=="2" goto DIAGNOSTICS
if "%choice%"=="3" goto INFORMATION
if "%choice%"=="0" exit


goto MENU







:: =====================================
:: INTRO
:: =====================================

:INTRO

cls

echo.
echo ==================================================

call :CENTER_PINK "REALFPS"
call :CENTER_WHITE "Windows Gaming Optimizer"
call :CENTER_WHITE "Version %VERSION%"

echo ==================================================

echo.

call :CENTER "Welcome to RealFPS."

echo.

call :CENTER "RealFPS is a free and open-source"

echo.

echo =====================================
call :CENTER_PINK "PROJECT INFORMATION"
echo =====================================

echo.

call :CENTER "PROJECT INFORMATION"

echo.

call :CENTER "RealFPS"
call :CENTER "Version %VERSION%"
call :CENTER "Build %BUILD%"
call :CENTER "Developer %DEVELOPER%"
call :CENTER "Real Tweaks | Real Results | No Placebo"

echo.

call :CENTER "Philosophy        Real Tweaks"
call :CENTER "Real Results        No Placebo"

echo.

echo =====================================
call :CENTER_PINK "IMPORTANT NOTICE"
echo =====================================

echo.

call :CENTER_GREEN "RealFPS should be run as Administrator."

echo.

call :CENTER_GREEN "Administrator permission is required for system optimization features."

echo.

echo =====================================

pause

exit /b







:: =====================================
:: START OPTIMIZATION
:: =====================================

:START_OPTIMIZATION

cls

echo.
echo ==================================================
call :CENTER_PINK "START OPTIMIZATION"
echo ==================================================

echo.

echo RealFPS will guide you through
echo system optimization step by step.

echo.

echo The process includes:

echo.

call :CENTER "STEP 1/3 - SYSTEM PREPARATION"

echo - Create Restore Point
echo - Hardware Detection
echo - Recommended Settings

echo.

call :CENTER "STEP 2/3 - REALFPS-TEAWKS"

echo - Power Management
echo - Gaming Optimization
echo - GPU Optimization

echo.

call :CENTER "STEP 3/3 - Gaming Profile"

echo - Competitive
echo - Balanced
echo - Battery Saving

echo.

echo ==================================================

echo.

echo Continue optimization?

echo.

echo [1] Yes

echo [0] No


echo.

set /p choice=Select Option:


if "%choice%"=="1" goto STEP_1

if "%choice%"=="0" goto CANCEL_OPTIMIZATION


goto START_OPTIMIZATION







:CANCEL_OPTIMIZATION

cls

echo.

echo Optimization cancelled.

echo.

echo Returning to RealFPS Introduction...

timeout /t 3 >nul

goto INTRO







:: =====================================
:: STEP 1
:: =====================================

:STEP_1

cls

echo.
echo ==================================================
call :CENTER_PINK "STEP 1/3"
call :CENTER_PINK "SYSTEM PREPARATION"
echo ==================================================

echo.

echo Before changing Windows settings,
echo RealFPS recommends preparing your system.

echo.

echo This step will:

echo.

echo [1] Create Restore Point

echo [2] Detect Hardware

echo [3] Analyze Recommendation


echo.

echo Continue Step 1?

echo.

echo [1] Continue

echo [0] Cancel


echo.

set /p choice=Select Option:


if "%choice%"=="1" goto PREPARATION

if "%choice%"=="0" goto CANCEL_OPTIMIZATION


goto STEP_1

:: =====================================
:: SYSTEM PREPARATION
:: =====================================


:PREPARATION

cls

echo.
echo ==================================================
call :CENTER_PINK "STEP 1/3"
call :CENTER_PINK "SYSTEM PREPARATION"
echo ==================================================

echo.

echo Preparing your system...

echo.

echo [1] Create Restore Point

echo [2] Hardware Detection

echo [3] Recommended Settings

echo [4] Continue to RealFPS Tweaks

echo.

echo [0] Cancel


echo.

set /p choice=Select Option:


if "%choice%"=="1" goto RESTORE_POINT

if "%choice%"=="2" goto HARDWARE_SCAN

if "%choice%"=="3" goto RECOMMEND

if "%choice%"=="4" goto STEP_2

if "%choice%"=="0" goto CANCEL_OPTIMIZATION


goto PREPARATION







:: =====================================
:: RESTORE POINT
:: =====================================


:RESTORE_POINT

cls

echo.
echo ==================================================
echo             RESTORE POINT
echo ==================================================

echo.

echo RealFPS will create a Windows Restore Point.

echo.

echo This allows you to safely return
echo to the previous system state.

echo.

echo Continue?

echo.

echo [1] Create Restore Point

echo [0] Back


echo.

set /p choice=Select Option:


if "%choice%"=="1" (

powershell -command "Checkpoint-Computer -Description 'Before RealFPS Optimization' -RestorePointType MODIFY_SETTINGS"

echo.

echo Restore Point Created.

pause

goto PREPARATION

)


if "%choice%"=="0" goto PREPARATION


goto RESTORE_POINT







:: =====================================
:: HARDWARE DETECTION
:: =====================================


:HARDWARE_SCAN

cls

echo.
echo ==================================================
echo          HARDWARE DETECTION
echo ==================================================

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


echo.

echo Architecture:

powershell -command "Get-CimInstance Win32_OperatingSystem | Select -ExpandProperty OSArchitecture"


echo.

echo Hardware Scan Complete.


pause

goto PREPARATION







:: =====================================
:: RECOMMENDATION
:: =====================================


:RECOMMEND

cls

echo.
echo ==================================================
echo        REALFPS RECOMMENDED SETTINGS
echo ==================================================

echo.


echo Checking system...

echo.


for /f %%a in ('powershell -command "[math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory/1GB)"') do set RAM=%%a


echo RAM:
echo %RAM% GB


echo.


if %RAM% GEQ 16 (

echo [OK] System RAM is suitable for gaming

) else (

echo [INFO] Consider closing background apps

)


echo.

echo Recommended:

echo.

echo [OK] Enable Game Mode

echo [OK] Disable Xbox DVR

echo [OK] Update GPU Driver

echo [OK] Use High Performance while gaming


echo.

echo Recommendation complete.


pause

goto PREPARATION







:: =====================================
:: STEP 2
:: =====================================


:STEP_2

cls

echo.
echo ==================================================
echo              STEP 2/3
echo           REALFPS TWEAKS
echo ==================================================

echo.


echo This step applies Windows gaming
echo optimization settings.

echo.


echo Includes:

echo.

echo [1] Power Management

echo [2] Gaming Optimization

echo [3] GPU Optimization


echo.


echo Changes may require restart.

echo.


echo Continue?

echo.

echo [1] Continue

echo [0] Cancel


echo.

set /p choice=Select Option:


if "%choice%"=="1" goto TWEAKS_MENU

if "%choice%"=="0" goto CANCEL_OPTIMIZATION


goto STEP_2







:: =====================================
:: REALFPS TWEAKS MENU
:: =====================================


:TWEAKS_MENU

cls

echo.
echo ==================================================
echo              REALFPS TWEAKS
echo ==================================================

echo.

echo [1] Power Management

echo.

echo [2] Gaming Optimization

echo.

echo [3] GPU Optimization

echo.

echo [4] Continue Gaming Profile


echo.

echo [0] Back


echo.

set /p choice=Select Option:


if "%choice%"=="1" goto POWER_MENU

if "%choice%"=="2" goto GAMING_MENU

if "%choice%"=="3" goto GPU_MENU

if "%choice%"=="4" goto STEP_3

if "%choice%"=="0" goto STEP_2


goto TWEAKS_MENU

:: =====================================
:: POWER MANAGEMENT
:: =====================================


:POWER_MENU

cls

echo.
echo ==================================================
echo          POWER MANAGEMENT
echo ==================================================

echo.

echo Current Status:

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

if "%choice%"=="0" goto TWEAKS_MENU


goto POWER_MENU







:ULTIMATE

powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749eb61


call :SUCCESS "Ultimate Performance Enabled"

goto POWER_MENU







:HIGH

powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c83d5


call :SUCCESS "High Performance Enabled"

goto POWER_MENU







:BALANCED

powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e


call :SUCCESS "Balanced Power Enabled"

goto POWER_MENU







:: =====================================
:: GAMING OPTIMIZATION
:: =====================================


:GAMING_MENU

cls

echo.
echo ==================================================
echo          GAMING OPTIMIZATION
echo ==================================================

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

if "%choice%"=="0" goto TWEAKS_MENU


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
echo ==================================================
echo             GPU OPTIMIZATION
echo ==================================================

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

if "%choice%"=="0" goto TWEAKS_MENU


goto GPU_MENU







:HAGS_ON

reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 2 /f >nul


call :SUCCESS "HAGS Enabled - Restart Required"

goto GPU_MENU







:HAGS_OFF

reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 1 /f >nul


call :SUCCESS "HAGS Disabled - Restart Required"

goto GPU_MENU







:: =====================================
:: STEP 3
:: =====================================


:STEP_3

cls

echo.
echo ==================================================
echo              STEP 3/3
echo          GAMING PROFILE
echo ==================================================

echo.

echo Choose a profile:

echo.

echo [1] Competitive Gaming

echo [2] Balanced Gaming

echo [3] Battery Saving

echo.

echo [0] Finish


echo.

set /p choice=Select Option:


if "%choice%"=="1" goto COMPETITIVE

if "%choice%"=="2" goto BALANCED_PROFILE

if "%choice%"=="3" goto BATTERY_PROFILE

if "%choice%"=="0" goto FINISH


goto STEP_3







:COMPETITIVE

powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749eb61

reg add "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 1 /f >nul

reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >nul


call :SUCCESS "Competitive Profile Applied"

goto STEP_3







:BALANCED_PROFILE

powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e

reg add "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 1 /f >nul


call :SUCCESS "Balanced Profile Applied"

goto STEP_3







:BATTERY_PROFILE

powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e

reg add "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 0 /f >nul


call :SUCCESS "Battery Profile Applied"

goto STEP_3







:FINISH

cls

echo.
echo ==================================================
echo        REALFPS OPTIMIZATION COMPLETE
echo ==================================================

echo.

echo All selected optimizations are completed.

echo.

echo Restart Windows is recommended.

echo.

pause

goto MENU

:: =====================================
:: DIAGNOSTICS
:: =====================================


:DIAGNOSTICS

cls

echo.
echo ==================================================
echo             REALFPS DIAGNOSTICS
echo ==================================================

echo.

echo Diagnostics is used to check:
echo - Hardware information
echo - Windows status
echo - Optimization status
echo - Driver information

echo.

pause


cls

echo.
echo ==================================================
echo             SYSTEM INFORMATION
echo ==================================================

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


echo.

echo Architecture:

powershell -command "Get-CimInstance Win32_OperatingSystem | Select -ExpandProperty OSArchitecture"


echo.

echo GPU Driver:

powershell -command "Get-CimInstance Win32_VideoController | Select -ExpandProperty DriverVersion"


echo.


echo ==================================================
echo             OPTIMIZATION STATUS
echo ==================================================

echo.


call :CHECK_POWER

call :CHECK_GAME

call :CHECK_DVR

call :CHECK_HAGS


echo.


echo Disk:

powershell -command "Get-PSDrive C | Select Used,Free"


echo.


echo Network Test:

ping 8.8.8.8 -n 4


pause

goto MENU







:: =====================================
:: INFORMATION
:: =====================================


:INFORMATION

cls

echo.
echo ==================================================
echo              REALFPS INFORMATION
echo ==================================================

echo.

echo [1] About RealFPS

echo.

echo [2] Developer Information

echo.

echo [3] Project Philosophy

echo.

echo [0] Back


echo.

set /p choice=Select Option:


if "%choice%"=="1" goto ABOUT

if "%choice%"=="2" goto DEV_INFO

if "%choice%"=="3" goto PHILOSOPHY

if "%choice%"=="0" goto MENU


goto INFORMATION







:: =====================================
:: ABOUT
:: =====================================


:ABOUT

cls

echo.
echo ==================================================
echo                 ABOUT REALFPS
echo ==================================================

echo.

echo RealFPS is a free and open-source
echo Windows Gaming Optimization Toolkit.

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

pause

goto INFORMATION







:: =====================================
:: DEVELOPER
:: =====================================


:DEV_INFO

cls

echo.
echo ==================================================
echo          DEVELOPER INFORMATION
echo ==================================================

echo.

echo Project:
echo RealFPS

echo.

echo Created by:

echo %DEVELOPER%

echo.

echo Language:

echo Windows Batch Script


echo.

pause

goto INFORMATION







:: =====================================
:: PHILOSOPHY
:: =====================================


:PHILOSOPHY

cls

echo.
echo ==================================================
echo          REALFPS PHILOSOPHY
echo ==================================================

echo.

echo RealFPS follows:

echo.

echo Real Tweaks

echo Real Results

echo No Placebo

echo.

echo The goal is not to promise
echo unrealistic FPS increases.

echo.

echo RealFPS focuses on:
echo - Safe changes
echo - Transparent settings
echo - Measurable improvements

echo.

pause

goto INFORMATION

:: =====================================
:: ENVIRONMENT CHECK
:: =====================================


:ENV_CHECK

cls

echo.
echo ==================================================
echo          REALFPS ENVIRONMENT CHECK
echo ==================================================

echo.

echo Checking Windows...

ver


echo.

echo Checking PowerShell...

powershell -command "Write-Host PowerShell OK"


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

echo System Ready.


timeout /t 3 >nul


exit /b







:: =====================================
:: BACKUP / RESTORE
:: =====================================


:BACKUP

cls

echo.
echo ==================================================
echo             REALFPS BACKUP
echo ==================================================

echo.

echo Creating backup...


reg export "HKCU\Software\Microsoft\GameBar" RealFPS_GameMode_Backup.reg /y >nul

reg export "HKCU\System\GameConfigStore" RealFPS_DVR_Backup.reg /y >nul

reg export "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" RealFPS_GameDVR_Backup.reg /y >nul

reg export "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" RealFPS_HAGS_Backup.reg /y >nul


call :SUCCESS "Backup Created"

goto MENU







:RESTORE_BACKUP

cls

echo.
echo ==================================================
echo          REALFPS RESTORE
echo ==================================================

echo.

echo Restoring settings...


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


call :SUCCESS "Backup Restored"

goto MENU







:: =====================================
:: LOG SYSTEM
:: =====================================


:LOG

echo [%date% %time%] %~1 >> RealFPS_Log.txt

exit /b







:: =====================================
:: SUCCESS MESSAGE
:: =====================================


:SUCCESS

call :LOG "SUCCESS - %~1"


echo.

echo ==================================================

echo [SUCCESS]

echo %~1

echo ==================================================


pause

exit /b







:: =====================================
:: FAILED MESSAGE
:: =====================================


:FAILED

call :LOG "FAILED - %~1"


echo.

echo ==================================================

echo [FAILED]

echo %~1

echo ==================================================


pause

exit /b







:: =====================================
:: STATUS CHECK
:: =====================================


:CHECK_POWER

for /f "tokens=4" %%a in ('powercfg /getactivescheme') do set power=%%a


echo Power Plan:

echo %power%


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







:CENTER
powershell -command "$text='%~1'; $width=50; $pad=[math]::Max(0,($width-$text.Length)/2); Write-Host (' '*$pad+$text)"
exit /b







:GREEN
powershell -command "Write-Host '%~1' -ForegroundColor Green"
exit /b


:WHITE
powershell -command "Write-Host '%~1' -ForegroundColor White"
exit /b


:PINK
powershell -command "Write-Host '%~1' -ForegroundColor Magenta"
exit /b


:CYAN
powershell -command "Write-Host '%~1' -ForegroundColor Cyan"
exit /b


:YELLOW
powershell -command "Write-Host '%~1' -ForegroundColor Yellow"
exit /b


:RED
powershell -command "Write-Host '%~1' -ForegroundColor Red"
exit /b







:CENTER_PINK
powershell -command "$t='%~1';$p=(' '*((50-$t.Length)/2));Write-Host ($p+$t) -ForegroundColor Magenta"
exit /b


:CENTER_WHITE
powershell -command "$t='%~1';$p=(' '*((50-$t.Length)/2));Write-Host ($p+$t) -ForegroundColor White"
exit /b
