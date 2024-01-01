@echo off
cls

:: Function to show a simple progress indicator
:ShowProgress
setlocal
set /a "progress=0"
set "bar=--------------------------------------------------"
:progressLoop
if %progress% leq 50 (
    echo %bar:~0,%progress%>% & rem Update the bar length
    set /a "progress+=1"
    timeout /t 1 /nobreak >nul
    goto progressLoop
)
endlocal
goto :eof

:: User input function
:UserInput
echo Press 'y' to continue to the next script, 'n' to rerun this step, 'e' to exit the script.
set /p choice="Enter your choice: "
if /i "%choice%"=="y" goto :Continue
if /i "%choice%"=="n" goto :Rerun
if /i "%choice%"=="e" goto :Exit
echo Invalid choice. Please enter 'y', 'n', or 'e'.
goto :UserInput

:Continue
echo Continuing to the next script...
goto :eof

:Rerun
echo Rerunning the current script...
goto :eof

:Exit
echo Exiting the script...
exit

:: Run the PowerShell script for Windows Update
echo Running Windows Update script...
start /b powershell -ExecutionPolicy Bypass -File "WinUpdate.ps1"
call :ShowProgress
echo.
echo Windows Update script completed.
echo.
call :UserInput

:: Run the Batch script for System Test and Health
echo Running System Test and Health script...
start /b call "SysTestAndHealth.bat"
call :ShowProgress
echo.
echo System Test and Health script completed.
echo.
call :UserInput

:: Open Screen Test HTML file
echo Running Screen Test...
start "" "ScreenTest.html"
echo.
echo Screen Test will open in your default web browser.
echo.
call :UserInput
