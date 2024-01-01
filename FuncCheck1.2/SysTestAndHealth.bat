
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
echo Dead Pixel Testing: Please open the 'DeadPixelTest.html' file in your browser and follow the instructions.
echo To switch between colors for the test, use the spacebar.
echo To stop the screen test, press 'q' or close the browser.
pause
echo Please press any key after completing the Dead Pixel Test...
start DeadPixelTest.html
pause

Echo Starting sound test 
setlocal EnableDelayedExpansion
echo Note: Internet connectivity is required for the sound test.

:: Define the list of YouTube links
set "links[0]=https://www.youtube.com/watch?v=Sagg08DrO5U"
set "links[1]=https://www.youtube.com/watch?v=dX_1B0w7Hzc"
set "links[2]=https://www.youtube.com/watch?v=WGN5xaQkFk0"
set "links[3]=https://www.youtube.com/watch?v=lI5w2QwdYik"
set "links[4]=https://www.youtube.com/watch?v=HR5zpFs7YpY"
set "links[5]=https://www.youtube.com/watch?v=OyDyOweu-PA"
set "links[6]=https://www.youtube.com/watch?v=DmeUuoxyt_E"
set "links[7]=https://www.youtube.com/watch?v=L_jWHffIx5E"
set "links[8]=https://www.youtube.com/watch?v=rog8ou-ZepE"
set "links[9]=https://www.youtube.com/watch?v=a01QQZyl-_I"
set "links[10]=https://www.youtube.com/watch?v=1LRKWIOJHDs"
set "links[11]=https://www.youtube.com/watch?v=mFl8nzZuExE"
set "links[12]=https://www.youtube.com/watch?v=vXYVfk7agqU"
set "links[13]=https://www.youtube.com/watch?v=Tjp8cj8Vzyo"
set "links[14]=https://www.youtube.com/watch?v=7BwxSHs9elk"
set "links[15]=https://www.youtube.com/watch?v=mO1oBfG59Xw"
set "links[16]=https://www.youtube.com/watch?v=a8vaVbT_lX0"
set "links[17]=https://www.youtube.com/watch?v=ydmPh4MXT3g"
set "links[18]=https://www.youtube.com/watch?v=HSy6fv-NzmY"
set "links[19]=https://www.youtube.com/watch?v=T_WSXXPQYeY"
set "links[20]=https://www.youtube.com/watch?v=ZmInkxbvlCs"
set "links[21]=https://www.youtube.com/watch?v=sYOUFGfK4bU"
set "links[22]=https://www.youtube.com/watch?v=cVsQLlk-T0s"
set "links[23]=https://www.youtube.com/watch?v=FaOSCASqLsE"
set "links[24]=https://www.youtube.com/watch?v=_jJiTcubp5E"
set "links[25]=https://www.youtube.com/watch?v=StjkKnPU3xY"
set "links[26]=https://www.youtube.com/watch?v=T3rXdeOvhNE"
set "links[27]=https://www.youtube.com/watch?v=Eax4oQb5p04"
set "links[28]=https://www.youtube.com/watch?v=yBLdQ1a4-JI"
set "links[29]=https://www.youtube.com/watch?v=0q6yphdZhUA"
set "links[30]=https://www.youtube.com/watch?v=0q6yphdZhUA"
set "links[31]=https://www.youtube.com/watch?v=989-7xsRLR4"
set "links[32]=https://www.youtube.com/watch?v=PWgvGjAhvIw"
set "links[33]=https://www.youtube.com/watch?v=mBw3qzf4s18"
set "links[34]=https://www.youtube.com/watch?v=mBw3qzf4s18"
set "links[35]=https://www.youtube.com/watch?v=BG6EtT-mReM"
set "links[36]=https://www.youtube.com/watch?v=BG6EtT-mReM"
set "links[37]=https://www.youtube.com/watch?v=0kr9hmOaLnI"
set "links[38]=https://www.youtube.com/watch?v=xUsOJrw5PJE"
set "links[39]=https://www.youtube.com/watch?v=lOfZLb33uCg"
set "links[40]=https://www.youtube.com/watch?v=V9AbeALNVkk"
set "links[41]=https://www.youtube.com/watch?v=I_2D8Eo15wE"
set "links[42]=https://www.youtube.com/watch?v=KQ6zr6kCPj8"
set "links[43]=https://www.youtube.com/watch?v=k85mRPqvMbE"
set "links[44]=https://www.youtube.com/watch?v=96NUsT-1k2A"
set "links[45]=https://www.youtube.com/watch?v=yIy9vjg-hjc"
set "links[46]=https://www.youtube.com/watch?v=79DijItQXMM"
set "links[47]=https://www.youtube.com/watch?v=BXlYuaycRbU"
set "links[48]=https://www.youtube.com/watch?v=cGufy1PAeTU"
set "links[49]=https://www.youtube.com/watch?v=wDgQdr8ZkTw"
set "links[50]=https://www.youtube.com/watch?v=LDU_Txk06tM"
set "links[51]=https://www.youtube.com/watch?v=MtN1YnoL46Q"
set "links[52]=https://www.youtube.com/watch?v=CsGYh8AacgY"
set "links[53]=https://www.youtube.com/watch?v=WPkMUU9tUqk"
set "links[54]=https://www.youtube.com/watch?v=E-xhxS581Uc"
set "links[55]=https://www.youtube.com/watch?v=L3In2u6H4AM"
set "links[56]=https://www.youtube.com/watch?v=mYBRTi8MM3c"
set "links[57]=https://www.youtube.com/watch?v=eN7dYDYfvVg"
set "links[58]=https://www.youtube.com/watch?v=I-sH53vXP2A"
set "links[59]=https://www.youtube.com/watch?v=dvgZkm1xWPE"
set "links[60]=https://www.youtube.com/watch?v=eBG7P-K-r1Y"
set "links[61]=https://www.youtube.com/watch?v=vc6vs-l5dkc"
set "links[62]=https://www.youtube.com/watch?v=ZHwVBirqD2s"
set "links[63]=https://www.youtube.com/watch?v=1VQ_3sBZEm0"
set "links[64]=https://www.youtube.com/watch?v=WM8bTdBs-cw"
set "links[65]=https://www.youtube.com/watch?v=uAE6Il6OTcs"
set "links[66]=https://www.youtube.com/watch?v=wImS498pYTM"
set "links[67]=https://www.youtube.com/watch?v=h4UqMyldS7Q"
set "links[68]=https://www.youtube.com/watch?v=Qm-f7r0SPiA"
set "links[69]=https://www.youtube.com/watch?v=MQO4Bj7mLns"


:: Generate a random number between 0 and 10
set /a "index=%random% %% 69"

:: Open the random link in the default web browser
start !links[%index%]!

pause

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
