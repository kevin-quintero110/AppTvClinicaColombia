import React, { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
import olas from "../src/img/olasClinica.png";
import eslogan from "./img/Clinica Colombia.jpg";
import "./App.css";
import { cleanup } from "@testing-library/react";

function App() {
  const navigate = useNavigate();
  const [videoId, setVideoId] = useState(null);
  const [playlistId, setPlaylistId] = useState(null);
  const [imageSrc, setImageSrc] = useState(null);
  const [showVideo, setShowVideo] = useState(false); // Para mostrar el video después de 4s

  useEffect(() => {
    const fetchVideoState = async () => {
      try {
        const backendUrl = `${window.location.protocol}//${window.location.hostname}:5000/get-video-state`;
        const response = await fetch(backendUrl);
        const data = await response.json();

        if (data.videoId) setVideoId(data.videoId);
        if (data.playlistId) setPlaylistId(data.playlistId);
        if (data.imageSrc) setImageSrc(data.imageSrc);
      } catch (error) {
        console.error("Error al obtener el estado del video:", error);
      }
    };

    fetchVideoState();
  }, []);

  useEffect(() => {
    if (videoId || playlistId) {
      const timer = setTimeout(() => {
        setShowVideo(true);
      }, 4000); // Esperar 4 segundos antes de mostrar el iframe

      return () => clearTimeout(timer);
    }


  }, [videoId, playlistId]);

  const irAlFormulario = () => {
    navigate("/formulario");
  };

  return (
    <div className="App">
      {/* Logo que lleva al formulario */}
      <div
        className="logo-container"
      >
        <p className="irform"></p>
      </div>

      {/* Banner inferior animado */}
      <div className="welcome-banner">
        <div className="marquee-content">
          <span>Bienvenidos a Clínica Colombia Es</span>
          <span className="marquee-gap"></span>
          <span>Bienvenidos a Clínica Colombia Es</span>
          <span className="marquee-gap"></span>
          <span>Bienvenidos a Clínica Colombia Es</span>
        </div>
      </div>

      {/* Imagen de eslogan */}
      <div className="Cln"
        onClick={irAlFormulario}
        style={{ cursor: "pointer" }}
      >
        <img src={eslogan} alt="Eslogan Clínica Colombia" />

      </div>

      {/* Contenedor del video */}
      <div className="video-container">
        {showVideo && (videoId || playlistId) && (
          <iframe
            title="Video de YouTube"
            width="100%"
            height="100%"
            style={{ maxWidth: "100%", maxHeight: "100%" }}
            src={
              playlistId
                ? `https://www.youtube.com/embed/videoseries?list=${playlistId}&autoplay=1&enablejsapi=1`
                : `https://www.youtube.com/embed/${videoId}?autoplay=1&loop=1&playlist=${videoId}&mute=1&enablejsapi=1`
            }
            allow="autoplay; encrypted-media"
            allowFullScreen
          ></iframe>
        )}
      </div>



      {/* Contenedor de la imagen cargada */}
      <div className="image-container">
        {imageSrc && (
          <img
            src={imageSrc}
            alt="Imagen dinámica"
            style={{ width: "100%", maxWidth: "500px" }}
          />
        )}
      </div>

      {/* Imagen decorativa de olas */}
      <div className="olas-container">
        <img src={olas} alt="Olas" />
      </div>
    </div>
  );

}

export default App;
