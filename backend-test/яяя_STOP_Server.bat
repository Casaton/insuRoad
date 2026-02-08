@echo off
chcp 65001 >nul
taskkill /F /IM python.exe
taskkill /F /IM pythonw.exe

REM ---- Повідомлення про завершення ----
echo ===============================
echo ✔ Пайтон Сервер заТАСКкілилилилилилили
echo ФРОНТ на HTML+JS видасть щось по типу "Помилка з'єднання"
echo ===============================
timeout /t 5
rem pause