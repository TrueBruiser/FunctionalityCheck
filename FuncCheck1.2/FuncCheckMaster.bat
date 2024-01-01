@echo off
cls
echo Starting Function Check Master Script

:: Run the PowerShell script for Windows Update
:: Stage 1 
echo Running Windows Update script...
PowerShell -Command "Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process; & {./WinUpdate.ps1}"
:winupdate_input
echo Has the system been updated to its latest version? [Y/N/E]
set /p UserInput=
if /I "%UserInput%"=="Y" call SysTestAndHealth.bat
if /I "%UserInput%"=="N" call WinUpdate.ps1
if /I "%UserInput%"=="E" exit
if /I "%UserInput%"=="y" call SysTestAndHealth.bat
if /I "%UserInput%"=="n" call WinUpdate.ps1
if /I "%UserInput%"=="e" exit
goto winupdate_input

:sys_test
::stage 2
echo Running System Test and Health script...
call SysTestAndHealth.bat
:sys_test_input
echo Would you like to run a system health check and view all results? [Y/N/E]
set /p UserInput=
if /I "%UserInput%"=="Y" call SysTestAndHealth.bat
if /I "%UserInput%"=="N" call ScreenTest.bat
if /I "%UserInput%"=="E" exit
if /I "%UserInput%"=="y" call SysTestAndHealth.bat
if /I "%UserInput%"=="n" call ScreenTest.bat
if /I "%UserInput%"=="e" exit

goto sys_test_inputscreen_tes:stage 3ho Running Screen Test...
PowerShell -Command "Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process; & {./ScreenTest.ps1}"
:screen_test_input
echo Would you like to run a screen and sound test for the system? [Y/N/E]
set /p UserInput=
if /I "%UserInput%"=="Y" call ScreenTest.bat
if /I "%UserInput%"=="N" exit
if /I "%UserInput%"=="E" exit
if /I "%UserInput%"=="y" call ScreenTest.bat
if /I "%UserInput%"=="n" exit
if /I "%UserInput%"=="e" exit

goto screenTest


:end_script
echo Function Check Master Script Completed.
pause
exit

