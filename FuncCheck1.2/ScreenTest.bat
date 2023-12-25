@echo off
cls

echo == Hardware Information ==

:: CPU Information
echo.
echo === CPU Information ===
wmic cpu get Name,Manufacturer,NumberOfCores,NumberOfLogicalProcessors,MaxClockSpeed
echo.

:: GPU Information
echo === GPU Information ===
wmic path win32_videocontroller get Name,DriverVersion
echo.

:: RAM Information
echo === RAM Information ===
wmic MEMORYCHIP get BankLabel, Capacity, MemoryType, TypeDetail, Speed
echo.

:: Storage Information
echo === Storage Information ===
wmic logicaldisk where drivetype=3 get DeviceID, Size, FreeSpace

echo.
echo == End of Hardware Information ==
pause



@echo off
cls

:: Check and Repair Windows System Files
echo Checking and repairing Windows system files...
sfc /scannow

:: Check the Windows Image Health
echo Checking the Windows image health...
DISM /Online /Cleanup-Image /CheckHealth

:: Restore the Health of Windows Image if needed
echo Attempting to restore the health of the Windows image...
DISM /Online /Cleanup-Image /RestoreHealth

:: Fetch the Device's Serial Number
echo Fetching device's serial number...
wmic bios get serialnumber

pause

@echo off
cls

:: Step 1: Dead Pixel Testing
echo Dead Pixel Testing: Open the HTML file in your browser and follow the instructions.
pause
start "Dead Pixel Test" /wait DeadPixelTest.html

:: Step 2: Battery Health
echo.
echo Checking Battery Health...
powershell -Command "Get-WmiObject Win32_Battery | Select-Object DesignCapacity, FullChargeCapacity"

:: Step 3: Hardware Health (S.M.A.R.T)
echo.
echo Checking Hard Drive Health...
for /f "tokens=2" %%a in ('wmic diskdrive get status') do (
    if "%%a"=="Status" (
        echo Device -> Status
    ) else (
        echo %%a -> OK
    )
)

:: Step 4: Storage Space
echo.
echo Checking Storage Space...
wmic logicaldisk get size,freespace,caption

echo.
pause

