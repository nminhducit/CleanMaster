@echo off
title CleanMaster by NMINHDUCIT
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Requesting administrative privileges...
    powershell -Command "Start-Process cmd -ArgumentList '/c %~s0 %*' -Verb RunAs"
    exit /b
)
mode con: cols=80 lines=20
@echo off
echo This is a cleanup script.
:menu
cls
echo --------------------------------------------------------------------------------
echo                            CleanMaster - Version 1.0
echo --------------------------------------------------------------------------------
echo.
echo Select a tool
echo =============
echo.
echo [1] Delete Internet Cookies
echo [2] Delete Temporary Internet Files
echo [3] Disk Cleanup
echo [4] Disk Defragment
echo [5] Exit
echo.
set /p op=Run: 
if %op%==1 goto delete_cookies
if %op%==2 goto delete_temp_files
if %op%==3 goto disk_cleanup
if %op%==4 goto disk_defrag
if %op%==5 goto exit
goto error

:delete_cookies
cls
echo --------------------------------------------------------------------------------
echo Delete Internet Cookies
echo --------------------------------------------------------------------------------
echo.
echo Deleting Cookies...
ping localhost -n 3 >nul
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 2
cls
echo --------------------------------------------------------------------------------
echo Delete Internet Cookies
echo --------------------------------------------------------------------------------
echo.
echo Cookies deleted.
echo.
echo Press any key to return to the menu. . .
pause >nul
goto menu

:delete_temp_files
cls
echo --------------------------------------------------------------------------------
echo Delete Temporary Internet Files
echo --------------------------------------------------------------------------------
echo.
echo Deleting Temporary Internet Files...
ping localhost -n 3 >nul
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 8
cls
echo --------------------------------------------------------------------------------
echo Delete Temporary Internet Files
echo --------------------------------------------------------------------------------
echo.
echo Temporary Internet Files deleted.
echo.
echo Press any key to return to the menu. . .
pause >nul
goto menu

:disk_cleanup
cls
echo --------------------------------------------------------------------------------
echo Disk Cleanup
echo --------------------------------------------------------------------------------
echo.
echo Running Disk Cleanup...
timeout /t 3 >nul

:: Cleanup actions
echo Deleting temporary files...
if exist "C:\WINDOWS\temp" (
    del /f /q "C:\WINDOWS\temp\*.*" >nul 2>&1
)
if exist "C:\WINDOWS\tmp" (
    del /f /q "C:\WINDOWS\tmp\*.*" >nul 2>&1
)
if exist "C:\tmp" (
    del /f /q "C:\tmp\*.*" >nul 2>&1
)
if exist "C:\temp" (
    del /f /q "C:\temp\*.*" >nul 2>&1
)
if exist "%temp%" (
    del /f /q "%temp%\*.*" >nul 2>&1
)
for /D %%G in ("%temp%\*") do (
    rd /s /q "%%G" >nul 2>&1
)
for /D %%G in ("%tmp%\*") do (
    rd /s /q "%%G" >nul 2>&1
)
if exist "C:\Windows\SoftwareDistribution" (
    echo Deleting files in C:\Windows\SoftwareDistribution...
    takeown /F "C:\Windows\SoftwareDistribution" /R /D Y >nul
    icacls "C:\Windows\SoftwareDistribution" /grant administrators:F /T >nul
    rd /s /q "C:\Windows\SoftwareDistribution"
    mkdir "C:\Windows\SoftwareDistribution"
)
if exist "C:\Windows\Prefetch" (
    echo Deleting files in C:\Windows\Prefetch...
    takeown /F "C:\Windows\Prefetch" /R /D Y >nul
    icacls "C:\Windows\Prefetch" /grant administrators:F /T >nul
    rd /s /q "C:\Windows\Prefetch"
    mkdir "C:\Windows\Prefetch"
)
if exist "C:\Windows\Temp" (
    echo Deleting files in C:\Windows\Temp...
    takeown /F "C:\Windows\Temp" /R /D Y >nul
    icacls "C:\Windows\Temp" /grant administrators:F /T >nul
    rd /s /q "C:\Windows\Temp"
    mkdir "C:\Windows\Temp"
)
set "user_temp=C:\Users\%USERNAME%\AppData\Local\Temp"
if exist "%user_temp%" (
    echo Deleting files in %user_temp%...
    rd /s /q "%user_temp%" >nul 2>&1
)

:: New Cleanup Areas
echo.
echo Do you want to delete Recycle Bin, Log files, and Event logs? (y/n)
set /p answer=Choice: 
if /i "%answer%"=="y" (
    echo Emptying Recycle Bin...
    rd /s /q %systemdrive%\$Recycle.Bin >nul 2>&1

    echo Deleting Windows Update Cache...
    rd /s /q %windir%\SoftwareDistribution\Download >nul 2>&1

    echo Deleting Windows Error Reporting files...
    rd /s /q %LOCALAPPDATA%\CrashDumps >nul 2>&1
    rd /s /q %LOCALAPPDATA%\Microsoft\Windows\WER\ReportQueue >nul 2>&1
    rd /s /q %LOCALAPPDATA%\Microsoft\Windows\WER\ReportArchive >nul 2>&1
    rd /s /q %LOCALAPPDATA%\Microsoft\Windows\WER\Temp >nul 2>&1

    echo Deleting Log files...
    del /f /s /q %windir%\Logs\* >nul 2>&1
    del /f /s /q %windir%\System32\LogFiles\* >nul 2>&1

    echo Clearing Event Logs...
    for /f "tokens=*" %%a in ('wevtutil el') do wevtutil cl "%%a" >nul 2>&1

    echo Deleting User Temp Internet Files...
    for /D %%d in (%systemdrive%\Users\*) do (
        if exist "%%d\AppData\Local\Microsoft\Windows\INetCache" (
            rd /s /q "%%d\AppData\Local\Microsoft\Windows\INetCache" >nul 2>&1
        )
    )
)

cls
echo --------------------------------------------------------------------------------
echo Disk Cleanup
echo --------------------------------------------------------------------------------
echo.
echo Disk Cleanup successful!
echo.
pause
goto menu

:disk_defrag
cls
echo --------------------------------------------------------------------------------
echo Disk Defragment
echo --------------------------------------------------------------------------------
echo.
echo Defragmenting hard disks...
timeout /t 3 >nul
defrag -c -v
cls
echo --------------------------------------------------------------------------------
echo Disk Defragment
echo --------------------------------------------------------------------------------
echo.
echo Disk Defrag successful!
echo.
pause
goto menu

:error
cls
echo Command not recognized.
timeout /t 4 >nul
goto menu

:exit
cls
echo Thanks for using CleanMaster by NMINHDUCIT
timeout /t 3 >nul
exit
