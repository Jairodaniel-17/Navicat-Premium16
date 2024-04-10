@echo off
setlocal

set update=HKEY_CURRENT_USER\Software\PremiumSoft\NavicatPremium\Update

reg delete %update% /va /f >nul 2>&1

for /f %%i in ('"REG QUERY "HKEY_CURRENT_USER\Software\PremiumSoft\NavicatPremium" /s | findstr /L Registration"') do (
    reg delete %%i /va /f >nul 2>&1
)

for /f %%i in ('"REG QUERY "HKEY_CURRENT_USER\Software\Classes\CLSID" /s | findstr /E Info"') do (
    set "all_info=%%i"
)
if defined all_Info (
    setlocal EnableDelayedExpansion
    set "p_info=!all_info:~0,-5!"
    reg delete !p_info!  /f >nul 2>&1
)

for /f %%i in ('"REG QUERY "HKEY_CURRENT_USER\Software\Classes\CLSID" /s | findstr /E ShellFolder"') do (
    set "all_ShellFolder=%%i"
)
if not "%all_ShellFolder%"=="" (
    set p_ShellFolder=%all_ShellFolder:~0,-12%
)

if not "%p_ShellFolder%"=="" (
    reg delete %p_ShellFolder%  /f >nul 2>&1
)

endlocal
