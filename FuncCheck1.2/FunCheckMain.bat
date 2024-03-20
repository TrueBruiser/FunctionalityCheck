@echo off
cls


                                                                               
echo ================================================================================================                    
echo " $$$$$$$$\                                   $$$$$$\  $$\                           $$\       " 
echo " $$  _____|                                 $$  __$$\ $$ |                          $$ |      "
echo " $$ |   $$\   $$\ $$$$$$$\   $$$$$$$\       $$ /  \__|$$$$$$$\   $$$$$$\   $$$$$$$\ $$ |  $$\ "
echo " $$$$$\ $$ |  $$ |$$  __$$\ $$  _____|      $$ |      $$  __$$\ $$  __$$\ $$  _____|$$ | $$  |"
echo " $$  __|$$ |  $$ |$$ |  $$ |$$ /            $$ |      $$ |  $$ |$$$$$$$$ | $$ /      $$$$$$  /" 
echo " $$ |   $$ |  $$ |$$ |  $$ |$$ |            $$ |  $$\ $$ |  $$ |$$   ____|$$ |      $$  _$$<  "
echo " $$ |   \$$$$$$  |$$ |  $$ |\$$$$$$$\       \$$$$$$  |$$ |  $$ |\$$$$$$$\ \$$$$$$$\ $$ | \$$\ "
echo " \__|    \______/ \__|  \__| \_______|       \______/ \__|  \__| \_______| \_______|\__|  \__|"
echo ================================================================================================                                                                                                                                                                                  
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

timeout /t 15

echo Starting Function Check Master Script

:winupdate_input
echo Do you want to run the Windows Update script? [Y/N/E]
choice /C YNE /N /T 30 /D Y /M "Run Windows Update script? [Y/N/E, default=Y after 30s]: "
if errorlevel 3 goto exit_script
if errorlevel 2 goto MSDefender_Options
if errorlevel 1 goto check_winupdate

:check_winupdate
:: Check Windows Update Status
echo Checking Windows Update Status...
for /f "delims=" %%i in ('PowerShell -Command "(Get-HotFix | Sort-Object InstalledOn -Descending | Select-Object -First 1).InstalledOn"') do set "LastUpdate=%%i"
for /f "delims=" %%i in ('PowerShell -Command "Get-Date -Format 'MM/dd/yyyy'"') do set "CurrentDate=%%i"
if "%LastUpdate%" neq "%CurrentDate%" (
    echo Windows updates were not installed today. Running update script...
    goto run_winupdate
) else (
    echo Windows updates are up to date. Skipping update script...
    goto MSDefender_Options
)


:run_winupdate
:: Run the PowerShell script for Windows Update
echo Running Windows Update script...
PowerShell -Command "Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process; & .\WinUpdate.ps1"
if %errorlevel% neq 0 (
    echo Error encountered, attempting to run with bypass...
    PowerShell -ExecutionPolicy Bypass -File ".\WinUpdate.ps1"
    if %errorlevel% neq 0 (
        echo Failed to run Windows Update script. Proceeding to next step.
        goto MSDefender_Options
    )
)
timeout /t 5
goto MSDefender_Options

:MSDefender_Options
::Microsoft Defender scan
echo Would you like to run a malware/malicious script scan on the system? [Y/N/E]
choice /C YNE /N /T 30 /D Y /M "Run Windows Defender Scan? [Y/N/E, default=Y after 30s]"
if errorlevel 3 goto exit_script
if errorlevel 2 goto run_sys_test
if errorlevel 1 goto MSDefender_Options

:MSDefender_Options
:: Run the PowerShell Script for MS Defender
PowerShell -Command "Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process; & .\MSDefender_Options.ps1" > "MSDefenderLog.txt" 2>&1
if %errorlevel% neq 0 (
    echo Error encountered running MS Defender Options script. Check MSDefenderLog.txt for details.
    echo Attempting to run with bypass...
    PowerShell -ExecutionPolicy Bypass -File ".\MSDefender_Options.ps1" >> "MSDefenderLog.txt" 2>&1
    if %errorlevel% neq 0 (
        echo Still failed to run MS Defender Scan after bypass attempt. Check MSDefenderLog.txt for details.
        echo Would you like to retry? [Y/N]
        choice /C YN /N /M "Retry? [Y/N]: "
        if errorlevel 2 goto sys_test_input
        if errorlevel 1 goto retry_defender_scan
    )
)

:retry_defender_scan
PowerShell -ExecutionPolicy Bypass -File ".\MSDefender_Options.ps1" >> "MSDefenderLog.txt" 2>&1
if %errorlevel% neq 0 (
    echo Unable to run MS Defender Scan after retry. Proceeding to the next step.
)


:end_script
echo MSDefender scan completed. Check logs for any errors.



:sys_test_input
echo Do you want to run the System Test and Health script? [Y/N/E]
choice /C YNE /N /T 30 /D Y /M "Run System Test and Health script? [Y/N/E, default=Y after 30s]: "
if errorlevel 3 goto exit_script
if errorlevel 2 goto screen_test_input
if errorlevel 1 goto run_sys_test

:run_sys_test
:: Stage 2
echo Running System Test and Health script...
call SysTestAndHealth.bat
timeout /t 15
goto screen_test_input

:screen_test_input
echo Do you want to run the Screen Test script? [Y/N/E]
choice /C YNE /N /T 30 /D Y /M "Run Screen Test script? [Y/N/E, default=Y after 30s]: "
if errorlevel 3 goto exit_script
if errorlevel 2 goto end_script
if errorlevel 1 goto run_screen_test

:run_screen_test
:: Stage 3
echo Running Screen Test...
call ScreenTest.bat
goto end_script

:end_script
:: Stage 4
echo Function Check Master Script Completed.
timeout /t 3

echo Is there anything else that needs done with the machine? [Y/N]
echo Press [S] to shutdown the computer ending the Functionality Check of the device
::as of 1/1/24 there are no further options to test devices, however I do plan on adding more in the future.

echo If there is no input from you, this script will automatically exit in 1 minute.

:: Set a timeout of 60 seconds (1 minute)
choice /C YNS /N /T 60 /D N /M "Select an option (Y/N/S): "

:: Check the selected option
if errorlevel 3 shutdown /s /f /t 0
if errorlevel 2 exit
if errorlevel 1 exit

:exit_script
echo Exiting script...
timeout /t 3
exit