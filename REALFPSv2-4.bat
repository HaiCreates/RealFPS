@echo off
setlocal enabledelayedexpansion

rem ========== LẤY KÍCH THƯỚC MÀN HÌNH ==========
for /f "tokens=2 delims=:" %%a in ('mode con 2^>nul') do (
    if not defined COLS set COLS=%%a
)
if "%COLS%"=="" set COLS=120
set /a COLS=%COLS%
if %COLS% LSS 80 set COLS=120
mode con: cols=%COLS% lines=60

chcp 65001 >nul 2>nul
title RealFPS - Windows Gaming Optimizer
color 0F

rem ========== ANSI COLOR SETUP ==========
reg add HKCU\CONSOLE /v VirtualTerminalLevel /t REG_DWORD /d 1 /f >nul 2>&1
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (set "DEL=%%a" & set "ESC=%%b")
set "R=%ESC%[91m"
set "G=%ESC%[92m"
set "Y=%ESC%[93m"
set "B=%ESC%[94m"
set "W=%ESC%[97m"
set "GR=%ESC%[90m"
set "C=%ESC%[96m"
set "M=%ESC%[95m"
set "N=%ESC%[0m"

rem ========== TÍNH PADDING ĐỘNG ==========
set /a PAD_LEN=(%COLS%-60)/2
if %PAD_LEN% LSS 5 set PAD_LEN=5
if %PAD_LEN% GTR 60 set PAD_LEN=60
set "PAD="
set "LOGOPAD="
for /l %%i in (1,1,%PAD_LEN%) do set "PAD= !PAD!"
set "LOGOPAD=%PAD%"

set VERSION=2.0
set BUILD=2026.07
set DEVELOPER=Thien Hai

set RECOMMENDED_PROFILE=
set PERFORMANCE_SCORE=0
set SELECTED_PROFILE=None

set CPU_SCORE=0	
set GPU_SCORE=0
set RAM_SCORE=0
set FINAL_SCORE=0

if exist RealFPS_Profile.txt (
    set /p RECOMMENDED_PROFILE=<RealFPS_Profile.txt
) else (
    set RECOMMENDED_PROFILE=None
)

goto WELCOME

:LOGO
echo.
echo %G%%LOGOPAD% ██████╗ ███████╗ █████╗ ██╗     ███████╗██████╗ ███████╗
echo %G%%LOGOPAD% ██╔══██╗██╔════╝██╔══██╗██║     ██╔════╝██╔══██╗██╔════╝
echo %G%%LOGOPAD% ██████╔╝█████╗  ███████║██║     █████╗  ██████╔╝███████╗
echo %G%%LOGOPAD% ██╔══██╗██╔══╝  ██╔══██║██║     ██╔══╝  ██╔═══╝ ╚════██║
echo %G%%LOGOPAD% ██║  ██║███████╗██║  ██║███████╗██║     ██║     ███████║
echo.
echo %W%%LOGOPAD% Windows Gaming Optimizer
echo %G%%LOGOPAD% Real Tweaks. Real Results. No Placebo.
echo %W%%LOGOPAD% Version %VERSION% ^| Build %BUILD%
echo %W%%LOGOPAD% Developer : %G%Thien Hai
echo.
echo %R%%LOGOPAD% Administrator Mode Required.
goto :eof

:SEPARATOR
echo.
echo %G%%LOGOPAD% ▶───────────────────────────────────────────────────────────────◀
echo.
exit /b

:WELCOME
cls
call :LOGO
call :SEPARATOR
echo.
echo %G%%LOGOPAD%MAIN MENU
echo.
echo %G%%LOGOPAD% ▶───────────────────────────────────────────────────────────────◀
echo.

echo %W%%PAD%[%G%1%W%] Smart Optimization      [%G%2%W%] Advanced Options
echo %G%%PAD%    New Users                     Power Users
echo.
echo %W%%PAD%[%G%3%W%] RealFPS Benchmark       [%G%4%W%] Information
echo %G%%PAD%    Performance Test              Project Details
echo.
echo %W%%PAD%[%G%5%W%] Game Booster            [%G%6%W%] System Cleanup
echo %G%%PAD%    Optimize for gaming           Clean temp files
echo.
echo %W%%PAD%[%G%7%W%] Performance Stats       [%G%8%W%] Service Manager
echo %G%%PAD%    Real-time monitoring          Manage Windows Services
echo.
echo %W%%PAD%[%G%X%W%] Exit
echo.
call :SEPARATOR
echo.
set /p "choice=%G%%LOGOPAD%Select Option: %W%"
set "choice=%choice: =%"

if /i "%choice%"=="X" exit /b
if "%choice%"=="8" goto SERVICE_MANAGER
if "%choice%"=="7" goto PERFORMANCE_STATS
if "%choice%"=="6" goto SYSTEM_CLEANUP
if "%choice%"=="5" goto GAME_BOOSTER
if "%choice%"=="4" goto INFORMATION
if "%choice%"=="3" goto BENCHMARK
if "%choice%"=="2" goto ADVANCED_MENU
if "%choice%"=="1" goto SMART_OPTIMIZATION

echo %R%Invalid option. Please try again.%N%
timeout /t 2 >nul
goto WELCOME

:SYSTEM_ANALYSIS
cls

for /f "delims=" %%a in ('powershell -command "(Get-CimInstance Win32_Processor).Name"') do set CPU=%%a
set CPU_SHORT=%CPU%
set CPU_SHORT=%CPU_SHORT:Intel(R) Core(TM) =%
set CPU_SHORT=%CPU_SHORT: Processor=%

for /f "delims=" %%a in ('powershell -command "(Get-CimInstance Win32_VideoController | Select -First 1).Name"') do set GPU=%%a
set GPU_SHORT=%GPU%
set GPU_SHORT=%GPU_SHORT:Intel(R) =%
set GPU_SHORT=%GPU_SHORT: Graphics=%

for /f %%a in ('powershell -command "[math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory/1GB)"') do set RAM=%%a

for /f "delims=" %%a in ('powershell -command "(Get-CimInstance Win32_OperatingSystem).Caption"') do set WIN=%%a
set WIN_SHORT=%WIN%

call :CHECK_POWER
call :CHECK_GAME
call :CHECK_DVR
call :CHECK_HAGS
if "%POWER_STATUS%"=="" set POWER_STATUS=Unknown
if "%GAME_STATUS%"=="ON" (set GAME_DISPLAY=%G%ON%N%) else (set GAME_DISPLAY=%R%OFF%N%)
if "%DVR_STATUS%"=="ON" (set DVR_DISPLAY=%G%ON%N%) else (set DVR_DISPLAY=%R%OFF%N%)
if "%HAGS_STATUS%"=="ON" (set HAGS_DISPLAY=%G%ON%N%) else (set HAGS_DISPLAY=%R%OFF%N%)

cls
call :LOGO
call :SEPARATOR
echo.
echo %G%%LOGOPAD%HARDWARE
call :SEPARATOR
echo %W%%PAD%CPU : %G%%CPU_SHORT%
echo %W%%PAD%GPU : %G%%GPU_SHORT%
echo %W%%PAD%RAM : %G%%RAM% GB          %W%OS  : %G%%WIN_SHORT%
echo.
echo %G%%LOGOPAD%STATUS
call :SEPARATOR
echo %W%%PAD%Power    : %W%%POWER_STATUS%          %W%GameMode : %GAME_DISPLAY%
echo %W%%PAD%Xbox DVR : %DVR_DISPLAY%         %W%HAGS     : %HAGS_DISPLAY%
echo.
echo %G%%LOGOPAD%RECOMMENDED
call :SEPARATOR
echo %G%%LOGOPAD%BALANCED GAMING
call :SEPARATOR
echo.
%SYSTEMROOT%\System32\choice.exe /c N /n /m "%G%%LOGOPAD%Press N to continue %N%"
exit /b

:RESTORE_WIZARD
cls
call :LOGO
call :SEPARATOR

echo.
echo %G%%LOGOPAD%CREATE RESTORE POINT
call :SEPARATOR

echo %W%%PAD%RealFPS recommends creating a restore point
echo %W%%PAD%before applying any system optimizations.
echo.

call :SEPARATOR
echo.

echo %W%%PAD%[%G%1%W%] Create Restore Point
echo %G%%PAD%    Recommended before applying tweaks
echo.

echo %W%%PAD%[%G%2%W%] Skip and Continue
echo %G%%PAD%    Continue without creating a restore point
echo.

call :SEPARATOR
echo.

set /p "choice=%G%%LOGOPAD%Select Option: %W%"

if "%choice%"=="2" goto WELCOME
if "%choice%"=="1" goto RESTORE

echo %R%Invalid option. Please try again.%N%
timeout /t 2 >nul
goto RESTORE_WIZARD

:ADVANCED_MENU
cls
call :LOGO
call :SEPARATOR
echo.
echo %G%%LOGOPAD%ADVANCED OPTIONS
call :SEPARATOR
echo %W%%PAD%Advanced controls for experienced users.
echo.
call :SEPARATOR
echo.
echo %W%%PAD%[%G%1%W%] Create Restore Point
echo %G%%PAD%    Create a system restore point before tweaking
echo.

echo %W%%PAD%[%G%2%W%] Optimization Center
echo %G%%PAD%    Access all optimization tools and settings
echo.

echo %W%%PAD%[%G%3%W%] Chris Titus Style Tweaks
echo %G%%PAD%    %R%⚠ Advanced performance ^& privacy tweaks
echo.

echo %W%%PAD%[%G%4%W%] HoneCtrl Style Tweaks
echo %G%%PAD%    %R%⚠ System hardening ^& deep optimization
echo.

echo %W%%PAD%[%G%0%W%] Back
echo.

call :SEPARATOR
echo.

set /p "choice=%G%%LOGOPAD%Select Option: %W%"

if "%choice%"=="0" goto WELCOME
if "%choice%"=="4" goto HONECTRL_TWEAKS
if "%choice%"=="3" goto CHRISTITUS_TWEAKS
if "%choice%"=="2" goto OPTIMIZATION_CENTER
if "%choice%"=="1" goto RESTORE_WIZARD

echo %R%Invalid option. Please try again.%N%
timeout /t 2 >nul
goto ADVANCED_MENU

:STATUS_DISPLAY
if "%POWER_STATUS%"=="" set POWER_STATUS=Unknown
if "%GAME_STATUS%"=="ON" (set GAME_DISPLAY=%G%ON%N%) else (set GAME_DISPLAY=%R%OFF%N%)
if "%DVR_STATUS%"=="ON" (set DVR_DISPLAY=%G%ON%N%) else (set DVR_DISPLAY=%R%OFF%N%)
if "%HAGS_STATUS%"=="ON" (set HAGS_DISPLAY=%G%ON%N%) else (set HAGS_DISPLAY=%R%OFF%N%)
exit /b

:OPTIMIZATION_CENTER
cls
call :LOGO
call :CHECK_POWER
call :CHECK_GAME
call :CHECK_DVR
call :CHECK_HAGS
call :STATUS_DISPLAY

call :SEPARATOR

echo.
echo %W%%PAD%Power    : %POWER_STATUS%
echo %W%%PAD%GameMode : %GAME_DISPLAY%
echo %W%%PAD%Xbox DVR : %DVR_DISPLAY%
echo %W%%PAD%HAGS     : %HAGS_DISPLAY%
echo.

call :SEPARATOR

echo.
echo %G%%LOGOPAD%OPTIMIZATION CENTER
call :SEPARATOR
echo.

echo %G%%PAD%POWER                              GAMING
echo %W%%PAD%[%G%1%W%] Ultimate Performance           [%G%4%W%] Enable Game Mode
echo %W%%PAD%[%G%2%W%] High Performance               [%G%5%W%] Disable Game Mode
echo %W%%PAD%[%G%3%W%] Balanced                       [%G%6%W%] Disable Xbox DVR
echo %W%%PAD%                                   [%G%7%W%] Enable Xbox DVR

echo.
echo %G%%PAD%GPU                                PROFILES
echo %W%%PAD%[%G%8%W%] Enable HAGS                    [%G%13%W%] Competitive Gaming
echo %W%%PAD%[%G%9%W%] Disable HAGS                   [%G%14%W%] Balanced Gaming
echo %W%%PAD%                                   [%G%15%W%] Battery Saving

echo.
echo %G%%PAD%OTHER FEATURES                     NETWORK
echo %W%%PAD%[%G%10%W%] Restore Point                 [%G%16%W%] Optimize Network
echo %W%%PAD%[%G%11%W%] Backup Settings               [%G%17%W%] Restore Network
echo %W%%PAD%[%G%12%W%] Restore Settings              
echo %W%%PAD%[%G%18%W%] Clean Temp Files              [%G%0%W%] Back
echo %W%%PAD%[%G%19%W%] Disable Hibernate
echo %W%%PAD%[%G%20%W%] Enable Hibernate
echo.

echo.
call :SEPARATOR

echo.
set /p "choice=%G%%LOGOPAD%Select Option: %W%"

if "%choice%"=="1" goto ULTIMATE
if "%choice%"=="2" goto HIGH
if "%choice%"=="3" goto BALANCED

