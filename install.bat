@echo off
REM Script de instalación rápida para AppTV

echo.
echo ============================================
echo   AppTV - Instalación rápida
echo ============================================
echo.

echo [1/3] Instalando dependencias...
call npm install

if errorlevel 1 (
    echo Error durante la instalación de dependencias
    pause
    exit /b 1
)

echo.
echo [2/3] Dependencias instaladas correctamente
echo.

echo [3/3] Listo para comenzar!
echo.
echo Para iniciar el servidor de desarrollo, ejecuta:
echo   npm run dev
echo.
echo Para compilar para producción, ejecuta:
echo   npm run build
echo.

pause
