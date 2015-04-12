@echo off
taskkill /f /im "tvpwin32.exe" >NUL 2>&1
taskkill /f /im "tvpwin32_p.exe" >NUL 2>&1
taskkill /f /im "tvpwin32_d.exe" >NUL 2>&1
taskkill /f /im "tvpwin32_dbg.exe" >NUL 2>&1

call compile_release.bat

start "" tvpwin32_p.exe "%~dp0start" -rlmode="yes" -forcelog="yes"