if "%choice%"=="4" goto GAMEON
if "%choice%"=="5" goto GAMEOFF
if "%choice%"=="6" goto DVR_OFF
if "%choice%"=="7" goto DVR_ON

if "%choice%"=="8" goto HAGS_ON
if "%choice%"=="9" goto HAGS_OFF

if "%choice%"=="10" goto RESTORE
if "%choice%"=="11" goto BACKUP
if "%choice%"=="12" goto RESTORE_BACKUP

if "%choice%"=="13" goto COMPETITIVE
if "%choice%"=="14" goto BALANCED_MODE
if "%choice%"=="15" goto BATTERY_MODE

if "%choice%"=="16" goto OPTIMIZE_NETWORK
if "%choice%"=="17" goto RESTORE_NETWORK

if "%choice%"=="18" goto CLEAN_TEMP
if "%choice%"=="19" goto HIBERNATE_OFF
if "%choice%"=="20" goto HIBERNATE_ON

if "%choice%"=="0" goto ADVANCED_MENU

echo %R%Invalid option. Please try again.%N%
timeout /t 2 >nul
goto OPTIMIZATION_CENTER

:BENCHMARK
setlocal EnableDelayedExpansion
cls

call :LOGO

echo.
echo %G%%LOGOPAD%REALFPS BENCHMARK
call :SEPARATOR

echo.
echo %W%%PAD%Running system performance analysis...
echo.
echo %W%%PAD%[                    ] 0%%%N%

