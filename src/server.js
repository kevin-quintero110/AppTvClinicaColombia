const express = require("express");
const cors = require("cors");
const path = require("path");
const fs = require("fs");
const os = require("os");

const app = express();
const PORT = 5000;

app.use(cors());
app.use(express.json());

// Ruta para guardar el estado (videoId o playlistId)
app.post("/save-video-state", (req, res) => {
  const { videoId, playlistId, imageSrc } = req.body;

  if (!videoId && !playlistId) {
    return res.status(400).json({ error: "Debe enviar videoId o playlistId." });
  }

  const data = {
    type: playlistId ? "playlist" : "video",
    videoId: videoId || null,
    playlistId: playlistId || null,
    imageSrc: imageSrc || null,
  };

  fs.writeFileSync(path.join(__dirname, "video-link.txt"), JSON.stringify(data), "utf8");
  res.status(200).json({ message: "Estado guardado correctamente.", data });
});

// Ruta para obtener el estado
app.get("/get-video-state", (req, res) => {
  const filePath = path.join(__dirname, "video-link.txt");
  if (fs.existsSync(filePath)) {
    try {
      const content = fs.readFileSync(filePath, "utf8");
      const data = JSON.parse(content);
      res.json(data);
    } catch (e) {
      res.json({ videoId: null, playlistId: null, imageSrc: null });
    }
  } else {
    res.json({ videoId: null, playlistId: null, imageSrc: null });
  }
});

// Obtener IP local
function getLocalIP() {
  const interfaces = os.networkInterfaces();
  for (const name of Object.keys(interfaces)) {
    for (const iface of interfaces[name]) {
      if (
        iface.family === "IPv4" &&
        !iface.internal &&
        (iface.address.startsWith("192.") || iface.address.startsWith("172.") || iface.address.startsWith("10."))
      ) {
        return iface.address;
      }
    }
  }
  return "localhost";
}

const localIP = getLocalIP();

app.listen(PORT, "0.0.0.0", () => {
  console.log("Servidor corriendo en:");
  console.log(`  → http://${localIP}:${PORT}`);
  console.log(`  → http://localhost:${PORT}`);
});