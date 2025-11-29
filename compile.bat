@echo off
setlocal
cd /d "%~dp0"
docker compose run --rm latex bash -lc "bash /latex/tools/build.sh"
exit /b %ERRORLEVEL%
