@echo off
setlocal enabledelayedexpansion

rem Fetch IP address from ipconfig
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /c:"IPv4 Address"') do (
    set "ipaddress=%%a"
)

rem Remove leading and trailing spaces from ipaddress variable
set "ipaddress=%ipaddress:~1%"

rem Start http-server in a new command window
start cmd /c "http-server \\%ipaddress%\e\movie\movie -p 8080"

rem Wait for the server to start
timeout /t 10 /nobreak >nul

rem Set up SSH tunnel
ssh -R 80:%ipaddress%:8080 nokey@localhost.run
