@echo off
chcp 65001 >nul
title RealFPS - Windows Gaming Optimizer
color 07

set VERSION=1.0-beta
set BUILD=2026.07
set DEVELOPER=Nguyen Thanh Thien Hai


rem =====================================
rem RealFPS - Windows Gaming Optimizer
rem Safe Gaming Optimization Toolkit
rem =====================================


:: Enable ANSI Color
for /f "tokens=1,2 delims=#" %%A in ('"prompt #$H#$E# & echo on & for %%B in (1) do rem"') do set "ESC=%%B"


call :ENV_CHECK



:MENU

cls

echo.
call :LINE
call :CENTER "REALFPS"
call :CENTER "Windows Gaming Optimizer"
call :CENTER "Version %VERSION%"
call :LINE

echo.

call :MENU_ITEM 1 "Power"
echo.
call :MENU_ITEM 2 "Gaming"
echo.
call :MENU_ITEM 3 "GPU"
echo.
call :MENU_ITEM 4 "Profiles"
echo.
call :MENU_ITEM 5 "Tools"
echo.
call :MENU_ITEM 6 "Information"

echo.

call :BACK_ITEM 0 "Exit"

echo.
call :LINE

echo.

set /p choice=Select Option: 


if "%choice%"=="1" goto MENU_POWER
if "%choice%"=="2" goto MENU_GAMING
if "%choice%"=="3" goto MENU_GPU
if "%choice%"=="4" goto MENU_PROFILE
if "%choice%"=="5" goto MENU_TOOLS
if "%choice%"=="6" goto MENU_INFO
if "%choice%"=="0" exit

goto MENU






:MENU_POWER

cls

echo.
call :LINE
call :CENTER "POWER"
call :LINE

echo.

call :CHECK_POWER

echo.

call :MENU_ITEM 1 "Ultimate Performance"
call :MENU_ITEM 2 "High Performance"
call :MENU_ITEM 3 "Balanced"

echo.

call :BACK_ITEM 0 "Back"

echo.

set /p choice=Select Option:


if "%choice%"=="1" goto ULTIMATE
if "%choice%"=="2" goto HIGH
if "%choice%"=="3" goto BALANCED
if "%choice%"=="0" goto MENU

goto MENU_POWER






:ULTIMATE

powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749eb61


if errorlevel 1 (
call :FAILED "Ultimate Performance"
goto MENU_POWER
)


call :SUCCESS "Ultimate Performance Enabled"

goto MENU_POWER






:HIGH

powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c83d5


if errorlevel 1 (
call :FAILED "High Performance"
goto MENU_POWER
)


call :SUCCESS "High Performance Enabled"

goto MENU_POWER






:BALANCED

powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e


if errorlevel 1 (
call :FAILED "Balanced Power Plan"
goto MENU_POWER
)


call :SUCCESS "Balanced Power Plan Enabled"

goto MENU_POWER










:MENU_GAMING

cls

echo.
call :LINE
call :CENTER "GAMING"
call :LINE

echo.


call :CHECK_GAME
call :CHECK_DVR


echo.

call :MENU_ITEM 1 "Enable Game Mode"
call :MENU_ITEM 2 "Disable Game Mode"

echo.

call :MENU_ITEM 3 "Disable Xbox DVR"
call :MENU_ITEM 4 "Enable Xbox DVR"

echo.

call :BACK_ITEM 0 "Back"


echo.

set /p choice=Select Option:


if "%choice%"=="1" goto GAMEON
if "%choice%"=="2" goto GAMEOFF
if "%choice%"=="3" goto DVR_OFF
if "%choice%"=="4" goto DVR_ON
if "%choice%"=="0" goto MENU


goto MENU_GAMING







:GAMEON

reg add "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 1 /f >nul


if errorlevel 1 (
call :FAILED "Enable Game Mode"
goto MENU_GAMING
)


call :SUCCESS "Game Mode Enabled"

goto MENU_GAMING







:GAMEOFF

reg add "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 0 /f >nul


if errorlevel 1 (
call :FAILED "Disable Game Mode"
goto MENU_GAMING
)


call :SUCCESS "Game Mode Disabled"

goto MENU_GAMING







:DVR_OFF

reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >nul

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f >nul


if errorlevel 1 (
call :FAILED "Disable Xbox DVR"
goto MENU_GAMING
)


