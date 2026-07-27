# ⚡ QUICKSTART - Comienza en 5 Minutos

## 🚀 Paso 1: Instalación (2 minutos)

### Opción A: Script Automático (Recomendado)

**Windows**:
```bash
install.bat
```

**Mac/Linux**:
```bash
bash install.sh
```

### Opción B: Manual

```bash
npm install
```

## ▶️ Paso 2: Ejecutar (1 minuto)

```bash
npm run dev
```

**Deberías ver**:
```
  🚀  ready in 456ms

  ➜  Local:    http://localhost:3000/
  ➜  Network:  http://192.168.x.x:3000/
```

## 🌐 Paso 3: Abrir en Navegador (30 segundos)

1. Abre tu navegador
2. Ve a: `http://localhost:3000`
3. Verás la página principal (sin video aún)

## 🎬 Paso 4: Cargar un Video (1.5 minutos)

1. Haz clic en el logo **"Clínica Colombia"** (esquina inferior izquierda)
2. Se abrirá el formulario en `/formulario`
3. Pega una URL de YouTube:
   - Ejemplo: `https://www.youtube.com/watch?v=dQw4w9WgXcQ`
   - O playlist: `https://www.youtube.com/playlist?list=PLxxxx`
4. Haz clic en "Cargar"
5. Espera 2 segundos para redirección
6. ¡Listo! El video debe aparecer en 4 segundos

## 📱 Acceso Desde Otro Dispositivo

Si quieres ver desde otra máquina en la misma red:

```bash
# Detén el servidor (Ctrl+C)
# Reinicia con:
npm run dev -- --host
```

Luego accede desde otro dispositivo con:
```
http://<IP-TU-MÁQUINA>:3000
```

Ejemplo: `http://192.168.1.100:3000`

## 🏗️ Compilar para Producción

```bash
npm run build
```

Esto crea una carpeta `dist/` con archivos listos para publicar.

## 📦 Estructura Rápida

```
src/pages/
├── index.astro           ← Página principal
└── formulario/
    └── index.astro       ← Formulario de videos

src/img/
├── olasClinica.png       ← Imagen decorativa
└── Clinica Colombia.jpg  ← Logo
```

## 🎯 Próximos Pasos

| Tarea | Archivo |
|-------|---------|
| Entender la migración | Leer [MIGRACION.md](MIGRACION.md) |
| Solucionar problemas | Leer [TROUBLESHOOTING.md](TROUBLESHOOTING.md) |
| Verificar todo | Revisar [CHECKLIST.md](CHECKLIST.md) |
| Usar en producción | Ver [README.md](README.md) |

## 💾 Datos Guardados

Los videos se guardan automáticamente en el navegador (localStorage).

Ver datos guardados:
1. Abre DevTools (F12)
2. Ve a "Application"
3. Abre "Storage" → "localStorage"
4. Busca `videoState`

Para borrar datos:
```javascript
// En la consola (F12):
localStorage.clear();
```

## 🆘 Algo No Funciona?

1. **Verifica que npm esté instalado**:
   ```bash
   npm --version
   ```

2. **Verifica que estés en la carpeta correcta**:
   ```bash
   pwd  # Mac/Linux
   cd   # Windows
   # Debe mostrar ruta que termina en "apptv-master-main"
   ```

3. **Limpiar e reinstalar**:
   ```bash
   rm -rf node_modules
   npm install
   npm run dev
   ```

4. **Buscar en [TROUBLESHOOTING.md](TROUBLESHOOTING.md)**

## ✅ Checklist

- [ ] Instalé dependencias (`npm install`)
- [ ] Ejecuté `npm run dev`
- [ ] Abri `http://localhost:3000`
- [ ] Cargué un video desde el formulario
- [ ] El video se muestra correctamente
- [ ] Actualicé la página y el video persiste
- [ ] Accedi desde otra máquina (opcional)

---

**¡Listo! Tu app Astro está corriendo. Ahora puedes compilar para producción o hacer cambios según necesites.**
