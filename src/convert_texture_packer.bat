@echo off
call _convert.bat "update_debug"

start /w %~dp0/../tvpwin32.exe "%~dp0/../data/debug/tools/" -startup="convert_texture_packer.tjs"