call :SUCCESS "Xbox DVR Disabled"

goto MENU_GAMING







:DVR_ON

reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 1 /f >nul

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 1 /f >nul


if errorlevel 1 (
call :FAILED "Enable Xbox DVR"
goto MENU_GAMING
)


call :SUCCESS "Xbox DVR Enabled"

goto MENU_GAMING

:MENU_GPU

cls

echo.
call :LINE
call :CENTER "GPU"
call :LINE

echo.

call :CHECK_HAGS

echo.

call :MENU_ITEM 1 "Enable HAGS"
call :MENU_ITEM 2 "Disable HAGS"

echo.

call :BACK_ITEM 0 "Back"

echo.

set /p choice=Select Option:


if "%choice%"=="1" goto HAGS_ON
if "%choice%"=="2" goto HAGS_OFF
if "%choice%"=="0" goto MENU

goto MENU_GPU





:HAGS_ON

reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 2 /f >nul


if errorlevel 1 (
call :FAILED "Enable HAGS"
goto MENU_GPU
)


call :SUCCESS "HAGS Enabled - Restart Required"

goto MENU_GPU





:HAGS_OFF

reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 1 /f >nul


if errorlevel 1 (
call :FAILED "Disable HAGS"
goto MENU_GPU
)


call :SUCCESS "HAGS Disabled - Restart Required"

goto MENU_GPU











:MENU_PROFILE

cls

echo.
call :LINE
call :CENTER "PROFILES"
call :LINE

echo.


call :MENU_ITEM 1 "Competitive Mode"
call :MENU_ITEM 2 "Balanced Mode"
call :MENU_ITEM 3 "Battery Saver"

echo.

call :BACK_ITEM 0 "Back"

echo.


set /p choice=Select Option:


if "%choice%"=="1" goto COMPETITIVE
if "%choice%"=="2" goto BALANCED_MODE
if "%choice%"=="3" goto BATTERY_MODE
if "%choice%"=="0" goto MENU

goto MENU_PROFILE







:COMPETITIVE

echo.
echo Applying Competitive Gaming Mode...


powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749eb61


reg add "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 1 /f >nul


reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >nul


reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f >nul


call :SUCCESS "Competitive Gaming Mode Applied"


goto MENU_PROFILE






:BALANCED_MODE

echo.
echo Applying Balanced Gaming Mode...


powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e


reg add "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 1 /f >nul


call :SUCCESS "Balanced Gaming Mode Applied"


goto MENU_PROFILE






:BATTERY_MODE

echo.
echo Applying Battery Saving Mode...


powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e


reg add "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 0 /f >nul


call :SUCCESS "Battery Saving Mode Applied"


goto MENU_PROFILE










:MENU_INFO

cls

echo.
call :LINE
call :CENTER "INFORMATION"
call :LINE

echo.


call :MENU_ITEM 1 "About RealFPS"
call :MENU_ITEM 2 "Hardware Detection"
call :MENU_ITEM 3 "Recommended Settings"
call :MENU_ITEM 4 "Generate Report"
call :MENU_ITEM 5 "Developer Info"

echo.

call :BACK_ITEM 0 "Back"

echo.


set /p choice=Select Option:


if "%choice%"=="1" goto ABOUT
if "%choice%"=="2" goto HARDWARE_SCAN
if "%choice%"=="3" goto RECOMMEND
if "%choice%"=="4" goto REPORT
if "%choice%"=="5" goto DEV_INFO
if "%choice%"=="0" goto MENU


goto MENU_INFO






:ABOUT

cls

echo.
call :LINE
call :CENTER "ABOUT REALFPS"
call :LINE

echo.

call :CENTER "RealFPS is a free and open-source gaming optimizer"
call :CENTER "built to improve Windows performance."

echo.

call :CENTER "Version: %VERSION%"
call :CENTER "Build: %BUILD%"
call :CENTER "Developer: %DEVELOPER%"

echo.

call :CENTER "Philosophy:"
call :CENTER "Only Measurable Optimizations"
call :CENTER "No Placebo Tweaks"


pause

goto MENU_INFO

:HARDWARE_SCAN

cls

echo.
call :LINE
call :CENTER "REALFPS HARDWARE DETECTION"
call :LINE

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
powershell -command "Get-CimInstance Win32_OperatingSystem | Select-Object Caption"


