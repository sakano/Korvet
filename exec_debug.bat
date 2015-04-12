@echo off
taskkill /f /im "tvpwin32.exe" >NUL 2>&1
taskkill /f /im "tvpwin32_p.exe" >NUL 2>&1
taskkill /f /im "tvpwin32_d.exe" >NUL 2>&1
taskkill /f /im "tvpwin32_dbg.exe" >NUL 2>&1

call compile_debug.bat

tvpwin32.exe "%~dp0start" -debug="yes" -debugwin="yes" -warnrundelobj="no"
