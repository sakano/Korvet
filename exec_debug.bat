@echo off
taskkill /f /im "tvpwin32.exe" >NUL 2>&1
taskkill /f /im "tvpwin32_p.exe" >NUL 2>&1
taskkill /f /im "tvpwin32_d.exe" >NUL 2>&1
taskkill /f /im "tvpwin32_dbg.exe" >NUL 2>&1

call src/_convert.bat "update_debug"

if ERRORLEVEL 1 (
    call src/create_ctags.bat
)

tvpwin32.exe "%~dp0data/debug" -debug="yes" -debugwin="yes" -warnrundelobj="no"
