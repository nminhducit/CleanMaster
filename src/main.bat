@echo off
title PC Cleanup Utility by NMINHDUCIT

:menu
cls
echo --------------------------------------------------------------------------------
echo PC Cleanup Utility
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
ping localhost -n 3 >nul
if exist "C:\WINDOWS\temp" del /f /q "C:\WINDOWS\temp\*.*" 2>nul
if exist "C:\WINDOWS\tmp" del /f /q "C:\WINDOWS\tmp\*.*" 2>nul
if exist "C:\tmp" del /f /q "C:\tmp\*.*" 2>nul
if exist "C:\temp" del /f /q "C:\temp\*.*" 2>nul
if exist "%temp%" del /f /q "%temp%\*.*" 2>nul
if exist "%tmp%" del /f /q "%tmp%\*.*" 2>nul
for /D %%G in ("%temp%\*") do rd /s /q "%%G" 2>nul
for /D %%G in ("%tmp%\*") do rd /s /q "%%G" 2>nul
if exist "C:\Windows\SoftwareDistribution" (
    echo Deleting files in C:\Windows\SoftwareDistribution...
    takeown /F "C:\Windows\SoftwareDistribution" /R /D Y >nul
    icacls "C:\Windows\SoftwareDistribution" /grant administrators:F /T >nul
    rd /s /q "C:\Windows\SoftwareDistribution"
    mkdir "C:\Windows\SoftwareDistribution"
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
ping localhost -n 3 >nul
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
ping localhost -n 4 >nul
goto menu

:exit
cls
echo Thanks for using PC Cleanup Utility by NMINHDUCIT Github
ping localhost -n 3 >nul
exit
