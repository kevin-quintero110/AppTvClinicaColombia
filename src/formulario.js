import React, { useState } from "react";
import "./formulario.css";

const Formulario = () => {
  const [videoUrl, setVideoUrl] = useState("");
  const [mensaje, setMensaje] = useState("");

  // Función para extraer IDs de YouTube (video y playlist)
  const extraerDatosDeYoutube = (url) => {
    const videoRegex = /(?:youtube\.com\/.*v=|youtu\.be\/)([^&\n?#]+)/;
    const playlistRegex = /[?&]list=([a-zA-Z0-9_-]+)/;

    const videoMatch = url.match(videoRegex);
    const playlistMatch = url.match(playlistRegex);

    return {
      videoId: videoMatch ? videoMatch[1] : null,
      playlistId: playlistMatch ? playlistMatch[1] : null,
    };
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    const { videoId, playlistId } = extraerDatosDeYoutube(videoUrl);

    if (!videoId && !playlistId) {
      setMensaje("URL de YouTube no válida.");
      return;
    }

    try {
      const backendUrl = `${window.location.protocol}//${window.location.hostname}:5000/save-video-state`;
      const response = await fetch(backendUrl, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          videoId: videoId || null,
          playlistId: playlistId || null,
          imageSrc: null,
        }),
      });

      if (response.ok) {
        setMensaje("¡Video/Playlist guardado correctamente!");
        setVideoUrl("");
      } else {
        setMensaje("Error al guardar el video/playlist.");
      }
    } catch (error) {
      setMensaje("Error de conexión con el servidor.");
    }
  };

  return (
    <div className="container">
      <h1>Selecciona un Video o Playlist</h1>
      <form onSubmit={handleSubmit}>
        <input
          type="text"
          id="videoUrl"
          placeholder="Ingresa la URL de YouTube (video o playlist)"
          value={videoUrl}
          onChange={(e) => setVideoUrl(e.target.value)}
          required
        />
        <button id="btnCargaVideo" type="submit">
          Cargar
        </button>
      </form>
      {mensaje && <p>{mensaje}</p>}
    </div>
  );
};

export default Formulario;