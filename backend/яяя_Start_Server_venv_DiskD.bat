@echo off
chcp 65001 >nul
setlocal

REM ===============================
echo AppplA-insuRoad backend-test launcher
echo ===============================

REM ---- Шляхи ----
set VENV_DIR=D:\VENVS_DIR\AppplA_insuRoad_backend-test\.venv
rem set VENV_DIR=.venv

REM ---- Перевірка Python ----
python --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Python не знайдено. Встанови Python 3.9+ і додай в PATH.
    pause
    exit /b 1
)

REM ---- Створення віртуального середовища ----
if not exist "%VENV_DIR%" (
    echo 🔧 Створюю віртуальне середовище...
    python -m venv "%VENV_DIR%"
)

REM ---- Активація venv ----
echo 🔄 Активація віртуального середовища...
call "%VENV_DIR%\Scripts\activate.bat"

REM ---- Оновлення pip (ОДИН РАЗ, за бажанням) ----
if not exist "%VENV_DIR%\pip_upgraded.flag" (
    python -m pip install --upgrade pip
    echo done > "%VENV_DIR%\pip_upgraded.flag"
)

REM ---- Встановлення залежностей (ОДИН РАЗ) ----
if not exist "%VENV_DIR%\installed.flag" (
    pip install -r requirements.txt
    echo done > "%VENV_DIR%\installed.flag"
)

REM ---- Запуск сервера на 127.0.0.1:5000  ----
echo ▶ Запуск сервера на 127.0.0.1:5000
start "" /B pythonw.exe main.py

REM ---- Повідомлення про завершення ----
echo ===============================
echo ✔ Пайтон Сервер крутиться на http://127.0.0.1:5000
echo ❌ щоб стопанути серверас клікай  яяя_STOP_Server.bat
echo ===============================
pause
