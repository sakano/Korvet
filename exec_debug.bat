@echo off
taskkill /f /im "tvpwin32.exe" >NUL 2>&1
taskkill /f /im "tvpwin32_p.exe" >NUL 2>&1
taskkill /f /im "tvpwin32_d.exe" >NUL 2>&1
taskkill /f /im "tvpwin32_dbg.exe" >NUL 2>&1

call src/_convert.bat "update_debug"

if %ERRORLEVEL% equ -1 (
    start /w %~dp0/tvpwin32.exe "%~dp0/data/debug/tools/" -startup="create_ctags.tjs"
)

tvpwin32.exe "%~dp0data/debug" -debug="yes" -debugwin="yes" -warnrundelobj="no"
