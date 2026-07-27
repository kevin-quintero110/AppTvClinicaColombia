class YouTubeAPI {
  constructor() {
    this.player = null;
  }

  loadYouTubeAPI() {
    if (!window.YT) {
      const tag = document.createElement("script");
      tag.src = "https://www.youtube.com/iframe_api";
      const firstScriptTag = document.getElementsByTagName("script")[0];
      firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

      // Esperar a que la API de YouTube esté lista
      window.onYouTubeIframeAPIReady = () => {
        console.log("API de YouTube cargada.");
        this.initPlayer();
      };
    } else {
      this.initPlayer();
    }
  }

  initPlayer() {
    const url = localStorage.getItem("youtubeUrl") || ""; // URL guardada
    const videoId = this.obtenerIdVideo(url);
    const playlistId = this.obtenerIdPlaylist(url);

    // Configuración dinámica según el tipo de contenido
    const config = {
      height: "720",
      width: "1080",
      events: {
        onReady: this.onPlayerReady,
        onStateChange: this.onPlayerStateChange.bind(this),
      },
    };

    if (playlistId) {
      // Si es playlist
      config.playerVars = {
        listType: "playlist",
        list: playlistId,
      };
    } else {
      // Si es video individual
      config.videoId = videoId || "dQw4w9WgXcQ"; // Video por defecto
    }

    this.player = new window.YT.Player("player", config);
  }

  onPlayerReady(event) {
    console.log("El reproductor está listo.");
  }

  onPlayerStateChange(event) {
    if (event.data === window.YT.PlayerState.PLAYING) {
      console.log("El video está reproduciéndose.");
    } else if (event.data === window.YT.PlayerState.PAUSED) {
      console.log("El video está pausado.");
    } else if (event.data === window.YT.PlayerState.ENDED) {
      console.log("El video ha terminado.");
      this.endVideo();
    }
  }

  endVideo() {
    console.log("El video ha terminado.");
    document.getElementById("btncarrusel")?.click();
  }

  // Extrae el ID del video
  obtenerIdVideo(url) {
    const regex =
      /^(https?:\/\/)?(www\.)?(youtube\.com\/watch\?v=|youtu\.be\/)([a-zA-Z0-9_-]{11})/;
    const match = url.match(regex);
    return match ? match[4] : null;
  }

  // Extrae el ID de la playlist
  obtenerIdPlaylist(url) {
    const regex = /[?&]list=([a-zA-Z0-9_-]+)/;
    const match = url.match(regex);
    return match ? match[1] : null;
  }
}

export default YouTubeAPI;