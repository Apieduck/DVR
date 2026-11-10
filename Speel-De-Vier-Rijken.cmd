@echo off
rem De Vier Rijken in een eigen venster. Zet dit bestand in dezelfde map als De-Vier-Rijken.html.
set "GAME=%~dp0De-Vier-Rijken.html"
rem heeft de browser er "De-Vier-Rijken (1).html" van gemaakt? Dan dat bestand nemen
if not exist "%GAME%" for %%f in ("%~dp0De-Vier-Rijken*.html") do set "GAME=%%~ff"
if not exist "%GAME%" (
  echo Zet dit bestand in dezelfde map als De-Vier-Rijken.html
  pause
  exit /b
)
rem een browser zoeken die een eigen spelvenster kan openen (Edge, Chrome of Brave)
set "B="
call :try "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe"
call :try "%ProgramFiles%\Microsoft\Edge\Application\msedge.exe"
call :try "%LOCALAPPDATA%\Microsoft\Edge\Application\msedge.exe"
call :try "%ProgramFiles%\Google\Chrome\Application\chrome.exe"
call :try "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe"
call :try "%LOCALAPPDATA%\Google\Chrome\Application\chrome.exe"
call :try "%ProgramFiles%\BraveSoftware\Brave-Browser\Application\brave.exe"
call :try "%LOCALAPPDATA%\BraveSoftware\Brave-Browser\Application\brave.exe"
rem niets gevonden: gewoon in de standaardbrowser openen
if not defined B goto plain
set "URL=file:///%GAME:\=/%"
start "" "%B%" --app="%URL%" --user-data-dir="%LOCALAPPDATA%\DeVierRijken" --force_high_performance_gpu --ignore-gpu-blocklist --enable-gpu-rasterization --disable-background-timer-throttling --disable-renderer-backgrounding --no-first-run --start-maximized
exit /b
:plain
start "" "%GAME%"
exit /b
:try
if defined B exit /b
if exist "%~1" set "B=%~1"
exit /b
