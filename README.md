# AppTV – Clínica Colombia

Aplicación web diseñada para mostrar videos de YouTube en pantallas de TV y dispositivos conectados a la red local de **Clínica Colombia**. Ahora con **Astro** sin necesidad de backend.

---

## ✨ Características principales

- 📺 Visualización de un video de YouTube o playlist
- 🎬 Formulario intuitivo para cargar nuevos videos
- 🏥 Banner animado con el mensaje: **"Bienvenidos a Clínica Colombia"**, desplazándose horizontalmente en bucle
- 🌐 Compatible con Smart TVs, computadores y dispositivos móviles conectados a la misma red local
- ⚡ Sin backend - usa localStorage para guardar datos
- 📱 Totalmente responsive

---

## ⚙️ Instalación

1. **Abre la carpeta del proyecto:**
   ```bash
   cd apptv-master-main
   ```

2. **Instala las dependencias necesarias:**
   ```bash
   npm install
   ```

3. **Inicia el servidor de desarrollo:**
   ```bash
   npm run dev
   ```

   El servidor se ejecutará en `http://localhost:3000`

## 🚀 Uso de la aplicación

### Página principal
Accede desde cualquier dispositivo en la red local usando la IP del servidor:
```
http://<IP-del-servidor>:3000
```

### Cargar un nuevo video o playlist
1. Haz clic en el logo de la clínica
2. Pega la URL del video o playlist de YouTube
3. Haz clic en "Cargar"
4. Serás redirigido a la página principal donde verás el video en 4 segundos

Los datos se guardan automáticamente en el navegador (localStorage), no requiere backend.

## 🏗️ Estructura del proyecto

```
src/
├── pages/
│   ├── index.astro          # Página principal
│   └── formulario/
│       └── index.astro      # Formulario de carga de videos
├── styles/
│   ├── App.css              # Estilos principales
│   ├── formulario.css       # Estilos del formulario
│   └── index.css            # Estilos globales
└── img/
    ├── olasClinica.png
    └── Clinica Colombia.jpg

public/               # Assets estáticos
astro.config.mjs     # Configuración de Astro
package.json         # Dependencias del proyecto
```

## 🛠️ Tecnologías utilizadas

- **Astro** - Framework frontend moderno
- **JavaScript Vanilla** - Sin frameworks adicionales
- **CSS3** - Estilos responsivos y animaciones
- **localStorage** - Almacenamiento local en el navegador

## 📦 Scripts disponibles

- `npm run dev` - Inicia el servidor de desarrollo
- `npm run build` - Compila la aplicación para producción
- `npm run preview` - Visualiza la aplicación compilada

## 🚀 Deploy en producción

### Compilar para producción
```bash
npm run build
```

Esto generará una carpeta `dist/` lista para desplegar.

### Opciones de hosting
- **Vercel**: Con detección automática de Astro
- **Netlify**: Arrastra la carpeta `dist/` o conecta tu repositorio
- **GitHub Pages**: Configura GitHub Actions automáticamente
- **Cualquier servidor web**: Sirve los archivos estáticos de `dist/`

## 📌 Notas importantes

- El diseño está optimizado para pantallas grandes (Smart TVs)
- Los datos se guardan en el navegador del cliente
- No se requiere servidor backend
- La URL del video se carga automáticamente al cambiar de página

## 🔧 Cambios respecto a la versión anterior

✅ Migrado de React a Astro (menos dependencias)
✅ Eliminado backend Express (sin necesidad)
✅ Almacenamiento en localStorage (sin base de datos)
✅ Reducción significativa del tamaño del bundle
✅ Mejor rendimiento y rapidez de carga

## 📝 Licencia

Desarrollado para Clínica Colombia
