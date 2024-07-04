@echo off
title PC Cleanup Utility by NMINHDUCIT

rem Function to draw progress bar
setlocal enabledelayedexpansion
set "progress_bar="
set "progress_char=#"

:draw_progress_bar
set /a "progress=%1"
set /a "max_progress=%2"
set /a "bar_size=20"
set /a "current_chars=(progress * bar_size) / max_progress"
set /a "remaining_chars=bar_size - current_chars"

set "progress_bar="
for /l %%i in (1,1,%current_chars%) do (
    set "progress_bar=!progress_bar!!progress_char!"
)
for /l %%i in (%current_chars%,1,%bar_size%) do (
    set "progress_bar=!progress_bar! "
)

rem Clear the previous line and show progress bar
cls
echo --------------------------------------------------------------------------------
echo PC Cleanup Utility
echo --------------------------------------------------------------------------------
echo.
echo Progress: [!progress_bar!] %1%%
echo.
echo Performing %2...
ping localhost -n 3 >nul
exit /b

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
call :draw_progress_bar 0 100
cls
echo --------------------------------------------------------------------------------
echo Delete Internet Cookies
echo --------------------------------------------------------------------------------
echo.
echo Deleting Cookies...
ping localhost -n 3 >nul
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 2
call :draw_progress_bar 100 100
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
call :draw_progress_bar 0 100
cls
echo --------------------------------------------------------------------------------
echo Delete Temporary Internet Files
echo --------------------------------------------------------------------------------
echo.
echo Deleting Temporary Internet Files...
ping localhost -n 3 >nul
RunDll32.exe InetCpl.cpl,ClearMyTracksByProcess 8
call :draw_progress_bar 100 100
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
call :draw_progress_bar 0 100
cls
echo --------------------------------------------------------------------------------
echo Disk Cleanup
echo --------------------------------------------------------------------------------
echo.
echo Running Disk Cleanup...
ping localhost -n 3 >nul

:: Cleanup actions with progress bar
call :draw_progress_bar 25 100
echo Deleting temporary files...
if exist "C:\WINDOWS\temp" (
    del /f /q "C:\WINDOWS\temp\*.*" >nul 2>&1
    call :draw_progress_bar 50 100
)
if exist "C:\WINDOWS\tmp" (
    del /f /q "C:\WINDOWS\tmp\*.*" >nul 2>&1
    call :draw_progress_bar 75 100
)
if exist "C:\tmp" (
    del /f /q "C:\tmp\*.*" >nul 2>&1
    call :draw_progress_bar 100 100
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

:: Additional cleanup tasks
if exist "C:\Windows\SoftwareDistribution" (
    echo Deleting files in C:\Windows\SoftwareDistribution...
    takeown /F "C:\Windows\SoftwareDistribution" /R /D Y >nul
    icacls "C:\Windows\SoftwareDistribution" /grant administrators:F /T >nul
    rd /s /q "C:\Windows\SoftwareDistribution"
    mkdir "C:\Windows\SoftwareDistribution"
    call :draw_progress_bar 25 100
)
if exist "C:\Windows\Prefetch" (
    echo Deleting files in C:\Windows\Prefetch...
    takeown /F "C:\Windows\Prefetch" /R /D Y >nul
    icacls "C:\Windows\Prefetch" /grant administrators:F /T >nul
    rd /s /q "C:\Windows\Prefetch"
    mkdir "C:\Windows\Prefetch"
    call :draw_progress_bar 50 100
)
if exist "C:\Windows\Temp" (
    echo Deleting files in C:\Windows\Temp...
    takeown /F "C:\Windows\Temp" /R /D Y >nul
    icacls "C:\Windows\Temp" /grant administrators:F /T >nul
    rd /s /q "C:\Windows\Temp"
    mkdir "C:\Windows\Temp"
    call :draw_progress_bar 75 100
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
call :draw_progress_bar 100 100
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
echo Thanks for using PC Cleanup Utility by NMINHDUCIT
ping localhost -n 3 >nul
exit

:endlocal
endlocal
exit /b
