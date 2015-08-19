@echo off
start /w %~dp0/../tvpwin32.exe "%~dp0/converter/" -startup="startup.rtjs" ^
    -debug="yes" -debugwin="yes" ^
    -dataPath="%~dp0/../data/" -srcPath="%~dp0/" ^
    -includePath="%~dp0/include/" -headerPath="%~dp0/include/preprocessSetting.tjs" ^
    -method="%1"

exit /b %ERRORLEVEL%
