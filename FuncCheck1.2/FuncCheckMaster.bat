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

:: Run the PowerShell script for Windows Update
echo Running Windows Update script...
start /b powershell -NoProfile -File "WinUpdate.ps1"
call :ShowProgress
echo.
echo Windows Update script completed.
echo.

:: Run the Batch script for System Test and Health
echo Running System Test and Health script...
start /b call "SysTestAndHealth.bat"
call :ShowProgress
echo.
echo System Test and Health script completed.
echo.

:: Open Screen Test HTML file
echo Running Screen Test...
start "" "ScreenTest.html"
echo.
echo Screen Test will open in your default web browser.
echo.
