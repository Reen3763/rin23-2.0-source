@echo off
setlocal
cd /d "%~dp0"
if not exist .env.json copy .env.example.json .env.json >nul
call flutter pub get
if errorlevel 1 exit /b 1
call flutter gen-l10n
if errorlevel 1 exit /b 1
call flutter build apk --release --target-platform android-arm64 --dart-define-from-file=.env.json
if errorlevel 1 exit /b 1
