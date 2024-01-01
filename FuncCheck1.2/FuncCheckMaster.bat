@echo off
cls


echo.
echo.
echo ===============================================================================================                                                                                             
echo ===============================================================================================                    
echo " $$$$$$$$\                                   $$$$$$\  $$\                           $$\       " 
echo " $$  _____|                                 $$  __$$\ $$ |                          $$ |      "
echo " $$ |   $$\   $$\ $$$$$$$\   $$$$$$$\       $$ /  \__|$$$$$$$\   $$$$$$\   $$$$$$$\ $$ |  $$\ "
echo " $$$$$\ $$ |  $$ |$$  __$$\ $$  _____|      $$ |      $$  __$$\ $$  __$$\ $$  _____|$$ | $$  |"
echo " $$  __|$$ |  $$ |$$ |  $$ |$$ /            $$ |      $$ |  $$ |$$$$$$$$ | $$ /      $$$$$$  /" 
echo " $$ |   $$ |  $$ |$$ |  $$ |$$ |            $$ |  $$\ $$ |  $$ |$$   ____|$$ |      $$  _$$<  "
echo " $$ |   \$$$$$$  |$$ |  $$ |\$$$$$$$\       \$$$$$$  |$$ |  $$ |\$$$$$$$\ \$$$$$$$\ $$ | \$$\ "
echo " \__|    \______/ \__|  \__| \_______|       \______/ \__|  \__| \_______| \_______|\__|  \__|"
echo ===============================================================================================                                                                                             
echo ===============================================================================================                                                                                             
echo.
echo.
echo.
echo System Functionality Check 
echo.
echo Created by TrueBruiser 
echo find the repository at https://github.com/TrueBruiser
echo aka Happy Gilmore 1635270
echo.
echo Last updated (1/1/24) 
echo.
echo This script and any other scripts run throughout this process are the intellectual property of TrueBruiser. For any additional addons, reccomendations, or bug reporting/errors, create a request on my github (posted Above). 
echo.
echo.
echo.

timeout /t 15









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
PowerShell -Command "Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process; & .\WinUpdate.ps1"
if %errorlevel% neq 0 (
    echo Error encountered, attempting to run with bypass...
    PowerShell -ExecutionPolicy Bypass -File ".\WinUpdate.ps1"
    if %errorlevel% neq 0 (
        echo Failed to run Windows Update script. Proceeding to next step.
    )
)

timeout /t 5
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
timeout /t 15
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

echo Function Check Master Script Completed.
timeout /t 3

:end_script
:: Stage 4
echo Is there anything else that needs done with the machine? [Y/N]
echo Press [S] to shutdown the computer ending the Functionality Check of the device
::as of 1/1/24 there are no further options to test devices, however I do plan on adding more in the future.

echo If there is no input from you, this script will automatically exit in 1 minute.

:: Set a timeout of 60 seconds (1 minute)
choice /C YNS /N /T 60 /D N /M "Select an option (Y/N/S): "

::/C YNS: Specifies the valid input keys (Y, N, and S).
::/N: Hides the list of choices in the prompt.
::/T 60: Sets the timeout to 60 seconds.
::/D N: Sets the default choice to 'N' if no key is pressed within the timeout period.
::/M "Select an option (Y/N/S): ": Displays a message to the user.

:: Check the selected option
if errorlevel 3 shutdown /s /f /t 0
if errorlevel 2 exit
if errorlevel 1 exit
