@echo off
cls

echo == Hardware Information ==
echo.

:: Combine hardware information queries
wmic cpu get Name,Manufacturer,NumberOfCores,NumberOfLogicalProcessors,MaxClockSpeed
wmic path win32_videocontroller get Name,DriverVersion
wmic MEMORYCHIP get BankLabel, Capacity, MemoryType, TypeDetail, Speed
wmic logicaldisk where drivetype=3 get DeviceID, Size, FreeSpace

echo.
echo == End of Hardware Information ==

@echo off
cls

:: Check Disk for Errors
echo Checking Disk for Errors...
chkdsk /f /r

:: Check and Repair Windows System Files
echo Checking and repairing Windows system files...
sfc /scannow

:: Check the Windows Image Health
echo Checking the Windows image health...
DISM /Online /Cleanup-Image /CheckHealth

:: Restore the Health of Windows Image if needed
echo Attempting to restore the health of the Windows image...
DISM /Online /Cleanup-Image /RestoreHealth

:: Optimize Drives
echo Optimizing Drives...
defrag /C /O /V

:: Fetch the Device's Serial Number
echo Fetching device's serial number...
wmic bios get serialnumber

pause


:: Step 2: Battery Health
echo.
echo Checking Battery Health...
powershell -Command "Get-WmiObject Win32_Battery | Select-Object DesignCapacity, FullChargeCapacity"
@echo off
echo System Hardware Health Check
echo ----------------------------

:: Hard Drive Health
echo.
echo Checking Hard Drive Health...
for /f "tokens=1,2" %%a in ('wmic diskdrive get deviceid^, status') do (
    if "%%b"=="OK" (
        echo %%a -> OK
    ) else if "%%b"=="" (
        echo.
    ) else (
        echo %%a -> Faulty (%%b)
    )
)

:: CPU Health
echo.
echo Checking CPU Health...
for /f "tokens=*" %%c in ('wmic cpu get status') do (
    if "%%c"=="OK" (
        echo CPU -> OK
    ) else if "%%c"=="" (
        echo.
    ) else (
        echo CPU -> Faulty (%%c)
    )
)

:: RAM Health
echo.
echo Checking RAM Health...
for /f "tokens=*" %%r in ('wmic memorychip get status') do (
    if "%%r"=="OK" (
        echo RAM -> OK
    ) else if "%%r"=="" (
        echo.
    ) else (
        echo RAM -> Faulty (%%r)
    )
)

:: Add similar sections for other hardware components as needed

echo.
echo Health Check Complete


:: Step 4: Storage Space
echo.
echo Checking Storage Space...
wmic logicaldisk get size,freespace,caption

echo.
pause

