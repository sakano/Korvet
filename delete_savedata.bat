@echo off
SETLOCAL

for /f %%P in ('%~dp0tvpwin32.exe -printdatapath') do set DATAPATH=%%P
del %DATAPATH% /Q

ENDLOCAL
