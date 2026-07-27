#!/bin/bash

# Script de instalación rápida para AppTV

echo
echo "============================================"
echo "  AppTV - Instalación rápida"
echo "============================================"
echo

echo "[1/3] Instalando dependencias..."
npm install

if [ $? -ne 0 ]; then
    echo "Error durante la instalación de dependencias"
    exit 1
fi

echo
echo "[2/3] Dependencias instaladas correctamente"
echo

echo "[3/3] Listo para comenzar!"
echo
echo "Para iniciar el servidor de desarrollo, ejecuta:"
echo "  npm run dev"
echo
echo "Para compilar para producción, ejecuta:"
echo "  npm run build"
echo