echo.

echo Architecture:
powershell -command "Get-CimInstance Win32_OperatingSystem | Select-Object OSArchitecture"


pause

goto MENU_INFO







:RECOMMEND

cls

echo.
call :LINE
call :CENTER "REALFPS RECOMMENDATION"
call :LINE

echo.


for /f %%a in ('powershell -command "[math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB)"') do set RAM=%%a


echo RAM:
echo %RAM% GB


echo.

echo Recommended:

echo.


if %RAM% GEQ 16 (
echo [OK] RAM suitable for gaming
) else (
echo [INFO] Close background apps
)


echo.

echo Gaming:
echo [OK] Enable Game Mode
echo [OK] Disable Xbox DVR
echo [OK] Update GPU Driver


echo.

echo Laptop:
echo - Balanced for normal use
echo - High Performance while plugged in


echo.

echo Competitive:
echo - Use Competitive Profile


call :LOG "Recommendation Generated"


pause

goto MENU_INFO












:MENU_TOOLS

cls

echo.
call :LINE
call :CENTER "TOOLS"
call :LINE

echo.


call :MENU_ITEM 1 "Create Restore Point"
call :MENU_ITEM 2 "System Scan"
call :MENU_ITEM 3 "Backup Settings"
call :MENU_ITEM 4 "Restore Settings"
call :MENU_ITEM 5 "Gaming Diagnostics"

echo.

call :BACK_ITEM 0 "Back"

echo.


set /p choice=Select Option:


if "%choice%"=="1" goto RESTORE
if "%choice%"=="2" goto SYSTEM_SCAN
if "%choice%"=="3" goto BACKUP
if "%choice%"=="4" goto RESTORE_BACKUP
if "%choice%"=="5" goto DIAGNOSTICS
if "%choice%"=="0" goto MENU


goto MENU_TOOLS











:SYSTEM_SCAN

cls

echo.
call :LINE
call :CENTER "REALFPS SYSTEM SCAN"
call :LINE

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
powershell -command "Get-CimInstance Win32_OperatingSystem | Select-Object Caption"


echo.

echo Power Plan:
powercfg /getactivescheme


pause

goto MENU_TOOLS











:BACKUP

cls

echo Creating Backup...


reg export "HKCU\Software\Microsoft\GameBar" RealFPS_GameMode_Backup.reg /y >nul

reg export "HKCU\System\GameConfigStore" RealFPS_DVR_Backup.reg /y >nul

reg export "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" RealFPS_GameDVR_Backup.reg /y >nul

reg export "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" RealFPS_HAGS_Backup.reg /y >nul


call :SUCCESS "Backup Created"


goto MENU_TOOLS










:RESTORE_BACKUP

cls

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


call :SUCCESS "Backup Restored"


goto MENU_TOOLS











:RESTORE

cls

echo Creating Restore Point...


powershell -command "Checkpoint-Computer -Description 'Before RealFPS Tweak' -RestorePointType MODIFY_SETTINGS"


if errorlevel 1 (
call :FAILED "Create Restore Point"
goto MENU_TOOLS
)


call :SUCCESS "Restore Point Created"


goto MENU_TOOLS

:DIAGNOSTICS

cls

echo.
call :LINE
call :CENTER "REALFPS GAMING DIAGNOSTICS"
call :LINE

echo.


echo CPU:
powershell -command "Get-CimInstance Win32_Processor | Select-Object -ExpandProperty Name"


echo.

echo GPU:
powershell -command "Get-CimInstance Win32_VideoController | Select-Object -ExpandProperty Name"


echo.

echo Driver:
powershell -command "Get-CimInstance Win32_VideoController | Select-Object DriverVersion"


echo.

echo Disk:
powershell -command "Get-PSDrive C | Select-Object Used,Free"


echo.

echo Network:
ping 8.8.8.8 -n 4


call :LOG "Diagnostics Completed"


pause

goto MENU_TOOLS










:REPORT

cls

echo Creating RealFPS Report...


echo ===================================== > RealFPS_Report.txt
echo RealFPS System Report >> RealFPS_Report.txt
echo ===================================== >> RealFPS_Report.txt


echo. >> RealFPS_Report.txt

echo Version: >> RealFPS_Report.txt
echo %VERSION% >> RealFPS_Report.txt


