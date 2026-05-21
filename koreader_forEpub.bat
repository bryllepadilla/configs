echo off
setlocal

:::: Path to your WSL distribution (change if your distro name is not "Ubuntu")
::set DISTRO=Ubuntu-22.04
::
:::: Convert Windows path to WSL path and run KOReader
::wsl -d %DISTRO% /usr/bin/koreader "%~1" -- 2>nul
::
:::: Fallback if direct call fails (sometimes helps with GUI apps)
::if errorlevel 1 (
::    wsl -d %DISTRO% bash -c "/usr/bin/koreader \"$(wslpath -u \"%~1\")\""
::)
::
::::FOR /F "tokens=* delims=" %%V IN ('your_command_here') DO (
::::    SET "MYVAR=%%V"
::::    )

:: WORKING

set DISTRO=Ubuntu-22.04

for /f "delims=" %%i in ('dir /B /S %*') do set "VAR=%%i"
wsl -d %DISTRO% /usr/bin/koreader $(/usr/bin/wslpath -u "%VAR%")

::timeout /t 20
cmd /k

do set
:: NEEDS space and not new line