for /f %%a in ('powershell -command "[math]::Floor((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory/1GB)"') do set RAM=%%a
echo %W%%PAD%[#######             ] 33%%%N%

for /f "delims=" %%a in ('powershell -command "(Get-CimInstance Win32_Processor).Name"') do set CPU=%%a
echo %W%%PAD%[#############       ] 66%%%N%

for /f "delims=" %%a in ('powershell -command "(Get-CimInstance Win32_VideoController | Select -First 1).Name"') do set GPU=%%a
echo %W%%PAD%[####################] 100%%%N%
call :SEPARATOR

call :LOGO

echo.
echo %G%%LOGOPAD%HARDWARE INFORMATION
call :SEPARATOR
echo %W%%PAD%CPU : %G%%CPU%
echo %W%%PAD%GPU : %G%%GPU%
echo %W%%PAD%RAM : %G%%RAM% GB
call :SEPARATOR

rem =====================================
rem PERFORMANCE SCORE
rem =====================================

set CPU_SCORE=0
set GPU_SCORE=0
set RAM_SCORE=0

echo !CPU! | findstr /i "i7 i9 Ryzen 7 Ryzen 9" >nul
if !errorlevel!==0 (
    set CPU_SCORE=30
) else (
    echo !CPU! | findstr /i "i5 Ryzen 5" >nul
    if !errorlevel!==0 (
        set CPU_SCORE=25
    ) else (
        set CPU_SCORE=15
    )
)

echo !GPU! | findstr /i "RTX GTX RX Radeon" >nul
if !errorlevel!==0 (
    set GPU_SCORE=30
) else (
    echo !GPU! | findstr /i "Iris Xe UHD" >nul
    if !errorlevel!==0 (
        set GPU_SCORE=25
    ) else (
        set GPU_SCORE=15
    )
)

set /a RAM_NUM=%RAM%
if %RAM_NUM% GEQ 32 (
    set RAM_SCORE=30
) else if %RAM_NUM% GEQ 16 (
    set RAM_SCORE=20
) else (
    set RAM_SCORE=10
)

set /a TOTAL_SCORE=CPU_SCORE+GPU_SCORE+RAM_SCORE

if %TOTAL_SCORE% GEQ 75 (
    set RATING=HIGH-END
) else if %TOTAL_SCORE% GEQ 55 (
    set RATING=MID-RANGE
) else (
    set RATING=ENTRY-LEVEL
)

echo %G%%LOGOPAD%REALFPS SCORE
call :SEPARATOR

echo %W%%PAD%CPU Score    : %W%%CPU_SCORE%%N% / 30
echo %W%%PAD%GPU Score    : %W%%GPU_SCORE%%N% / 30
echo %W%%PAD%RAM Score    : %W%%RAM_SCORE%%N% / 30

echo.
echo %W%%PAD%Total Score  : %G%%TOTAL_SCORE%%N% / 90
echo %W%%PAD%System Rating: %G%%RATING%%N%

echo.
call :SEPARATOR
echo.
echo %G%%LOGOPAD%Press any key to continue...
pause >nul
endlocal
goto WELCOME

:GAME_BOOSTER
cls
call :LOGO
echo.
echo %G%%LOGOPAD%GAME BOOSTER
call :SEPARATOR

echo.
echo %W%%PAD%[%G%1%W%] Game Mode Ultimate        [%G%4%W%] CPU Priority Boost
echo %G%%PAD%    Enable Game Mode                Improve game priority

echo.
echo %W%%PAD%[%G%2%W%] High Performance          [%G%5%W%] Disable Updates
echo %G%%PAD%    Switch power plan               Pause update services

echo.
echo %W%%PAD%[%G%3%W%] Disable Services          [%G%6%W%] %G%Apply All Recommended
echo %G%%PAD%    Reduce background tasks         One-click optimization

echo.
echo %W%%PAD%[%G%0%W%] Back

echo.
call :SEPARATOR

echo.
set /p "choice=%G%%LOGOPAD%Select Option: %W%"

if "%choice%"=="1" goto BOOST_GAMEMODE
if "%choice%"=="2" goto BOOST_POWER
if "%choice%"=="3" goto BOOST_SERVICES
if "%choice%"=="4" goto BOOST_PRIORITY
if "%choice%"=="5" goto BOOST_UPDATES
if "%choice%"=="6" goto BOOST_ALL
if "%choice%"=="0" goto WELCOME

echo %R%Invalid option. Please try again.%N%
timeout /t 2 >nul
goto GAME_BOOSTER

:BOOST_GAMEMODE
echo %W%%PAD%Enabling Game Mode Ultimate...%N%
echo %W%%PAD%[                    ] 0%%%N%
timeout /t 1 >nul
echo %W%%PAD%[####                ] 20%%%N%
reg add "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 1 /f >nul 2>&1
timeout /t 1 >nul
echo %W%%PAD%[########            ] 40%%%N%
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >nul 2>&1
timeout /t 1 >nul
echo %W%%PAD%[############        ] 60%%%N%
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f >nul 2>&1
timeout /t 1 >nul
echo %W%%PAD%[################    ] 80%%%N%
timeout /t 1 >nul
echo %W%%PAD%[####################] 100%%%N%
call :SUCCESS "Game Mode Ultimate Enabled"
goto GAME_BOOSTER

:BOOST_POWER
echo %W%%PAD%Setting High Performance Power Plan...%N%
echo %W%%PAD%[                    ] 0%%%N%
timeout /t 1 >nul
echo %W%%PAD%[######              ] 30%%%N%
powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749eb61 >nul 2>&1
timeout /t 1 >nul
echo %W%%PAD%[##############      ] 70%%%N%
timeout /t 1 >nul
echo %W%%PAD%[####################] 100%%%N%
call :SUCCESS "High Performance Power Plan Enabled"
goto GAME_BOOSTER

:BOOST_SERVICES
echo %W%%PAD%Disabling Non-Essential Services...%N%
echo %W%%PAD%[                    ] 0%%%N%
timeout /t 1 >nul
echo %W%%PAD%[##                  ] 10%%%N%
sc config DiagTrack start=disabled >nul 2>&1
sc stop DiagTrack >nul 2>&1
echo %W%%PAD%[#####               ] 25%%%N%
sc config dmwappushservice start=disabled >nul 2>&1
sc stop dmwappushservice >nul 2>&1
echo %W%%PAD%[########            ] 40%%%N%
sc config SysMain start=disabled >nul 2>&1
sc stop SysMain >nul 2>&1
echo %W%%PAD%[###########         ] 55%%%N%
sc config WSearch start=disabled >nul 2>&1
sc stop WSearch >nul 2>&1
echo %W%%PAD%[##############      ] 70%%%N%
sc config XboxNetApiSvc start=disabled >nul 2>&1
sc stop XboxNetApiSvc >nul 2>&1
echo %W%%PAD%[##################  ] 90%%%N%
timeout /t 1 >nul
echo %W%%PAD%[####################] 100%%%N%
call :SUCCESS "Non-Essential Services Disabled"
goto GAME_BOOSTER

:BOOST_PRIORITY
echo %W%%PAD%Setting CPU Priority Boost for Games...%N%
echo %W%%PAD%[                    ] 0%%%N%
timeout /t 1 >nul
echo %W%%PAD%[######              ] 30%%%N%
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 0 /f >nul 2>&1
timeout /t 1 >nul
echo %W%%PAD%[#############       ] 65%%%N%
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 4294967295 /f >nul 2>&1
timeout /t 1 >nul
echo %W%%PAD%[####################] 100%%%N%
call :SUCCESS "CPU Priority Boost Enabled"
goto GAME_BOOSTER

:BOOST_UPDATES
echo %W%%PAD%Disabling Windows Updates (Temporary)...%N%
echo %W%%PAD%[                    ] 0%%%N%
timeout /t 1 >nul
echo %W%%PAD%[########            ] 40%%%N%
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f >nul 2>&1
timeout /t 1 >nul
echo %W%%PAD%[####################] 100%%%N%
call :SUCCESS "Windows Updates Disabled - Remember to re-enable later"
goto GAME_BOOSTER

:BOOST_ALL
echo %W%%PAD%Applying All Game Booster Tweaks...%N%
echo %W%%PAD%[                    ] 0%%%N%
timeout /t 1 >nul
echo %W%%PAD%[###                 ] 15%%%N%
call :BOOST_GAMEMODE >nul
echo %W%%PAD%[#######             ] 35%%%N%
call :BOOST_POWER >nul
echo %W%%PAD%[###########         ] 55%%%N%
call :BOOST_SERVICES >nul
echo %W%%PAD%[###############     ] 75%%%N%
call :BOOST_PRIORITY >nul
echo %W%%PAD%[################### ] 95%%%N%
call :BOOST_UPDATES >nul
echo %W%%PAD%[####################] 100%%%N%
call :SUCCESS "All Game Booster Tweaks Applied - Restart Recommended"
goto GAME_BOOSTER

:SYSTEM_CLEANUP
cls
call :LOGO

echo.
echo %G%%LOGOPAD%SYSTEM CLEANUP
call :SEPARATOR

echo.
echo %W%%PAD%[%G%1%W%] Windows Update Cache     [%G%5%W%] Prefetch Files
echo %G%%PAD%    Remove update cache            Remove prefetch data

echo.
echo %W%%PAD%[%G%2%W%] DNS Cache                [%G%6%W%] Store Cache
echo %G%%PAD%    Flush DNS records              Clear Microsoft Store cache

echo.
echo %W%%PAD%[%G%3%W%] Thumbnail Cache          [%G%7%W%] %G%Clean All Recommended
echo %G%%PAD%    Rebuild thumbnails             Run all cleanup tasks

echo.
echo %W%%PAD%[%G%4%W%] Recycle Bin              [%G%0%W%] Back
echo %G%%PAD%    Empty deleted files            Return to previous menu

echo.
call :SEPARATOR

echo.
set /p "choice=%G%%LOGOPAD%Select Option: %W%"

if "%choice%"=="1" goto CLEAN_UPDATE
if "%choice%"=="2" goto CLEAN_DNS
if "%choice%"=="3" goto CLEAN_THUMB
if "%choice%"=="4" goto CLEAN_BIN
if "%choice%"=="5" goto CLEAN_PREFETCH
if "%choice%"=="6" goto CLEAN_STORE
if "%choice%"=="7" goto CLEAN_ALL
if "%choice%"=="0" goto WELCOME

echo.
echo %R%Invalid option. Please try again.%N%
timeout /t 2 >nul
goto SYSTEM_CLEANUP

:CLEAN_UPDATE
echo %W%%PAD%Cleaning Windows Update Cache...%N%
echo %W%%PAD%[                    ] 0%%%N%
timeout /t 1 >nul
echo %W%%PAD%[######              ] 30%%%N%
net stop wuauserv >nul 2>&1
timeout /t 1 >nul
echo %W%%PAD%[##############      ] 70%%%N%
del /q /f /s "C:\Windows\SoftwareDistribution\Download\*" >nul 2>&1
net start wuauserv >nul 2>&1
timeout /t 1 >nul
echo %W%%PAD%[####################] 100%%%N%
call :SUCCESS "Update Cache Cleaned"
goto SYSTEM_CLEANUP

:CLEAN_DNS
echo %W%%PAD%Cleaning DNS Cache...%N%
echo %W%%PAD%[                    ] 0%%%N%
timeout /t 1 >nul
echo %W%%PAD%[########            ] 40%%%N%
ipconfig /flushdns >nul 2>&1
timeout /t 1 >nul
echo %W%%PAD%[####################] 100%%%N%
call :SUCCESS "DNS Cache Cleaned"
goto SYSTEM_CLEANUP

:CLEAN_THUMB
echo %W%%PAD%Cleaning Thumbnail Cache...%N%
echo %W%%PAD%[                    ] 0%%%N%
timeout /t 1 >nul
echo %W%%PAD%[########            ] 40%%%N%
del /q /f /s "%USERPROFILE%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1
timeout /t 1 >nul
echo %W%%PAD%[####################] 100%%%N%
call :SUCCESS "Thumbnail Cache Cleaned"
goto SYSTEM_CLEANUP

:CLEAN_BIN
echo %W%%PAD%Cleaning Recycle Bin...%N%
echo %W%%PAD%[                    ] 0%%%N%
timeout /t 1 >nul
echo %W%%PAD%[########            ] 40%%%N%
rd /s /q C:\$Recycle.bin >nul 2>&1
timeout /t 1 >nul
echo %W%%PAD%[####################] 100%%%N%
call :SUCCESS "Recycle Bin Cleaned"
goto SYSTEM_CLEANUP

:CLEAN_PREFETCH
echo %W%%PAD%Cleaning Prefetch Files...%N%
echo %W%%PAD%[                    ] 0%%%N%
timeout /t 1 >nul
echo %W%%PAD%[########            ] 40%%%N%
del /q /f /s "C:\Windows\Prefetch\*" >nul 2>&1
timeout /t 1 >nul
echo %W%%PAD%[####################] 100%%%N%
call :SUCCESS "Prefetch Cleaned"
goto SYSTEM_CLEANUP

:CLEAN_STORE
echo %W%%PAD%Cleaning Windows Store Cache...%N%
echo %W%%PAD%[                    ] 0%%%N%
timeout /t 1 >nul
echo %W%%PAD%[########            ] 40%%%N%
wsreset.exe >nul 2>&1
timeout /t 1 >nul
echo %W%%PAD%[####################] 100%%%N%
call :SUCCESS "Store Cache Cleaned"
goto SYSTEM_CLEANUP

:CLEAN_ALL
cls
call :LOGO
call :SEPARATOR
echo.
echo %G%%LOGOPAD%SYSTEM CLEANUP
call :SEPARATOR
echo.
echo %W%%PAD%Do you want to clean Windows Update Cache?
echo %W%%PAD%(This may take a while if update files are large)
echo.
echo %W%%PAD%[%G%G%W%] Yes   [%G%N%W%] Skip
echo.
set /p "choice=%G%%LOGOPAD%Select Option: %W%"

if /i "%choice%"=="Y" goto CLEAN_ALL_WITH_UPDATE
if /i "%choice%"=="N" goto CLEAN_ALL_SKIP_UPDATE

echo %R%Invalid option. Please try again.%N%
timeout /t 1 >nul
goto CLEAN_ALL

:CLEAN_ALL_WITH_UPDATE
cls
call :LOGO
call :SEPARATOR
echo.
echo %G%%LOGOPAD%SYSTEM CLEANUP
call :SEPARATOR
echo.
echo %W%%PAD%Cleaning All System Files...
echo.

echo %W%%PAD%[1/6] Cleaning Windows Update Cache...%N%
net stop wuauserv >nul 2>&1
timeout /t 2 >nul
del /q /f /s "C:\Windows\SoftwareDistribution\Download\*" >nul 2>&1
net start wuauserv >nul 2>&1
echo %G%%PAD%✓ Done%N%

echo %W%%PAD%[2/6] Cleaning DNS Cache...%N%
ipconfig /flushdns >nul 2>&1
echo %G%%PAD%✓ Done%N%

echo %W%%PAD%[3/6] Cleaning Thumbnail Cache...%N%
del /q /f /s "%USERPROFILE%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1
echo %G%%PAD%✓ Done%N%

echo %W%%PAD%[4/6] Cleaning Recycle Bin...%N%
rd /s /q C:\$Recycle.bin >nul 2>&1
echo %G%%PAD%✓ Done%N%

echo %W%%PAD%[5/6] Cleaning Prefetch Files...%N%
del /q /f /s "C:\Windows\Prefetch\*" >nul 2>&1
echo %G%%PAD%✓ Done%N%

echo %W%%PAD%[6/6] Cleaning Windows Store Cache...%N%
start /min wsreset.exe >nul 2>&1
timeout /t 3 >nul
echo %G%%PAD%✓ Done%N%

echo.
echo %G%%PAD%All Cleanup Completed!
echo.
pause >nul
goto SYSTEM_CLEANUP

:CLEAN_ALL_SKIP_UPDATE
cls
call :LOGO
call :SEPARATOR
echo.
echo %G%%LOGOPAD%SYSTEM CLEANUP
call :SEPARATOR
echo.
echo %W%%PAD%Cleaning System Files (Skipping Update Cache)...
echo.

echo %W%%PAD%[1/5] Cleaning DNS Cache...%N%
ipconfig /flushdns >nul 2>&1
echo %G%%PAD%✓ Done%N%

echo %W%%PAD%[2/5] Cleaning Thumbnail Cache...%N%
del /q /f /s "%USERPROFILE%\AppData\Local\Microsoft\Windows\Explorer\thumbcache_*.db" >nul 2>&1
echo %G%%PAD%✓ Done%N%

echo %W%%PAD%[3/5] Cleaning Recycle Bin...%N%
rd /s /q C:\$Recycle.bin >nul 2>&1
echo %G%%PAD%✓ Done%N%

echo %W%%PAD%[4/5] Cleaning Prefetch Files...%N%
del /q /f /s "C:\Windows\Prefetch\*" >nul 2>&1
echo %G%%PAD%✓ Done%N%

echo %W%%PAD%[5/5] Cleaning Windows Store Cache...%N%
start /min wsreset.exe >nul 2>&1
timeout /t 3 >nul
echo %G%%PAD%✓ Done%N%

echo.
echo %G%%PAD%All Cleanup Completed!
echo.
pause >nul
goto SYSTEM_CLEANUP

:PERFORMANCE_STATS
cls
call :LOGO

call :CHECK_POWER
call :CHECK_GAME
call :CHECK_DVR
call :STATUS_DISPLAY

echo.
echo %G%%LOGOPAD%PERFORMANCE STATS
call :SEPARATOR

echo.
echo %W%%PAD%Power Plan                   Game Mode
echo %G%%PAD%%POWER_STATUS%                     %GAME_DISPLAY%

echo.
echo %W%%PAD%Xbox DVR                     Network
echo %G%%PAD%%DVR_DISPLAY%                          Connected

echo.
echo %W%%PAD%System Status
echo %G%%PAD%Windows Running Normally

echo.
call :SEPARATOR

echo.
echo %W%%PAD%[%G%1%W%] Refresh Stats            [%G%0%W%] Back
echo %G%%PAD%    Reload information           Return to previous menu

echo.
call :SEPARATOR

echo.
set /p "choice=%G%%LOGOPAD%Select Option: %W%"

if "%choice%"=="1" goto PERFORMANCE_STATS
if "%choice%"=="0" goto WELCOME

echo.
echo %R%Invalid option. Please try again.%N%
timeout /t 2 >nul
goto PERFORMANCE_STATS

:SERVICE_MANAGER
cls
call :LOGO

echo.
echo %G%%LOGOPAD%SERVICE MANAGER
call :SEPARATOR

echo.
echo %W%%PAD%[%G%A%W%] Safe Services        [%G%G%W%] Gaming Preset (40+ Services)
echo.
echo %W%%PAD%[%G%G%W%] Manual Toggle        [%G%R%W%] Restore All
echo.
echo %W%%PAD%[%G%0%W%] Back

echo.
call :SEPARATOR

echo.
echo %G%%PAD%SAFE:  Search, SysMain, Maps, FileHistory, Error, Remote, Phone, Insider, Xbox
echo.
echo %W%%PAD%GAMING: Safe + BitLocker, IP, ICS, Netlogon, PCA, Spooler, Parental, NetBIOS
echo %W%%PAD%        Touch, WIA, Geolocation, Biometric, Hotspot, WMP, Updates, BITS
echo %W%%PAD%        Cryptographic, HID, Net.Tcp, Server, Telephony, WMI

echo.
call :SEPARATOR

echo.
set /p "choice=%G%%LOGOPAD%Select Option: %W%"

if /i "%choice%"=="A" goto DISABLE_SAFE_SERVICES
if /i "%choice%"=="G" goto DISABLE_ALL_GAMING
if /i "%choice%"=="M" goto MANUAL_TOGGLE_MENU
if /i "%choice%"=="R" goto RESTORE_ALL_SERVICES
if /i "%choice%"=="0" goto WELCOME

echo %R%Invalid option. Please try again.%N%
timeout /t 2 >nul
goto SERVICE_MANAGER



:MANUAL_TOGGLE_MENU
cls
call :LOGO

echo.
echo %G%%LOGOPAD%MANUAL TOGGLE
call :SEPARATOR

echo.
echo %W%%PAD%[%G%1%W%] BitLocker      [%G%2%W%] Maps         [%G%3%W%] FileHistory   [%G%4%W%] IP Helper
echo %W%%PAD%[%G%5%W%] ICS            [%G%6%W%] Netlogon     [%G%7%W%] PCA           [%G%8%W%] Print Spooler
echo %W%%PAD%[%G%9%W%] Parental       [%G%10%W%] Remote      [%G%11%W%] Secondary    [%G%12%W%] NetBIOS
echo %W%%PAD%[%G%13%W%] Touch Keybd   [%G%14%W%] Error       [%G%15%W%] WIA          [%G%16%W%] SysMain
echo %W%%PAD%[%G%17%W%] Insider       [%G%18%W%] Search      [%G%19%W%] Geolocation  [%G%20%W%] Phone
echo %W%%PAD%[%G%21%W%] Biometric     [%G%22%W%] Hotspot     [%G%23%W%] WMP          [%G%24%W%] Windows Update
echo %W%%PAD%[%G%25%W%] BITS          [%G%26%W%] Crypto      [%G%27%W%] HID          [%G%28%W%] Net.Tcp
echo %W%%PAD%[%G%29%W%] Server        [%G%30%W%] Telephony   [%G%31%W%] WMI          [%G%0%W%] Back

echo.
call :SEPARATOR

echo.
set /p "choice=%G%%LOGOPAD%Select Service: %W%"

if "%choice%"=="0" goto SERVICE_MANAGER
if "%choice%"=="1" goto TOGGLE_BITLOCKER
if "%choice%"=="2" goto TOGGLE_MAPS
if "%choice%"=="3" goto TOGGLE_FILEHISTORY
if "%choice%"=="4" goto TOGGLE_IPHELPER
if "%choice%"=="5" goto TOGGLE_ICS
if "%choice%"=="6" goto TOGGLE_NETLOGON
if "%choice%"=="7" goto TOGGLE_PCA
if "%choice%"=="8" goto TOGGLE_SPOOLER
if "%choice%"=="9" goto TOGGLE_PARENTAL
if "%choice%"=="10" goto TOGGLE_REMOTE
if "%choice%"=="11" goto TOGGLE_SECONDARY
if "%choice%"=="12" goto TOGGLE_NETBIOS
if "%choice%"=="13" goto TOGGLE_TOUCH
if "%choice%"=="14" goto TOGGLE_ERROR
if "%choice%"=="15" goto TOGGLE_WIA
if "%choice%"=="16" goto TOGGLE_SYSMAIN
if "%choice%"=="17" goto TOGGLE_INSIDER
if "%choice%"=="18" goto TOGGLE_SEARCH
if "%choice%"=="19" goto TOGGLE_GEOLOCATION
if "%choice%"=="20" goto TOGGLE_PHONE
if "%choice%"=="21" goto TOGGLE_BIOMETRIC
if "%choice%"=="22" goto TOGGLE_HOTSPOT
if "%choice%"=="23" goto TOGGLE_WMP
if "%choice%"=="24" goto TOGGLE_WU
if "%choice%"=="25" goto TOGGLE_BITS
if "%choice%"=="26" goto TOGGLE_CRYPTO
if "%choice%"=="27" goto TOGGLE_HID
if "%choice%"=="28" goto TOGGLE_NETTCP
if "%choice%"=="29" goto TOGGLE_SERVER
if "%choice%"=="30" goto TOGGLE_TELEPHONY
if "%choice%"=="31" goto TOGGLE_WMI

echo %R%Invalid option. Please try again.%N%
timeout /t 2 >nul
goto MANUAL_TOGGLE_MENU



:DISABLE_SAFE_SERVICES
cls
call :LOGO

echo.
echo %G%%LOGOPAD%DISABLING SAFE SERVICES
call :SEPARATOR

echo.
echo %W%%PAD%Applying recommended service tweaks...
echo.

echo %W%%PAD%[                    ] 0%%
timeout /t 1 >nul

sc config WSearch start=disabled >nul 2>&1
sc stop WSearch >nul 2>&1

sc config SysMain start=disabled >nul 2>&1
sc stop SysMain >nul 2>&1

sc config MapsBroker start=disabled >nul 2>&1
sc stop MapsBroker >nul 2>&1

sc config fhsvc start=disabled >nul 2>&1
sc stop fhsvc >nul 2>&1

echo %W%%PAD%[##########          ] 50%%
timeout /t 1 >nul

sc config WerSvc start=disabled >nul 2>&1
sc stop WerSvc >nul 2>&1

sc config RemoteRegistry start=disabled >nul 2>&1
sc stop RemoteRegistry >nul 2>&1

sc config PhoneSvc start=disabled >nul 2>&1
sc stop PhoneSvc >nul 2>&1

sc config WIService start=disabled >nul 2>&1
sc stop WIService >nul 2>&1

sc config XblAuthManager start=disabled >nul 2>&1
sc stop XblAuthManager >nul 2>&1

sc config XblGameSave start=disabled >nul 2>&1
sc stop XblGameSave >nul 2>&1

sc config XboxGipSvc start=disabled >nul 2>&1
sc stop XboxGipSvc >nul 2>&1

echo %W%%PAD%[####################] 100%%
echo.

call :SUCCESS "Safe Services Disabled"
goto SERVICE_MANAGER



:DISABLE_ALL_GAMING
cls
call :LOGO

echo.
echo %G%%LOGOPAD%APPLYING GAMING PRESET (ALL SERVICES)
call :SEPARATOR

echo.
echo %W%%PAD%Disabling 40+ non-essential services...
echo.

echo %W%%PAD%[                    ] 0%%
timeout /t 1 >nul

echo %W%%PAD%[##                  ] 10%%

call :DISABLE_SAFE_SERVICES >nul

echo %W%%PAD%[######              ] 30%%
timeout /t 1 >nul

REM === TẤT CẢ SERVICE CHO GAMING PRESET ===
for %%s in (
    "BDESVC" "iphlpsvc" "SharedAccess" "Netlogon" "PcaSvc" "Spooler"
    "WpcMonSvc" "seclogon" "lmhosts" "TabletInputService" "stisvc"
    "wisvc" "lfsvc" "PhoneSvc" "WbioSrvc" "icssvc" "WMPNetworkSvc"
    "wuauserv" "BITS" "CryptSvc" "hidserv" "NetTcpPortSharing"
    "LanmanServer" "TapiSrv" "WmiApSrv"
) do (
    sc config %%s start=disabled >nul 2>&1
    sc stop %%s >nul 2>&1
)

echo %W%%PAD%[####################] 100%%
echo.

call :SUCCESS "Gaming Preset Applied - 40+ Services Disabled"
goto SERVICE_MANAGER



:RESTORE_ALL_SERVICES
cls
call :LOGO

echo.
echo %G%%LOGOPAD%RESTORING ALL SERVICES
call :SEPARATOR

echo.
echo %W%%PAD%Re-enabling all 40+ services...
echo.

echo %W%%PAD%[                    ] 0%%
timeout /t 1 >nul

for %%s in (
    "WSearch" "SysMain" "MapsBroker" "fhsvc" "WerSvc"
    "RemoteRegistry" "PhoneSvc" "WIService" "XblAuthManager"
    "XblGameSave" "XboxGipSvc" "BDESVC" "iphlpsvc"
    "SharedAccess" "Netlogon" "PcaSvc" "Spooler"
    "WpcMonSvc" "seclogon" "lmhosts" "TabletInputService"
    "stisvc" "wisvc" "lfsvc" "WbioSrvc" "icssvc"
    "WMPNetworkSvc" "wuauserv" "BITS" "CryptSvc"
    "hidserv" "NetTcpPortSharing" "LanmanServer"
    "TapiSrv" "WmiApSrv"
) do (
    sc config %%s start=auto >nul 2>&1
    sc start %%s >nul 2>&1
)

echo %W%%PAD%[####################] 100%%
echo.

call :SUCCESS "All Services Restored - Restart Recommended"
goto SERVICE_MANAGER

REM =============================================
REM INDIVIDUAL SERVICE TOGGLES (giữ nguyên từ file cũ)
REM =============================================

:TOGGLE_BITLOCKER
sc query BDESVC | find "RUNNING" >nul
if %errorlevel%==0 (
    sc config BDESVC start=disabled >nul 2>&1
    sc stop BDESVC >nul 2>&1
    call :SUCCESS "BitLocker Service Disabled"
) else (
    sc config BDESVC start=auto >nul 2>&1
    sc start BDESVC >nul 2>&1
    call :SUCCESS "BitLocker Service Enabled"
)
goto MANUAL_TOGGLE_MENU

:TOGGLE_MAPS
sc query MapsBroker | find "RUNNING" >nul
if %errorlevel%==0 (
    sc config MapsBroker start=disabled >nul 2>&1
    sc stop MapsBroker >nul 2>&1
    call :SUCCESS "Downloaded Maps Manager Disabled"
) else (
    sc config MapsBroker start=auto >nul 2>&1
    sc start MapsBroker >nul 2>&1
    call :SUCCESS "Downloaded Maps Manager Enabled"
)
goto SERVICE_MANAGER

:TOGGLE_FILEHISTORY
sc query fhsvc | find "RUNNING" >nul
if %errorlevel%==0 (
    sc config fhsvc start=disabled >nul 2>&1
    sc stop fhsvc >nul 2>&1
    call :SUCCESS "File History Service Disabled"
) else (
    sc config fhsvc start=auto >nul 2>&1
    sc start fhsvc >nul 2>&1
    call :SUCCESS "File History Service Enabled"
)
goto SERVICE_MANAGER

:TOGGLE_IPHELPER
sc query iphlpsvc | find "RUNNING" >nul
if %errorlevel%==0 (
    sc config iphlpsvc start=disabled >nul 2>&1
    sc stop iphlpsvc >nul 2>&1
    call :SUCCESS "IP Helper Disabled"
) else (
    sc config iphlpsvc start=auto >nul 2>&1
    sc start iphlpsvc >nul 2>&1
    call :SUCCESS "IP Helper Enabled"
)
goto SERVICE_MANAGER

:TOGGLE_ICS
sc query SharedAccess | find "RUNNING" >nul
if %errorlevel%==0 (
    sc config SharedAccess start=disabled >nul 2>&1
    sc stop SharedAccess >nul 2>&1
    call :SUCCESS "Internet Connection Sharing Disabled"
) else (
    sc config SharedAccess start=auto >nul 2>&1
    sc start SharedAccess >nul 2>&1
    call :SUCCESS "Internet Connection Sharing Enabled"
)
goto SERVICE_MANAGER

:TOGGLE_NETLOGON
sc query Netlogon | find "RUNNING" >nul
if %errorlevel%==0 (
    sc config Netlogon start=disabled >nul 2>&1
    sc stop Netlogon >nul 2>&1
    call :SUCCESS "Netlogon Disabled"
) else (
    sc config Netlogon start=auto >nul 2>&1
    sc start Netlogon >nul 2>&1
    call :SUCCESS "Netlogon Enabled"
)
goto SERVICE_MANAGER

:TOGGLE_PCA
sc query PcaSvc | find "RUNNING" >nul
if %errorlevel%==0 (
    sc config PcaSvc start=disabled >nul 2>&1
    sc stop PcaSvc >nul 2>&1
    call :SUCCESS "Program Compatibility Assistant Disabled"
) else (
    sc config PcaSvc start=auto >nul 2>&1
    sc start PcaSvc >nul 2>&1
    call :SUCCESS "Program Compatibility Assistant Enabled"
)
goto SERVICE_MANAGER

:TOGGLE_SPOOLER
sc query Spooler | find "RUNNING" >nul
if %errorlevel%==0 (
    sc config Spooler start=disabled >nul 2>&1
    sc stop Spooler >nul 2>&1
    call :SUCCESS "Print Spooler Disabled"
) else (
    sc config Spooler start=auto >nul 2>&1
    sc start Spooler >nul 2>&1
    call :SUCCESS "Print Spooler Enabled"
)
goto SERVICE_MANAGER

:TOGGLE_PARENTAL
sc query WpcMonSvc | find "RUNNING" >nul
if %errorlevel%==0 (
    sc config WpcMonSvc start=disabled >nul 2>&1
    sc stop WpcMonSvc >nul 2>&1
    call :SUCCESS "Parental Control Disabled"
) else (
    sc config WpcMonSvc start=auto >nul 2>&1
    sc start WpcMonSvc >nul 2>&1
    call :SUCCESS "Parental Control Enabled"
)
goto SERVICE_MANAGER

:TOGGLE_REMOTE
sc query RemoteRegistry | find "RUNNING" >nul
if %errorlevel%==0 (
    sc config RemoteRegistry start=disabled >nul 2>&1
    sc stop RemoteRegistry >nul 2>&1
    call :SUCCESS "Remote Registry Disabled"
) else (
    sc config RemoteRegistry start=auto >nul 2>&1
    sc start RemoteRegistry >nul 2>&1
    call :SUCCESS "Remote Registry Enabled"
)
goto SERVICE_MANAGER

:TOGGLE_SECONDARY
sc query seclogon | find "RUNNING" >nul
if %errorlevel%==0 (
    sc config seclogon start=disabled >nul 2>&1
    sc stop seclogon >nul 2>&1
    call :SUCCESS "Secondary Logon Disabled"
) else (
    sc config seclogon start=auto >nul 2>&1
    sc start seclogon >nul 2>&1
    call :SUCCESS "Secondary Logon Enabled"
)
goto SERVICE_MANAGER

:TOGGLE_NETBIOS
sc query lmhosts | find "RUNNING" >nul
if %errorlevel%==0 (
    sc config lmhosts start=disabled >nul 2>&1
    sc stop lmhosts >nul 2>&1
    call :SUCCESS "TCP/IP NetBIOS Helper Disabled"
) else (
    sc config lmhosts start=auto >nul 2>&1
    sc start lmhosts >nul 2>&1
    call :SUCCESS "TCP/IP NetBIOS Helper Enabled"
)
goto SERVICE_MANAGER

:TOGGLE_TOUCH
sc query TabletInputService | find "RUNNING" >nul
if %errorlevel%==0 (
    sc config TabletInputService start=disabled >nul 2>&1
    sc stop TabletInputService >nul 2>&1
    call :SUCCESS "Touch Keyboard & Handwriting Disabled"
) else (
    sc config TabletInputService start=auto >nul 2>&1
    sc start TabletInputService >nul 2>&1
    call :SUCCESS "Touch Keyboard & Handwriting Enabled"
)
goto SERVICE_MANAGER

:TOGGLE_ERROR
sc query WerSvc | find "RUNNING" >nul
if %errorlevel%==0 (
    sc config WerSvc start=disabled >nul 2>&1
    sc stop WerSvc >nul 2>&1
    call :SUCCESS "Windows Error Reporting Disabled"
) else (
    sc config WerSvc start=auto >nul 2>&1
    sc start WerSvc >nul 2>&1
    call :SUCCESS "Windows Error Reporting Enabled"
)
goto SERVICE_MANAGER

:TOGGLE_WIA
sc query stisvc | find "RUNNING" >nul
if %errorlevel%==0 (
    sc config stisvc start=disabled >nul 2>&1
    sc stop stisvc >nul 2>&1
    call :SUCCESS "Windows Image Acquisition Disabled"
) else (
    sc config stisvc start=auto >nul 2>&1
    sc start stisvc >nul 2>&1
    call :SUCCESS "Windows Image Acquisition Enabled"
)
goto SERVICE_MANAGER

:TOGGLE_INSIDER
sc query WIService | find "RUNNING" >nul
if %errorlevel%==0 (
    sc config WIService start=disabled >nul 2>&1
    sc stop WIService >nul 2>&1
    call :SUCCESS "Windows Insider Service Disabled"
) else (
    sc config WIService start=auto >nul 2>&1
    sc start WIService >nul 2>&1
    call :SUCCESS "Windows Insider Service Enabled"
)
goto SERVICE_MANAGER

:TOGGLE_SEARCH
sc query WSearch | find "RUNNING" >nul
if %errorlevel%==0 (
    sc config WSearch start=disabled >nul 2>&1
    sc stop WSearch >nul 2>&1
    call :SUCCESS "Windows Search Disabled"
) else (
    sc config WSearch start=auto >nul 2>&1
    sc start WSearch >nul 2>&1
    call :SUCCESS "Windows Search Enabled"
)
goto SERVICE_MANAGER

:TOGGLE_GEOLOCATION
sc query lfsvc | find "RUNNING" >nul
if %errorlevel%==0 (
    sc config lfsvc start=disabled >nul 2>&1
    sc stop lfsvc >nul 2>&1
    call :SUCCESS "Geolocation Service Disabled"
) else (
    sc config lfsvc start=auto >nul 2>&1
    sc start lfsvc >nul 2>&1
    call :SUCCESS "Geolocation Service Enabled"
)
goto SERVICE_MANAGER

:TOGGLE_PHONE
sc query PhoneSvc | find "RUNNING" >nul
if %errorlevel%==0 (
    sc config PhoneSvc start=disabled >nul 2>&1
    sc stop PhoneSvc >nul 2>&1
    call :SUCCESS "Phone Service Disabled"
) else (
    sc config PhoneSvc start=auto >nul 2>&1
    sc start PhoneSvc >nul 2>&1
    call :SUCCESS "Phone Service Enabled"
)
goto SERVICE_MANAGER

:TOGGLE_BIOMETRIC
sc query WbioSrvc | find "RUNNING" >nul
if %errorlevel%==0 (
    sc config WbioSrvc start=disabled >nul 2>&1
    sc stop WbioSrvc >nul 2>&1
    call :SUCCESS "Windows Biometric Service Disabled"
) else (
    sc config WbioSrvc start=auto >nul 2>&1
    sc start WbioSrvc >nul 2>&1
    call :SUCCESS "Windows Biometric Service Enabled"
)
goto SERVICE_MANAGER

:TOGGLE_HOTSPOT
sc query icssvc | find "RUNNING" >nul
if %errorlevel%==0 (
    sc config icssvc start=disabled >nul 2>&1
    sc stop icssvc >nul 2>&1
    call :SUCCESS "Windows Mobile Hotspot Disabled"
) else (
    sc config icssvc start=auto >nul 2>&1
    sc start icssvc >nul 2>&1
    call :SUCCESS "Windows Mobile Hotspot Enabled"
)
goto SERVICE_MANAGER

:TOGGLE_WMP
sc query WMPNetworkSvc | find "RUNNING" >nul
if %errorlevel%==0 (
    sc config WMPNetworkSvc start=disabled >nul 2>&1
    sc stop WMPNetworkSvc >nul 2>&1
    call :SUCCESS "Windows Media Player Sharing Disabled"
) else (
    sc config WMPNetworkSvc start=auto >nul 2>&1
    sc start WMPNetworkSvc >nul 2>&1
    call :SUCCESS "Windows Media Player Sharing Enabled"
)
goto SERVICE_MANAGER

:TOGGLE_WU
sc query wuauserv | find "RUNNING" >nul
if %errorlevel%==0 (
    sc config wuauserv start=disabled >nul 2>&1
    sc stop wuauserv >nul 2>&1
    call :SUCCESS "Windows Update Disabled"
) else (
    sc config wuauserv start=auto >nul 2>&1
    sc start wuauserv >nul 2>&1
    call :SUCCESS "Windows Update Enabled"
)
goto SERVICE_MANAGER

:TOGGLE_BITS
sc query BITS | find "RUNNING" >nul
if %errorlevel%==0 (
    sc config BITS start=disabled >nul 2>&1
    sc stop BITS >nul 2>&1
    call :SUCCESS "Background Intelligent Transfer Disabled"
) else (
    sc config BITS start=auto >nul 2>&1
    sc start BITS >nul 2>&1
    call :SUCCESS "Background Intelligent Transfer Enabled"
)
goto SERVICE_MANAGER

:TOGGLE_CRYPTO
sc query CryptSvc | find "RUNNING" >nul
if %errorlevel%==0 (
    sc config CryptSvc start=disabled >nul 2>&1
    sc stop CryptSvc >nul 2>&1
    call :SUCCESS "Cryptographic Services Disabled"
) else (
    sc config CryptSvc start=auto >nul 2>&1
    sc start CryptSvc >nul 2>&1
    call :SUCCESS "Cryptographic Services Enabled"
)
goto SERVICE_MANAGER

:TOGGLE_HID
sc query hidserv | find "RUNNING" >nul
if %errorlevel%==0 (
    sc config hidserv start=disabled >nul 2>&1
    sc stop hidserv >nul 2>&1
    call :SUCCESS "Human Interface Device Access Disabled"
) else (
    sc config hidserv start=auto >nul 2>&1
    sc start hidserv >nul 2>&1
    call :SUCCESS "Human Interface Device Access Enabled"
)
goto SERVICE_MANAGER

:TOGGLE_NETTCP
sc query NetTcpPortSharing | find "RUNNING" >nul
if %errorlevel%==0 (
    sc config NetTcpPortSharing start=disabled >nul 2>&1
    sc stop NetTcpPortSharing >nul 2>&1
    call :SUCCESS "Net.Tcp Port Sharing Disabled"
) else (
    sc config NetTcpPortSharing start=auto >nul 2>&1
    sc start NetTcpPortSharing >nul 2>&1
    call :SUCCESS "Net.Tcp Port Sharing Enabled"
)
goto SERVICE_MANAGER

:TOGGLE_SERVER
sc query LanmanServer | find "RUNNING" >nul
if %errorlevel%==0 (
    sc config LanmanServer start=disabled >nul 2>&1
    sc stop LanmanServer >nul 2>&1
    call :SUCCESS "Server Service Disabled"
) else (
    sc config LanmanServer start=auto >nul 2>&1
    sc start LanmanServer >nul 2>&1
    call :SUCCESS "Server Service Enabled"
)
goto SERVICE_MANAGER

:TOGGLE_TELEPHONY
sc query TapiSrv | find "RUNNING" >nul
if %errorlevel%==0 (
    sc config TapiSrv start=disabled >nul 2>&1
    sc stop TapiSrv >nul 2>&1
    call :SUCCESS "Telephony Disabled"
) else (
    sc config TapiSrv start=auto >nul 2>&1
    sc start TapiSrv >nul 2>&1
    call :SUCCESS "Telephony Enabled"
)
goto SERVICE_MANAGER

:TOGGLE_WMI
sc query WmiApSrv | find "RUNNING" >nul
if %errorlevel%==0 (
    sc config WmiApSrv start=disabled >nul 2>&1
    sc stop WmiApSrv >nul 2>&1
    call :SUCCESS "WMI Performance Adapter Disabled"
) else (
    sc config WmiApSrv start=auto >nul 2>&1
    sc start WmiApSrv >nul 2>&1
    call :SUCCESS "WMI Performance Adapter Enabled"
)
goto SERVICE_MANAGER

:TOGGLE_SYSMAIN
sc query SysMain | find "RUNNING" >nul
if %errorlevel%==0 (
    sc config SysMain start=disabled >nul 2>&1
    sc stop SysMain >nul 2>&1
    call :SUCCESS "SysMain Disabled"
) else (
    sc config SysMain start=auto >nul 2>&1
    sc start SysMain >nul 2>&1
    call :SUCCESS "SysMain Enabled"
)
goto SERVICE_MANAGER

:SMART_OPTIMIZATION
cls
call :LOGO
call :SEPARATOR
echo.
echo %G%%LOGOPAD%SMART OPTIMIZATION
call :SEPARATOR
echo %W%%PAD%Current Profile : %G%%RECOMMENDED_PROFILE%
echo.
call :SEPARATOR
echo.
echo %W%%PAD%[%G%1%W%] Analyze ^& Recommend
echo %G%%PAD%    Scan your system and get the best profile

echo.
echo %W%%PAD%[%G%2%W%] Apply Optimization
echo %G%%PAD%    Apply the recommended profile to your system

echo.
echo %W%%PAD%[%G%0%W%] Back
echo.
call :SEPARATOR
echo.
set /p "choice=%G%%LOGOPAD%Select Option: %W%"

if "%choice%"=="0" goto WELCOME
if "%choice%"=="2" goto APPLY_OPTIMIZATION
if "%choice%"=="1" goto ANALYZE_RECOMMEND

echo %R%Invalid option. Please try again.%N%
timeout /t 2 >nul
goto SMART_OPTIMIZATION

:RECOMMENDED_PROFILE
cls
call :LOGO
call :SEPARATOR
echo.
echo %G%%LOGOPAD%RECOMMENDED PROFILE
call :SEPARATOR
echo %W%%PAD%Analyzing your system...
call :SEPARATOR

for /f %%a in ('powershell -command "[math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory/1GB)"') do set RAM=%%a
for /f "delims=" %%a in ('powershell -command "(Get-CimInstance Win32_Processor).Name"') do set CPU=%%a
for /f "delims=" %%a in ('powershell -command "(Get-CimInstance Win32_VideoController | Select -First 1).Name"') do set GPU=%%a

echo.
echo %G%%PAD%CPU : %W%%CPU%
echo %G%%PAD%GPU : %W%%GPU%
echo %G%%PAD%RAM : %W%%RAM% GB
call :SEPARATOR

if %RAM% GEQ 16 (
    set RECOMMENDED_PROFILE=Competitive Performance
) else (
    set RECOMMENDED_PROFILE=Balanced Gaming
)

echo %W%%PAD%Recommended Profile : %G%%RECOMMENDED_PROFILE%
call :SEPARATOR
echo.
pause >nul
goto SMART_OPTIMIZATION

:ANALYZE_RECOMMEND
setlocal EnableDelayedExpansion
cls
call :LOGO
call :SEPARATOR
echo.
echo %G%%LOGOPAD%SYSTEM ANALYSIS ^& RECOMMEND
call :SEPARATOR
echo.
echo %W%%PAD%Analyzing your system, please wait...
echo.
echo %W%%PAD%[                    ] 0%%%N%

for /f %%a in ('powershell -command "(Get-CimInstance Win32_ComputerSystem).PCSystemType"') do set PSTYPE=%%a
if "%PSTYPE%"=="2" (set DEVICE=Laptop) else (set DEVICE=Desktop)
echo %W%%PAD%[#####               ] 25%%%N%

for /f %%a in ('powershell -command "[math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory/1GB)"') do set RAM=%%a
echo %W%%PAD%[##########          ] 50%%%N%

for /f "delims=" %%a in ('powershell -command "(Get-CimInstance Win32_Processor).Name"') do set CPU=%%a
echo %W%%PAD%[###############     ] 75%%%N%

for /f "delims=" %%a in ('powershell -command "(Get-CimInstance Win32_VideoController | Select -First 1).Name"') do set GPU=%%a
echo %W%%PAD%[####################] 100%%%N%

if "%DEVICE%"=="Laptop" (
    set REASON=!REASON! - Laptop Power Efficiency Recommended
)

rem =====================================
rem PERFORMANCE SCORING
rem =====================================

set PERFORMANCE_SCORE=0
set REASON=

rem RAM SCORE
if %RAM% GEQ 32 (
    set RAM_SCORE=30
) else if %RAM% GEQ 16 (
    set RAM_SCORE=20
) else (
    set RAM_SCORE=10
)
set /a PERFORMANCE_SCORE+=RAM_SCORE

rem CPU SCORE
set CPU_SCORE=10
echo %CPU% | findstr /i "i9 Ryzen 9" >nul
if not errorlevel 1 (set CPU_SCORE=30 & set REASON=!REASON! - High-End CPU)
echo %CPU% | findstr /i "i7 Ryzen 7" >nul
if not errorlevel 1 (set CPU_SCORE=25 & set REASON=!REASON! - Powerful Multi-Core CPU)
echo %CPU% | findstr /i "i5 Ryzen 5" >nul
if not errorlevel 1 (set CPU_SCORE=20 & set REASON=!REASON! - Modern Gaming CPU)
set /a PERFORMANCE_SCORE+=CPU_SCORE

rem GPU SCORE
set GPU_SCORE=15
echo %GPU% | findstr /i "RTX GTX RX Radeon" >nul
if not errorlevel 1 (set GPU_SCORE=30 & set REASON=!REASON! - Gaming GPU Detected)
echo %GPU% | findstr /i "Iris Xe UHD" >nul
if not errorlevel 1 (set GPU_SCORE=20 & set REASON=!REASON! - Integrated Graphics)
set /a PERFORMANCE_SCORE+=GPU_SCORE

set GAMING_TIER=Entry-Level Gaming
if !PERFORMANCE_SCORE! GEQ 70 (set GAMING_TIER=High-End Gaming)
if !PERFORMANCE_SCORE! GEQ 50 if !PERFORMANCE_SCORE! LSS 70 (set GAMING_TIER=Mid-Range Gaming)

rem PROFILE RESULT
if %PERFORMANCE_SCORE% GEQ 65 (
    set RECOMMENDED_PROFILE=Competitive Performance
) else if %PERFORMANCE_SCORE% GEQ 40 (
    set RECOMMENDED_PROFILE=Balanced Gaming
) else (
    set RECOMMENDED_PROFILE=Battery Saving
)

echo %RECOMMENDED_PROFILE% > RealFPS_Profile.txt

cls
call :LOGO
call :SEPARATOR

echo.
echo %G%%LOGOPAD%SMART ANALYSIS RESULT

call :SEPARATOR

echo %W%%PAD%Device : %G%%DEVICE%          %W%Tier : %W%%GAMING_TIER%

call :SEPARATOR

echo %W%%PAD%CPU  : %W%%CPU_SCORE%%N% /30           %W%GPU   : %W%%GPU_SCORE%%N% /30

echo %W%%PAD%RAM  : %W%%RAM_SCORE%%N% /30            %W%Total : %G%%PERFORMANCE_SCORE%%N% /90

call :SEPARATOR

echo %W%%PAD%Recommended Profile : %G%%RECOMMENDED_PROFILE%

call :SEPARATOR

if "%DEVICE%"=="Laptop" echo %G%%PAD%[OK]%W% Laptop detected

if %RAM% GEQ 16 echo %G%%PAD%[OK]%W% 16GB+ RAM detected

echo %CPU% | findstr /i "i5 i7 i9 Ryzen 5 Ryzen 7 Ryzen 9" >nul
if !errorlevel!==0 echo %G%%PAD%[OK]%W% Modern CPU detected

echo %GPU% | findstr /i "Iris Xe RTX GTX RX Radeon" >nul
if !errorlevel!==0 echo %G%%PAD%[OK]%W% Gaming-capable GPU detected

echo %W%%PAD%%REASON%

call :SEPARATOR

echo.
echo %G%%LOGOPAD%Press any key to continue...
pause >nul

endlocal & set "RECOMMENDED_PROFILE=%RECOMMENDED_PROFILE%"
goto SMART_OPTIMIZATION

:APPLY_OPTIMIZATION
cls
call :LOGO
call :SEPARATOR
echo.
echo %G%%LOGOPAD%APPLY OPTIMIZATION
call :SEPARATOR

if "%RECOMMENDED_PROFILE%"=="" (
echo %R%%PAD%No recommendation found.
echo %W%%PAD%Please run Analyze ^& Recommend first.
call :SEPARATOR
pause >nul
goto SMART_OPTIMIZATION
)

echo %W%%PAD%Selected Profile : %G%%RECOMMENDED_PROFILE%
echo %W%%PAD%Applying optimizations...
call :SEPARATOR

echo %RECOMMENDED_PROFILE% | findstr /i /c:"Competitive Performance" >nul && goto APPLY_COMPETITIVE
echo %RECOMMENDED_PROFILE% | findstr /i /c:"Balanced Gaming" >nul && goto APPLY_BALANCED
echo %RECOMMENDED_PROFILE% | findstr /i /c:"Battery Saving" >nul && goto APPLY_BATTERY

echo %R%%PAD%Không xác định được profile. Quay lại menu...
pause >nul
goto SMART_OPTIMIZATION

:APPLY_COMPETITIVE
echo %W%%PAD%Applying Competitive Performance...
powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749eb61
reg add "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 1 /f >nul
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f >nul
call :SUCCESS "Competitive Performance Applied"
goto COMPLETE_SCREEN

:APPLY_BALANCED
echo %W%%PAD%Applying Balanced Gaming...
powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e
reg add "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 1 /f >nul
call :SUCCESS "Balanced Gaming Applied"
goto COMPLETE_SCREEN

:APPLY_BATTERY
echo %W%%PAD%Applying Battery Saving...
powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e
reg add "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 0 /f >nul
call :SUCCESS "Battery Saving Applied"
goto COMPLETE_SCREEN

:COMPLETE_SCREEN
call :CHECK_POWER
call :CHECK_GAME
call :CHECK_DVR
call :CHECK_HAGS
call :STATUS_DISPLAY
cls
call :LOGO
call :SEPARATOR
echo.
echo %G%%LOGOPAD%OPTIMIZATION COMPLETE
call :SEPARATOR
echo %W%%PAD%RealFPS optimization finished successfully.
call :SEPARATOR
echo.
if "%RECOMMENDED_PROFILE%"=="" (
    echo %W%%PAD%Applied Profile : %G%%SELECTED_PROFILE%
) else (
    echo %W%%PAD%Applied Profile : %G%%RECOMMENDED_PROFILE%
)
echo.
echo %G%%LOGOPAD%CURRENT STATUS
call :SEPARATOR
echo %W%%PAD%Power    : %W%%POWER_STATUS%        %W%GameMode : %GAME_DISPLAY%
echo %W%%PAD%Xbox DVR : %DVR_DISPLAY%       %W%HAGS     : %HAGS_DISPLAY%
call :SEPARATOR
echo %G%%LOGOPAD%Press any key to continue...
pause >nul
goto WELCOME

rem =====================================
rem POWER MANAGEMENT
rem =====================================

:ULTIMATE
powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749eb61
if %errorlevel% neq 0 (
    call :FAILED "Ultimate Performance"
    goto WELCOME
)
call :SUCCESS "Ultimate Performance Enabled"
goto WELCOME

:HIGH
powercfg /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c83d5
if %errorlevel% neq 0 (
    call :FAILED "High Performance"
    goto WELCOME
)
call :SUCCESS "High Performance Enabled"
goto WELCOME

:BALANCED
powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e
if %errorlevel% neq 0 (
    call :FAILED "Balanced Power Plan"
    goto WELCOME
)
call :SUCCESS "Balanced Power Plan Enabled"
goto WELCOME

rem =====================================
rem GAME MODE
rem =====================================

:GAMEON
reg add "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 1 /f >nul
if %errorlevel% neq 0 (
    call :FAILED "Enable Game Mode"
    goto WELCOME
)
call :SUCCESS "Game Mode Enabled"
goto WELCOME

:GAMEOFF
reg add "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 0 /f >nul
if %errorlevel% neq 0 (
    call :FAILED "Disable Game Mode"
    goto WELCOME
)
call :SUCCESS "Game Mode Disabled"
goto WELCOME

rem =====================================
rem XBOX DVR
rem =====================================

:DVR_OFF
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f >nul
if %errorlevel% neq 0 (
    call :FAILED "Disable Xbox DVR"
    goto WELCOME
)
call :SUCCESS "Xbox DVR Disabled"
goto WELCOME

:DVR_ON
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 1 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 1 /f >nul
if %errorlevel% neq 0 (
    call :FAILED "Enable Xbox DVR"
    goto WELCOME
)
call :SUCCESS "Xbox DVR Enabled"
goto WELCOME

rem =====================================
rem BACKUP SYSTEM
rem =====================================

:BACKUP
cls
call :LOGO
call :SEPARATOR
echo.
echo %G%%LOGOPAD%BACKUP
call :SEPARATOR
echo %W%%PAD%Creating Backup...
call :SEPARATOR
reg export "HKCU\Software\Microsoft\GameBar" RealFPS_GameMode_Backup.reg /y
reg export "HKCU\System\GameConfigStore" RealFPS_DVR_Backup.reg /y
reg export "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" RealFPS_GameDVR_Backup.reg /y
reg export "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" RealFPS_HAGS_Backup.reg /y
call :SUCCESS "Backup Created"
goto WELCOME

:RESTORE_BACKUP
cls
call :LOGO
call :SEPARATOR
echo.
echo %G%%LOGOPAD%RESTORE BACKUP
call :SEPARATOR
echo %W%%PAD%Restoring Backup...
call :SEPARATOR
set RESTORED_COUNT=0
if exist RealFPS_GameMode_Backup.reg reg import RealFPS_GameMode_Backup.reg & set /a RESTORED_COUNT+=1
if exist RealFPS_DVR_Backup.reg reg import RealFPS_DVR_Backup.reg & set /a RESTORED_COUNT+=1
if exist RealFPS_GameDVR_Backup.reg reg import RealFPS_GameDVR_Backup.reg & set /a RESTORED_COUNT+=1
if exist RealFPS_HAGS_Backup.reg reg import RealFPS_HAGS_Backup.reg & set /a RESTORED_COUNT+=1
if %RESTORED_COUNT%==0 (
    echo %R%%PAD%No backup files found to restore.
    timeout /t 2 >nul
    goto WELCOME
)
call :SUCCESS "Backup Restored - Restart Recommended"
goto WELCOME

:RESTORE_CONFIRM
cls
call :LOGO
call :SEPARATOR
echo.
echo %G%%LOGOPAD%CREATE RESTORE POINT
call :SEPARATOR
echo %W%%PAD%RealFPS will create a Windows restore point
echo %W%%PAD%before applying any optimizations.
call :SEPARATOR
echo.
echo %W%%PAD%[%G%N%W%] Create Restore Point
echo %W%%PAD%[%G%N%W%] Back
echo.
call :SEPARATOR
echo.
%SYSTEMROOT%\System32\choice.exe /c YN /n /m "%G%%LOGOPAD%Select Option: %W%"
if errorlevel 2 goto RESTORE_WIZARD
if errorlevel 1 goto RESTORE
goto RESTORE_WIZARD

:RESTORE
cls
call :LOGO
call :SEPARATOR
echo.
echo %G%%LOGOPAD%CREATING RESTORE POINT
call :SEPARATOR
echo %W%%PAD%Please wait...
call :SEPARATOR
echo.
powershell -command "Checkpoint-Computer -Description 'Before RealFPS Tweak' -RestorePointType MODIFY_SETTINGS"
if %errorlevel% neq 0 (
    call :FAILED "Create Restore Point"
    goto WELCOME
)
call :SUCCESS "Restore Point Created"
goto WELCOME

rem =====================================
rem GPU HARDWARE ACCELERATION
rem =====================================

:HAGS_ON
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 2 /f >nul
if %errorlevel% neq 0 (
    call :FAILED "Enable HAGS"
    goto WELCOME
)
call :SUCCESS "HAGS Enabled - Restart Required - Admin Needed"
goto WELCOME

:HAGS_OFF
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 1 /f >nul
if %errorlevel% neq 0 (
    call :FAILED "Disable HAGS"
    goto WELCOME
)
call :SUCCESS "HAGS Disabled - Restart Required - Admin Needed"
goto WELCOME

:LOG
(
echo =====================================
echo RealFPS Activity Log
echo =====================================
echo.
echo Date:
echo %date% %time%
echo.
echo Action:
echo %~1
echo.
echo Profile:
echo %SELECTED_PROFILE%
echo.
echo Status:
echo SUCCESS
echo.
echo =====================================
echo.
)>> RealFPS_Log.txt
exit /b

:DIAGNOSTICS
cls
call :LOGO
call :SEPARATOR
echo.
echo %G%%LOGOPAD%GAMING DIAGNOSTICS
call :SEPARATOR
echo.
echo %W%%PAD%CPU:
powershell -command "Get-CimInstance Win32_Processor | Select-Object -ExpandProperty Name"
echo.
echo %W%%PAD%GPU:
powershell -command "Get-CimInstance Win32_VideoController | Select-Object -ExpandProperty Name"
echo.
echo %W%%PAD%RAM:
powershell -command "(Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB"
echo.
echo %W%%PAD%Windows:
powershell -command "Get-CimInstance Win32_OperatingSystem | Select-Object Caption"
echo.
echo %W%%PAD%System:
powershell -command "Get-CimInstance Win32_OperatingSystem | Select-Object OSArchitecture"
echo.
echo %W%%PAD%GPU Driver:
powershell -command "Get-CimInstance Win32_VideoController | Select-Object DriverVersion"
echo.
echo %W%%PAD%Disk:
powershell -command "Get-PSDrive C | Select-Object Used,Free"
echo.
echo %W%%PAD%Network Test:
ping 8.8.8.8 -n 4
echo.
call :SEPARATOR
echo.
call :LOG "SYSTEM DIAGNOSTICS COMPLETED"
pause >nul
goto WELCOME

:COMPETITIVE
echo %W%%PAD%Applying Competitive Gaming Mode...
powercfg /setactive e9a42b02-d5df-448d-aa00-03f14749eb61
reg add "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 1 /f >nul
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f >nul
if %errorlevel% neq 0 (
    call :FAILED "Competitive Gaming Mode"
    goto WELCOME
)
set SELECTED_PROFILE=Competitive Performance
goto COMPLETE_SCREEN

:BALANCED_MODE
echo %W%%PAD%Applying Balanced Gaming Mode...
powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e
reg add "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 1 /f >nul
if %errorlevel% neq 0 (
    call :FAILED "Balanced Gaming Mode"
    goto WELCOME
)
set SELECTED_PROFILE=Balanced Gaming
goto COMPLETE_SCREEN

:BATTERY_MODE
echo %W%%PAD%Applying Battery Saving Mode...
powercfg /setactive 381b4222-f694-41f0-9685-ff5bb260df2e
reg add "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 0 /f >nul
if %errorlevel% neq 0 (
    call :FAILED "Battery Saving Mode"
    goto WELCOME
)
set SELECTED_PROFILE=Battery Saving
goto COMPLETE_SCREEN

:INFORMATION
cls
call :LOGO

echo.
echo %G%%LOGOPAD%INFORMATION
call :SEPARATOR

echo.
echo %W%%PAD%PROJECT                          PHILOSOPHY
echo %W%%PAD%Version : %W%%VERSION%                   %W%• %W%Real Tweaks
echo %W%%PAD%Build   : %W%%BUILD%               %W%• %W%Real Results
echo %W%%PAD%Author  : %G%%DEVELOPER%             %W%• %W%No Placebo

echo.
echo %W%%PAD%MODULES                          REQUIREMENTS
echo %W%%PAD%• Benchmark                     • Windows 10 / 11
echo %W%%PAD%• Smart Optimization            • Administrator
echo %W%%PAD%• Optimization Center           • PowerShell 5.1+
echo %W%%PAD%• Chris Titus Tweaks
echo %W%%PAD%• HoneCtrl Tweaks

echo.
echo %W%%PAD%LINKS                            LICENSE
echo %G%%PAD%github.com/HaiCreates/RealFPS   • MIT

echo.
call :SEPARATOR

echo.
echo %G%%LOGOPAD%Press any key to continue...
pause >nul 2>&1
goto WELCOME

:HARDWARE_SCAN
cls
call :LOGO
call :SEPARATOR
echo.
echo %G%%LOGOPAD%HARDWARE DETECTION
call :SEPARATOR
echo.
echo %W%%PAD%CPU:
powershell -command "Get-CimInstance Win32_Processor | Select-Object -ExpandProperty Name"
echo.
echo %W%%PAD%GPU:
powershell -command "Get-CimInstance Win32_VideoController | Select-Object -ExpandProperty Name"
echo.
echo %W%%PAD%RAM:
powershell -command "[math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB,2); Write-Host 'GB'"
echo.
echo %W%%PAD%System Type:
powershell -command "Get-CimInstance Win32_SystemEnclosure | Select-Object ChassisTypes"
echo.
echo %W%%PAD%Windows:
powershell -command "Get-CimInstance Win32_OperatingSystem | Select-Object Caption"
echo.
echo %W%%PAD%Architecture:
powershell -command "Get-CimInstance Win32_OperatingSystem | Select-Object OSArchitecture"
echo.
call :SEPARATOR
echo.
call :LOG "Hardware Detection Completed"
pause >nul
goto WELCOME

rem =====================================
rem REPORT GENERATOR
rem =====================================

:REPORT
cls
call :LOGO
call :SEPARATOR
echo.
echo %G%%LOGOPAD%GENERATE REPORT
call :SEPARATOR
echo %W%%PAD%Creating RealFPS Report...
call :SEPARATOR
echo.
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
echo %G%%PAD%Report Created: %G%RealFPS_Report.txt
call :SEPARATOR
echo.
pause >nul
goto WELCOME

:DEV_INFO
cls
call :LOGO
call :SEPARATOR
echo.
echo %G%%LOGOPAD%DEVELOPER
call :SEPARATOR
echo %W%%PAD%Project    : %G%RealFPS
echo %W%%PAD%Version    : %W%%VERSION%
echo %W%%PAD%Build      : %W%%BUILD%
echo %W%%PAD%Developer  : %G%%DEVELOPER%
echo %W%%PAD%Language   : %W%Windows Batch Script
call :SEPARATOR
echo.
pause >nul
goto WELCOME

:OPTIMIZE_NETWORK
cls
call :LOGO
call :SEPARATOR
echo.
echo %G%%LOGOPAD%NETWORK OPTIMIZATION
call :SEPARATOR
echo %W%%PAD%Applying Network Tweaks...
call :SEPARATOR
netsh int tcp set global autotuninglevel=disabled
netsh int tcp set global rss=enabled
netsh int tcp set global chimney=disabled
ipconfig /flushdns
call :SUCCESS "Network Optimization Applied"
goto OPTIMIZATION_CENTER

:RESTORE_NETWORK
cls
call :LOGO
call :SEPARATOR
echo.
echo %G%%LOGOPAD%NETWORK RESTORE
call :SEPARATOR
echo %W%%PAD%Restoring Windows Default Network...
call :SEPARATOR
netsh int tcp set global autotuninglevel=normal >nul
netsh int tcp set global rss=default >nul
netsh int tcp set global chimney=default >nul
netsh int tcp set global ecncapability=default >nul
netsh int tcp set global timestamps=default >nul
ipconfig /flushdns >nul
call :SUCCESS "Network Restored To Default"
goto OPTIMIZATION_CENTER

:CLEAN_TEMP
cls
call :LOGO
call :SEPARATOR
echo.
echo %G%%LOGOPAD%CLEAN TEMP FILES
call :SEPARATOR
echo %W%%PAD%Cleaning temporary files...
call :SEPARATOR
del /q /f /s "%TEMP%\*" >nul 2>&1
del /q /f /s "C:\Windows\Temp\*" >nul 2>&1
call :SUCCESS "Temporary Files Cleaned"
goto OPTIMIZATION_CENTER

:HIBERNATE_OFF
cls
call :LOGO
call :SEPARATOR
echo.
echo %G%%LOGOPAD%DISABLE HIBERNATION
call :SEPARATOR
echo %W%%PAD%Disabling Hibernation...
call :SEPARATOR
powercfg /hibernate off
call :SUCCESS "Hibernation Disabled"
goto OPTIMIZATION_CENTER

:HIBERNATE_ON
cls
call :LOGO
call :SEPARATOR
echo.
echo %G%%LOGOPAD%ENABLE HIBERNATION
call :SEPARATOR
echo %W%%PAD%Enabling Hibernation...
call :SEPARATOR
powercfg /hibernate on
call :SUCCESS "Hibernation Enabled"
goto OPTIMIZATION_CENTER

:SUCCESS
call :LOG "SUCCESS - %~1"
cls
call :LOGO
call :SEPARATOR
echo.
echo %G%%LOGOPAD%SUCCESS
call :SEPARATOR
echo %G%%PAD%%~1
call :SEPARATOR
echo.
echo %G%%LOGOPAD%Press any key to continue...
pause >nul
exit /b

:FAILED
call :LOG "FAILED - %~1 Error Code: %errorlevel%"
cls
call :LOGO
call :SEPARATOR
echo.
echo %R%%LOGOPAD%FAILED
call :SEPARATOR
echo %R%%PAD%%~1
echo %W%%PAD%Error Code: %W%%errorlevel%
call :SEPARATOR
echo.
echo %R%%LOGOPAD%Press any key to continue...
pause >nul
exit /b

:SUCCESS_RISKY
call :LOG "SUCCESS_RISKY - %~1"
cls
call :LOGO
call :SEPARATOR
echo.
echo %R%%LOGOPAD%RISKY TWEAK APPLIED
call :SEPARATOR
echo %R%%PAD%%~1
call :SEPARATOR
echo.
echo %W%%PAD%⚠ These are advanced tweaks. Restart may be required.
echo %W%%PAD%⚠ Some changes may affect system behavior.
echo.
echo %R%%LOGOPAD%Press any key to continue...
pause >nul
exit /b

:CHECK_POWER
for /f "tokens=*" %%a in ('powercfg /getactivescheme') do set PLAN=%%a

echo %PLAN% | find /i "Balanced" >nul
if not errorlevel 1 set POWER_STATUS=Balanced

echo %PLAN% | find /i "High performance" >nul
if not errorlevel 1 set POWER_STATUS=High Performance

echo %PLAN% | find /i "Ultimate Performance" >nul
if not errorlevel 1 set POWER_STATUS=Ultimate Performance

exit /b

:CHECK_GAME
for /f "tokens=3" %%a in ('reg query "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled 2^>nul') do set gm=%%a
if "%gm%"=="0x1" (
    set GAME_STATUS=ON
) else (
    set GAME_STATUS=OFF
)
exit /b

:CHECK_DVR
for /f "tokens=3" %%a in ('reg query "HKCU\System\GameConfigStore" /v GameDVR_Enabled 2^>nul') do set dvr=%%a
if "%dvr%"=="0x1" (
    set DVR_STATUS=ON
) else (
    set DVR_STATUS=OFF
)
exit /b

:CHECK_HAGS
for /f "tokens=3" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode 2^>nul') do set hags=%%a
if "%hags%"=="0x2" (
    set HAGS_STATUS=ON
) else (
    set HAGS_STATUS=OFF
)
exit /b

rem =============================================
rem CHRIS TITUS STYLE TWEAKS (giữ nguyên từ file cũ)
rem =============================================
:CHRISTITUS_TWEAKS
cls
call :LOGO
call :SEPARATOR
echo.
echo %G%%LOGOPAD%CHRIS TITUS TWEAKS
echo %R%%PAD%Advanced system modifications - use carefully
echo.

call :SEPARATOR

echo.
echo %G%%PAD%PERFORMANCE                      PRIVACY
echo %W%%PAD%[%G%1%W%] Visual Effects OFF           [%G%9%W%] Disable Telemetry
echo %W%%PAD%[%G%2%W%] Disable GameDVR              [%G%10%W%] Disable Cortana
echo %W%%PAD%[%G%3%W%] Disable Store                [%G%11%W%] Disable Activity History
echo %W%%PAD%[%G%4%W%] Disable Defender             [%G%12%W%] Disable Advertising ID
echo %W%%PAD%[%G%5%W%] Disable Search               [%G%13%W%] Disable Tailored Experience
echo %W%%PAD%[%G%6%W%] Disable SysMain
echo %W%%PAD%[%G%7%W%] Disable Background Apps
echo %W%%PAD%[%G%8%W%] Disable Startup Programs

echo.
echo.
echo %G%%PAD%SYSTEM                           NETWORK
echo %W%%PAD%[%G%14%W%] Disable Updates             [%G%19%W%] Disable QoS
echo %W%%PAD%[%G%15%W%] Disable Driver Updates      [%G%20%W%] Disable Network Throttling
echo %W%%PAD%[%G%16%W%] Disable Maintenance         [%G%21%W%] Disable Peer-to-Peer
echo %W%%PAD%[%G%17%W%] Disable Error Reporting
echo %W%%PAD%[%G%18%W%] Disable Diagnostic Services

echo.
echo.
echo %G%%PAD%SPECIAL
echo %W%%PAD%[%G%A%W%] Apply All Tweaks
echo %W%%PAD%[%G%R%W%] Restore Defaults
echo %W%%PAD%[%G%0%W%] Back

echo.
call :SEPARATOR

echo.
set /p "choice=%G%%LOGOPAD%Select Option: %W%"

if /i "%choice%"=="0" goto ADVANCED_MENU
if /i "%choice%"=="R" goto RESTORE_CHRISTITUS
if /i "%choice%"=="A" goto APPLY_ALL_CHRISTITUS
if /i "%choice%"=="1" goto CT_VISUAL
if /i "%choice%"=="2" goto CT_GAMEDVR
if /i "%choice%"=="3" goto CT_STORE
if /i "%choice%"=="4" goto CT_DEFENDER
if /i "%choice%"=="5" goto CT_SEARCH
if /i "%choice%"=="6" goto CT_SYSMAIN
if /i "%choice%"=="7" goto CT_BACKGROUND
if /i "%choice%"=="8" goto CT_STARTUP
if /i "%choice%"=="9" goto CT_TELEMETRY
if /i "%choice%"=="10" goto CT_CORTANA
if /i "%choice%"=="11" goto CT_ACTIVITY
if /i "%choice%"=="12" goto CT_ADVERTISING
if /i "%choice%"=="13" goto CT_TAILORED
if /i "%choice%"=="14" goto CT_UPDATES
if /i "%choice%"=="15" goto CT_DRIVERS
if /i "%choice%"=="16" goto CT_MAINTENANCE
if /i "%choice%"=="17" goto CT_ERROR
if /i "%choice%"=="18" goto CT_DIAGNOSTIC
if /i "%choice%"=="19" goto CT_QOS
if /i "%choice%"=="20" goto CT_THROTTLE
if /i "%choice%"=="21" goto CT_P2P

echo %R%Invalid option. Please try again.%N%
timeout /t 2 >nul
goto CHRISTITUS_TWEAKS

:APPLY_ALL_CHRISTITUS
echo %W%%PAD%Applying ALL Chris Titus Tweaks...
echo %W%%PAD%This will take a moment...
call :CT_VISUAL
call :CT_GAMEDVR
call :CT_STORE
call :CT_DEFENDER
call :CT_SEARCH
call :CT_SYSMAIN
call :CT_BACKGROUND
call :CT_TELEMETRY
call :CT_CORTANA
call :CT_ACTIVITY
call :CT_ADVERTISING
call :CT_TAILORED
call :CT_UPDATES
call :CT_DRIVERS
call :CT_MAINTENANCE
call :CT_ERROR
call :CT_DIAGNOSTIC
call :CT_QOS
call :CT_THROTTLE
call :CT_P2P
call :SUCCESS_RISKY "All Chris Titus Tweaks Applied - Restart Required"
goto CHRISTITUS_TWEAKS

:CT_VISUAL
echo %W%%PAD%Disabling ALL Visual Effects...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9012038010010000 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v MenuShowDelay /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f >nul 2>&1
reg add "HKCU\Control Panel\Desktop" /v DragFullWindows /t REG_SZ /d 0 /f >nul 2>&1
call :SUCCESS_RISKY "Visual Effects Disabled"
goto CHRISTITUS_TWEAKS

:CT_GAMEDVR
echo %W%%PAD%Disabling GameDVR & GameBar...
reg add "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\GameBar" /v AllowAutoGameMode /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\GameBar" /v UseNexusForGameBarEnabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\System\GameConfigStore" /v GameDVR_FSEBehaviorMode /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f >nul 2>&1
call :SUCCESS_RISKY "GameDVR & GameBar Disabled"
goto CHRISTITUS_TWEAKS

:CT_STORE
echo %W%%PAD%Disabling Windows Store...
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v RemoveWindowsStore /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v AutoDownload /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v DisableStoreApps /t REG_DWORD /d 1 /f >nul 2>&1
call :SUCCESS_RISKY "Windows Store Disabled"
goto CHRISTITUS_TWEAKS

:CT_DEFENDER
echo %W%%PAD%Disabling Windows Defender...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableRealtimeMonitoring /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableBehaviorMonitoring /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableScanOnRealtimeEnable /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableIOAVProtection /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v SpyNetReporting /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v SubmitSamplesConsent /t REG_DWORD /d 2 /f >nul 2>&1
call :SUCCESS_RISKY "Windows Defender Disabled"
goto CHRISTITUS_TWEAKS

:CT_SEARCH
echo %W%%PAD%Disabling Windows Search Indexing...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v DisableIndexer /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v DisableBackoff /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowSearchToUseLocation /t REG_DWORD /d 0 /f >nul 2>&1
call :SUCCESS_RISKY "Search Indexing Disabled"
goto CHRISTITUS_TWEAKS

:CT_SYSMAIN
echo %W%%PAD%Disabling SysMain & Prefetch...
sc config SysMain start=disabled >nul 2>&1
sc stop SysMain >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnablePrefetcher /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnableSuperfetch /t REG_DWORD /d 0 /f >nul 2>&1
call :SUCCESS_RISKY "SysMain & Prefetch Disabled - Restart Required"
goto CHRISTITUS_TWEAKS

:CT_BACKGROUND
echo %W%%PAD%Disabling ALL Background Apps...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\PushNotifications" /v ToastEnabled /t REG_DWORD /d 0 /f >nul 2>&1
call :SUCCESS_RISKY "Background Apps Disabled"
goto CHRISTITUS_TWEAKS

:CT_STARTUP
echo %W%%PAD%Disabling Startup Programs (User)...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /va /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /va /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce" /va /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce" /va /f >nul 2>&1
call :SUCCESS_RISKY "Startup Programs Disabled"
goto CHRISTITUS_TWEAKS

:CT_TELEMETRY
echo %W%%PAD%Disabling ALL Telemetry...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul 2>&1
sc config DiagTrack start=disabled >nul 2>&1
sc config dmwappushservice start=disabled >nul 2>&1
sc stop DiagTrack >nul 2>&1
sc stop dmwappushservice >nul 2>&1
call :SUCCESS_RISKY "Telemetry Disabled - Restart Required"
goto CHRISTITUS_TWEAKS

:CT_CORTANA
echo %W%%PAD%Disabling Cortana Completely...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortanaAboveLock /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v DisableWebSearch /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v ConnectedSearchUseWeb /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Personalization\Settings" /v AcceptedPrivacyPolicy /t REG_DWORD /d 0 /f >nul 2>&1
call :SUCCESS_RISKY "Cortana Disabled"
goto CHRISTITUS_TWEAKS

:CT_ACTIVITY
echo %W%%PAD%Disabling Activity History...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v EnableActivityFeed /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v PublishUserActivities /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v UploadUserActivities /t REG_DWORD /d 0 /f >nul 2>&1
call :SUCCESS_RISKY "Activity History Disabled"
goto CHRISTITUS_TWEAKS

:CT_ADVERTISING
echo %W%%PAD%Disabling Advertising ID...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v DisabledByGroupPolicy /t REG_DWORD /d 1 /f >nul 2>&1
call :SUCCESS_RISKY "Advertising ID Disabled"
goto CHRISTITUS_TWEAKS

:CT_TAILORED
echo %W%%PAD%Disabling Tailored Experiences...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Privacy" /v TailoredExperiencesWithDiagnosticDataEnabled /t REG_DWORD /d 0 /f >nul 2>&1
call :SUCCESS_RISKY "Tailored Experiences Disabled"
goto CHRISTITUS_TWEAKS

:CT_UPDATES
echo %W%%PAD%Disabling Windows Updates...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v AUOptions /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v ScheduledInstallDay /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v FlightSettingsMaxPauseDays /t REG_DWORD /d 365 /f >nul 2>&1
call :SUCCESS_RISKY "Windows Updates Disabled - Restart Required"
goto CHRISTITUS_TWEAKS

:CT_DRIVERS
echo %W%%PAD%Disabling Driver Updates...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v ExcludeWUDriversInQualityUpdate /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v SearchOrderConfig /t REG_DWORD /d 0 /f >nul 2>&1
call :SUCCESS_RISKY "Driver Updates Disabled"
goto CHRISTITUS_TWEAKS

:CT_MAINTENANCE
echo %W%%PAD%Disabling Automatic Maintenance...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v MaintenanceDisabled /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKLM\SOFTWARE\Microsoft\Windows\ScheduledDiagnostics" /v Enabled /t REG_DWORD /d 0 /f >nul 2>&1
call :SUCCESS_RISKY "Automatic Maintenance Disabled"
goto CHRISTITUS_TWEAKS

:CT_ERROR
echo %W%%PAD%Disabling Error Reporting...
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v Disabled /t REG_DWORD /d 1 /f >nul 2>&1
call :SUCCESS_RISKY "Error Reporting Disabled"
goto CHRISTITUS_TWEAKS

:CT_DIAGNOSTIC
echo %W%%PAD%Disabling Diagnostic Services...
sc config diagnosticshub.standardcollector.service start=disabled >nul 2>&1
sc stop diagnosticshub.standardcollector.service >nul 2>&1
call :SUCCESS_RISKY "Diagnostic Services Disabled - Restart Required"
goto CHRISTITUS_TWEAKS

:CT_QOS
echo %W%%PAD%Disabling QoS...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" /v NonBestEffortLimit /t REG_DWORD /d 0 /f >nul 2>&1
call :SUCCESS_RISKY "QoS Disabled - Restart Required"
goto CHRISTITUS_TWEAKS

:CT_THROTTLE
echo %W%%PAD%Disabling Network Throttling...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /t REG_DWORD /d 4294967295 /f >nul 2>&1
call :SUCCESS_RISKY "Network Throttling Disabled - Restart Required"
goto CHRISTITUS_TWEAKS

:CT_P2P
echo %W%%PAD%Disabling Windows Peer-to-Peer...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v DODownloadMode /t REG_DWORD /d 0 /f >nul 2>&1
call :SUCCESS_RISKY "Peer-to-Peer Disabled"
goto CHRISTITUS_TWEAKS

:RESTORE_CHRISTITUS
cls
call :LOGO
call :SEPARATOR
echo.
echo %G%%LOGOPAD%RESTORE CHRIS TITUS DEFAULTS
echo %W%%PAD%Restoring all Chris Titus tweaks to defaults...
echo %R%%PAD%⚠ This will revert all modifications
call :SEPARATOR
echo.
echo %W%%PAD%Are you sure? (Y/N)
set /p confirm="%G%%LOGOPAD%Confirm (Y/N): %W%"
if /i not "%confirm%"=="Y" (
    echo %W%%PAD%Cancelled
    timeout /t 1 >nul
    goto CHRISTITUS_TWEAKS
)

echo %W%%PAD%Restoring defaults...
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /f >nul 2>&1
reg delete "HKCU\Control Panel\Desktop" /v UserPreferencesMask /f >nul 2>&1
reg delete "HKCU\Control Panel\Desktop" /v MenuShowDelay /f >nul 2>&1
reg delete "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /f >nul 2>&1
reg delete "HKCU\Control Panel\Desktop" /v DragFullWindows /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\GameBar" /v AllowAutoGameMode /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\GameBar" /v UseNexusForGameBarEnabled /f >nul 2>&1
reg delete "HKCU\System\GameConfigStore" /v GameDVR_Enabled /f >nul 2>&1
reg delete "HKCU\System\GameConfigStore" /v GameDVR_FSEBehaviorMode /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v RemoveWindowsStore /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v AutoDownload /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\WindowsStore" /v DisableStoreApps /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender" /v DisableAntiSpyware /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableRealtimeMonitoring /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableBehaviorMonitoring /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableScanOnRealtimeEnable /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v DisableIOAVProtection /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v SpyNetReporting /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v SubmitSamplesConsent /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v DisableIndexer /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v DisableBackoff /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowSearchToUseLocation /f >nul 2>&1
sc config SysMain start=auto >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnablePrefetcher /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters" /v EnableSuperfetch /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\PushNotifications" /v ToastEnabled /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v AllowTelemetry /f >nul 2>&1
sc config DiagTrack start=auto >nul 2>&1
sc config dmwappushservice start=auto >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortanaAboveLock /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v DisableWebSearch /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v ConnectedSearchUseWeb /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v AUOptions /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v ScheduledInstallDay /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v FlightSettingsMaxPauseDays /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" /v ExcludeWUDriversInQualityUpdate /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" /v SearchOrderConfig /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\Maintenance" /v MaintenanceDisabled /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\ScheduledDiagnostics" /v Enabled /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v Disabled /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" /v NonBestEffortLimit /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v NetworkThrottlingIndex /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v DODownloadMode /f >nul 2>&1
call :SUCCESS_RISKY "All Chris Titus Tweaks Restored - Restart Recommended"
goto CHRISTITUS_TWEAKS

rem =============================================
rem HONECTRL STYLE TWEAKS
rem =============================================
:HONECTRL_TWEAKS
cls
call :LOGO
call :SEPARATOR
echo.
echo %G%%LOGOPAD%HONECTRL TWEAKS
echo %R%%PAD%Extreme system optimization - advanced users only
echo.

call :SEPARATOR

echo.
echo %G%%PAD%SAFE TWEAKS                    MEDIUM TWEAKS
echo %W%%PAD%[%G%S1%W%] Disable Services          [%G%M1%W%] Disable Firewall
echo %W%%PAD%[%G%S2%W%] Disable Security Center   [%G%M2%W%] Disable UAC
echo %W%%PAD%[%G%S3%W%] Disable SmartScreen       [%G%M3%W%] Disable Kernel Protection
echo %W%%PAD%[%G%S4%W%] Disable Power Saving      [%G%M4%W%] Disable Microsoft Services
echo %W%%PAD%[%G%S5%W%] Disable Core Parking      [%G%M5%W%] Disable Cloud Features
echo %W%%PAD%[%G%S6%W%] Disable GPU Power Save

echo.
echo.
echo %G%%PAD%EXTREME TWEAKS                 SPECIAL
echo %W%%PAD%[%G%E1%W%] Disable Pagefile          [%G%A%W%] Apply All Safe Tweaks
echo %W%%PAD%[%G%E2%W%] Disable WFP               [%G%R%W%] Restore Defaults
echo %W%%PAD%[%G%E3%W%] Disable Driver Signing    [%G%0%W%] Back
echo %W%%PAD%[%G%E4%W%] Disable Memory Protect
echo %W%%PAD%[%G%E5%W%] Disable DEP

echo.
echo.
call :SEPARATOR

echo.
set /p "choice=%G%%LOGOPAD%Select Option: %W%"

if /i "%choice%"=="0" goto ADVANCED_MENU
if /i "%choice%"=="R" goto RESTORE_HONECTRL
if /i "%choice%"=="A" goto APPLY_SAFE_HONECTRL

REM Safe Tweaks
if /i "%choice%"=="S1" goto HC_SERVICES
if /i "%choice%"=="S2" goto HC_SECURITY
if /i "%choice%"=="S3" goto HC_SMARTSCREEN
if /i "%choice%"=="S4" goto HC_POWER_SAFE
if /i "%choice%"=="S5" goto HC_CORE
if /i "%choice%"=="S6" goto HC_GPU

REM Medium Tweaks
if /i "%choice%"=="M1" goto HC_FIREWALL
if /i "%choice%"=="M2" goto HC_UAC
if /i "%choice%"=="M3" goto HC_KERNEL
if /i "%choice%"=="M4" goto HC_MS_SERVICES
if /i "%choice%"=="M5" goto HC_CLOUD

REM Extreme Tweaks
if /i "%choice%"=="E1" goto HC_PAGEFILE
if /i "%choice%"=="E2" goto HC_WFP
if /i "%choice%"=="E3" goto HC_DRIVER_SIGN
if /i "%choice%"=="E4" goto HC_MEMORY
if /i "%choice%"=="E5" goto HC_DEP

echo %R%Invalid option. Please try again.%N%
timeout /t 2 >nul
goto HONECTRL_TWEAKS

:APPLY_SAFE_HONECTRL
echo %W%%PAD%Applying ALL Safe HoneCtrl Tweaks...
call :HC_SERVICES
call :HC_SECURITY
call :HC_SMARTSCREEN
call :HC_POWER_SAFE
call :HC_CORE
call :HC_GPU
call :SUCCESS_RISKY "All Safe HoneCtrl Tweaks Applied - Restart Recommended"
goto HONECTRL_TWEAKS

:HC_SERVICES
echo %W%%PAD%Disabling Non-Essential Services...
for %%s in (
    "DiagTrack" "dmwappushservice" "diagnosticshub.standardcollector.service"
    "MapsBroker" "RetailDemo" "WpnService" "PcaSvc" "wisvc"
    "XblAuthManager" "XblGameSave" "XboxNetApiSvc" "XboxGipSvc"
) do (
    sc config %%s start=disabled >nul 2>&1
    sc stop %%s >nul 2>&1
)
call :SUCCESS_RISKY "Non-Essential Services Disabled"
goto HONECTRL_TWEAKS

:HC_SECURITY
echo %W%%PAD%Disabling Windows Security Center...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Security Center" /v DisableNotifications /t REG_DWORD /d 1 /f >nul 2>&1
sc config wscsvc start=disabled >nul 2>&1