echo. >> RealFPS_Report.txt

echo CPU: >> RealFPS_Report.txt
powershell -command "Get-CimInstance Win32_Processor | Select-Object -ExpandProperty Name" >> RealFPS_Report.txt


echo. >> RealFPS_Report.txt

echo GPU: >> RealFPS_Report.txt
powershell -command "Get-CimInstance Win32_VideoController | Select-Object -ExpandProperty Name" >> RealFPS_Report.txt


echo. >> RealFPS_Report.txt

echo RAM: >> RealFPS_Report.txt
powershell -command "[math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory/1GB,2)" >> RealFPS_Report.txt


call :LOG "Report Generated"


echo.
call :SUCCESS "Report Created"

pause

goto MENU_INFO











:DEV_INFO

cls

echo.
call :LINE
call :CENTER "DEVELOPER INFORMATION"
call :LINE

echo.


call :CENTER "Project: RealFPS"
call :CENTER "Version: %VERSION%"
call :CENTER "Build: %BUILD%"
call :CENTER "Developer: %DEVELOPER%"
call :CENTER "Language: Windows Batch Script"


pause

goto MENU_INFO











:ENV_CHECK

cls

echo.
call :LINE
call :CENTER "REALFPS ENVIRONMENT CHECK"
call :LINE

echo.


echo Checking Windows...
ver


echo.

echo Checking PowerShell...

powershell -command "Write-Host PowerShell OK"


echo.

echo Checking PowerCFG...

powercfg /getactivescheme >nul


echo.

call :SUCCESS "System Ready"


timeout /t 2 >nul


exit /b











:: =========================
:: COLOR FUNCTIONS
:: =========================


:MENU_ITEM

<nul set /p "=[96m[[97m%~1[96m][97m %~2"
echo.

exit /b





:BACK_ITEM

<nul set /p "=[93m[[97m%~1[93m][97m %~2"
echo.

exit /b





:LINE

echo ==================================================

exit /b





:CENTER

setlocal EnableDelayedExpansion

set "text=%~1"

set /a width=50
set /a len=0


for /l %%A in (0,1,100) do (

if "!text:~%%A,1!"=="" (

set /a len=%%A
goto center_done

)

)


:center_done

set /a space=(width-len)/2


set "pad="

for /l %%A in (1,1,!space!) do (

set "pad=!pad! "

)


echo !pad!!text!


endlocal

exit /b











:SUCCESS

call :LOG "SUCCESS - %~1"


echo.
<nul set /p "=[92m[SUCCESS][97m %~1"
echo.


pause

exit /b











:FAILED

call :LOG "FAILED - %~1"


echo.
<nul set /p "=[91m[FAILED][97m %~1"
echo.


pause

exit /b











:LOG

echo [%date% %time%] %~1 >> RealFPS_Log.txt

exit /b











:: =========================
:: STATUS CHECK
:: =========================


:CHECK_POWER

for /f "tokens=4" %%a in ('powercfg /getactivescheme') do set power=%%a


if /i "%power%"=="381b4222-f694-41f0-9685-ff5bb260df2e" (

echo [BALANCED] Power Plan

) else if /i "%power%"=="8c5e7fda-e8bf-4a96-9a85-a6e23a8c83d5" (

echo [HIGH] Power Plan

) else if /i "%power%"=="e9a42b02-d5df-448d-aa00-03f14749eb61" (

echo [ULTIMATE] Power Plan

) else (

echo [CUSTOM] Power Plan

)


exit /b











:CHECK_GAME


for /f "tokens=3" %%a in ('reg query "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled 2^>nul') do set gm=%%a


if "%gm%"=="0x1" (

echo [ON] Game Mode

) else (

echo [OFF] Game Mode

)


exit /b











:CHECK_DVR


for /f "tokens=3" %%a in ('reg query "HKCU\System\GameConfigStore" /v GameDVR_Enabled 2^>nul') do set dvr=%%a


if "%dvr%"=="0x1" (

echo [ON] Xbox DVR

) else (

echo [OFF] Xbox DVR

)


exit /b











:CHECK_HAGS


for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode 2^>nul') do set hags=%%a


if "%hags%"=="0x2" (

echo [ON] HAGS

) else (

echo [OFF] HAGS

)


exit /b
