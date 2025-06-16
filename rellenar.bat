@echo off
setlocal enabledelayedexpansion

:: Cambia estas fechas como quieras
set "start=2025-05-07"
set "end=2025-06-15"

for /f %%A in ('powershell -command "([datetime]'%start%').ToString('yyyy-MM-dd')"') do set "current=%%A"

:loop
if "%current%" == "%end%" goto :done

:: Hacer 10 commits por día
for /L %%i in (1,1,10) do (
    echo Commit %%i del %current% >> log.txt
    git add log.txt
    set "GIT_COMMITTER_DATE=%current% 12:%%i0:00"
    set "GIT_AUTHOR_DATE=%current% 12:%%i0:00"
    git commit --date="%current% 12:%%i0:00" -m "Commit %%i del %current%"
)

:: Sumar un día usando PowerShell
for /f %%A in ('powershell -command "([datetime]'%current%').AddDays(1).ToString('yyyy-MM-dd')"') do set "current=%%A"
goto loop

:done
echo Listo!
