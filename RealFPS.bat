@echo off
title RealFPS - Windows Gaming Optimizer
color 0A

:MENU
cls
echo.
echo =====================================
echo      RealFPS - Windows Gaming Optimizer
echo =====================================
echo.
echo [1] Ultimate Performance
echo [2] High Performance
echo [3] Balanced
echo.
echo [0] Exit
echo.
set /p choice=Choose an option: 

if "%choice%"=="1" goto ULTIMATE
if "%choice%"=="2" goto HIGH
if "%choice%"=="3" goto BALANCED
if "%choice%"=="0" exit

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
