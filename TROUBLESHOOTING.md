# 🔧 Troubleshooting - Guía de Solución de Problemas

## 🚨 Problemas Comunes

### 1. "npm: comando no encontrado" o "npm no es reconocido"

**Síntoma**: Al ejecutar `npm install`, se obtiene error de que npm no existe.

**Solución**:
- Descarga e instala [Node.js](https://nodejs.org/) (incluye npm)
- Reinicia la terminal/CMD después de instalar
- Verifica con: `node --version` y `npm --version`

---

### 2. "Cannot find module 'astro'"

**Síntoma**: Error después de ejecutar `npm run dev`

**Solución**:
```bash
# Asegúrate de estar en el directorio correcto
cd apptv-master-main

# Elimina node_modules y reinstala
rm -r node_modules
npm install

# O en Windows:
rmdir /s /q node_modules
npm install
```

---

### 3. El puerto 3000 ya está en uso

**Síntoma**: Error "EADDRINUSE: address already in use :::3000"

**Solución (Windows)**:
```bash
# Encuentra el proceso que usa el puerto
netstat -ano | findstr :3000

# Mata el proceso (reemplaza 12345 con el PID)
taskkill /PID 12345 /F

# O usa otro puerto
npm run dev -- --port 3001
```

**Solución (Mac/Linux)**:
```bash
# Encuentra el proceso
lsof -i:3000

# Mata el proceso (reemplaza 12345 con el PID)
kill 12345

# O usa otro puerto
npm run dev -- --port 3001
```

---

### 4. El video no se carga / No aparece en la página

**Síntoma**: Página principal vacía, iframe no se ve

**Soluciones**:
1. **Verifica que cargase un video**:
   - Abre DevTools (F12)
   - Ve a Application → localStorage
   - Busca la clave `videoState`
   - Si no existe, ve a `/formulario` y carga un video

2. **Verifica que la URL sea válida**:
   - Copia la URL en la barra de direcciones
   - YouTube debe cargar el video
   - Si YouTube da error, la URL es inválida

3. **Espera 4 segundos**:
   - El iframe aparece después de 4 segundos
   - Espera sin recargar la página

4. **Comprueba la consola**:
   - F12 → Console
   - Busca errores (rojo)
   - Si hay errores de CORS, YouTube rechaza el embed

---

### 5. El formulario no guarda el video

**Síntoma**: Mensaje de error o no se guarda nada

**Soluciones**:
1. **Verifica que la URL sea de YouTube**:
   - `https://www.youtube.com/watch?v=...` ✅
   - `https://youtu.be/...` ✅
   - `https://www.youtube.com/playlist?list=...` ✅
   - Otras URLs ❌

2. **Comprueba localStorage**:
   - F12 → Application → Storage → localStorage
   - Debe existir la clave `videoState`

3. **Limpiar datos**:
   ```javascript
   // En la consola (F12):
   localStorage.clear();
   ```

4. **Verificar permisos**:
   - localStorage puede estar deshabilitado
   - Comprueba privacidad del navegador
   - Intenta en modo normal (no privado)

---

### 6. Las imágenes no se cargan

**Síntoma**: Placeholders en blanco donde deberían estar las imágenes ("olas" y "eslogan")

**Soluciones**:
1. **Verifica que las imágenes existan**:
   - `src/img/olasClinica.png` debe existir
   - `src/img/Clinica Colombia.jpg` debe existir
   - Si faltan, copy-pasta desde el backup

2. **Reinicia el servidor**:
   ```bash
   # Detén el servidor (Ctrl+C)
   # Reinicia
   npm run dev
   ```

3. **Revisa la consola** (F12):
   - Los errores indicarán qué imagen falta
   - Ruta correcta: debe ser relativa

---

### 7. Error al hacer build: "EACCES: permission denied"

**Síntoma**: Error de permisos al ejecutar `npm run build`

**Solución (Mac/Linux)**:
```bash
# Otorga permisos
chmod -R 755 .

# O intenta con sudo (cuidado)
sudo npm run build
```

---

### 8. La aplicación funciona en `localhost` pero no desde otra IP

**Síntoma**: `http://127.0.0.1:3000` funciona pero `http://192.168.x.x:3000` no

**Soluciones**:
1. **En desarrollo**:
   ```bash
   npm run dev -- --host
   ```
   Esto expone el servidor a toda la red local

2. **Zona de riesgo**: ⚠️ 
   - Esto hace la app accesible desde cualquier IP en tu red
   - Solo úsalo en redes de confianza

3. **Firewall**:
   - Espera a que Windows pregunte sobre permitir el puerto
   - Acepta la excepción de firewall

---

### 9. Errores de CORS en la consola

**Síntoma**: Mensaje "CORS policy" o "blocked by browser"

**Explicación**: 
- YouTube permite embeds desde cualquier sitio
- Si ves error CORS, es de otro recurso (no YouTube)

**Solución**:
- Ignora los errores CORS de YouTube
- Verifica que dominio está intentando acceder
- Si es tuyo, revisa la configuración de CORS

---

### 10. El banner no se anima

**Síntoma**: El banner inferior no se mueve, texto static

**Soluciones**:
1. **Recarga la página**: F5 o Ctrl+R
2. **Limpia caché**: Ctrl+Shift+Delete
3. **Verifica CSS**: F12 → Styles → busca "marquee"
4. **Reinicia servidor**: Ctrl+C, luego `npm run dev`

---

### 11. localStorage no persiste entre sesiones

**Síntoma**: Cierro el navegador y el video desaparece

**Nota**: Esto es **comportamiento normal** en:
- Modo incógnito/privado
- Navegador con caché limpio automáticamente
- Sesiones privadas

**Solución**:
- Usa modo normal (no privado)
- No limpies caché automáticamente
- Para persist permanente, usa base de datos

---

### 12. Necesito volver a React

**Si algo no funciona con Astro y necesitas volver a React**:

1. **Los archivos antiguos aún existen**:
   ```bash
   git checkout HEAD~1  # Si usas git
   # O restaura desde backup manual
   ```

2. **Características perdidas**:
   - React Router
   - Express backend
   - SQLite database
   
3. **Alternativa**: Ejecuta en paralelo:
   - En otra carpeta copia la versión anterior
   - Comparación lado a lado si es necesario

---

## 📞 Cuando Nada Funciona

### 1. Reset Limpio

```bash
# Windows
rmdir /s /q node_modules
del package-lock.json
npm install
npm run dev

# Mac/Linux
rm -rf node_modules
rm package-lock.json
npm install
npm run dev
```

### 2. Reinicia Todo

```bash
# Detén el servidor (Ctrl+C)
# Cierra todos los navegadores
# Reinicia tu computadora
# Ejecuta npm run dev nuevamente
```

### 3. Verifica Logs Completos

Cuando reportes un error, incluye:
- Versión de Node.js: `node --version`
- Versión de npm: `npm --version`
- Sistema operativo
- Mensaje de error completo
- Pasos para reproducir

---

## 🐛 Reportar Bugs

Si encuentras un problema que no está aquí:

1. **Verifica la consola** (F12)
2. **Copia todo el error** exactamente
3. **Describe los pasos** para reproducirlo
4. **Incluye tu sistema** (OS, navegador, versiones)
5. **Comparte logs** de la terminal

---

## 📚 Recursos Útiles

- [Documentación Astro](https://docs.astro.build)
- [YouTube Embed FAQ](https://developers.google.com/youtube/iframe_api_reference)
- [localStorage MDN](https://developer.mozilla.org/en-US/docs/Web/API/Window/localStorage)
- [Node.js Docs](https://nodejs.org/docs/)

---

**¿Aún tienes problema? Revisa el archivo MIGRACION.md o CHECKLIST.md para más contexto técnico.**
