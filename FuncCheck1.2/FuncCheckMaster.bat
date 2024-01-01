@echo off
cls

echo.
echo System Functionality Check 
echo Created by TrueBruiser 
echo find the repository at https://github.com/TrueBruiser
echo aka Happy Gilmore 1635270
echo.
echo Last updated (1/1/24) 
echo This script and any other scripts run throughout this process are the intellectual property of TrueBruiser. For any additional addons, reccomendations, or bug reporting/errors, create a request on my github (posted Above). 
echo.
echo.
echo.

timeout /t 5

echo Starting Function Check Master Script

:: Check Windows Update Status
echo Checking Windows Update Status...
for /f "delims=" %%i in ('PowerShell -Command "(Get-HotFix | Sort-Object InstalledOn -Descending | Select-Object -First 1).InstalledOn"') do set "LastUpdate=%%i"

:: Compare with Current Date
for /f "delims=" %%i in ('PowerShell -Command "Get-Date -Format 'MM/dd/yyyy'"') do set "CurrentDate=%%i"

:: Decide whether to run updates
if "%LastUpdate%" neq "%CurrentDate%" (
    echo Windows updates were not installed today. Running update script...
    goto run_winupdate
) else (
    echo Windows updates are up to date. Skipping update script...
    goto sys_test_input
)

:run_winupdate
:: Run the PowerShell script for Windows Update
:: Stage 1 
echo Running Windows Update script...
PowerShell -Command "Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process; & {./WinUpdate.ps1}"
if %errorlevel% neq 0 (
    echo Error encountered, attempting to run with bypass...
    PowerShell -ExecutionPolicy Bypass -File "./WinUpdate.ps1"
    if %errorlevel% neq 0 (
        echo Failed to run Windows Update script. Proceeding to next step.
    )
)
goto sys_test_input

:sys_test_input
echo Do you want to run the System Test and Health script? [Y/N/E]
set /p UserInput=
if /I "%UserInput%"=="Y" goto run_sys_test
if /I "%UserInput%"=="N" goto screen_test_input
if /I "%UserInput%"=="E" exit
goto sys_test_input

:run_sys_test
:: Stage 2
echo Running System Test and Health script...
call SysTestAndHealth.bat
goto screen_test_input

:screen_test_input
echo Do you want to run the Screen Test script? [Y/N/E]
set /p UserInput=
if /I "%UserInput%"=="Y" goto run_screen_test
if /I "%UserInput%"=="N" goto end_script
if /I "%UserInput%"=="E" exit
goto screen_test_input

:run_screen_test
:: Stage 3
echo Running Screen Test...
call ScreenTest.bat
goto end_script

:end_script
:: Stage 4
echo Function Check Master Script Completed.
echo Is there anything else that needs done with the machine? [Y/N]
echo Press [S] to shutdown the computer ending the Functionality Check of the device
::as of 1/1/24 there are no further options to test devices, however I do plan on adding more in the future.
set /p UserInput=
if /I "%UserInput%"=="Y" exit
if /I "%UserInput%"=="S" shutdown /s /f /t 0
if /I "%UserInput%"=="N" exit
