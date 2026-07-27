function validarVideoYouTube(url, descripcion) {
    const videoRegex = /[?&]v=([a-zA-Z0-9_-]{11})/;
    const playlistRegex = /[?&]list=([a-zA-Z0-9_-]+)/;

    const videoMatch = url.match(videoRegex);
    const playlistMatch = url.match(playlistRegex);

    if (!videoMatch && !playlistMatch) {
        alert("La URL ingresada no es válida (debe ser video o playlist de YouTube).");
        return;
    }

    alert("Contenido cargado con éxito.");
    localStorage.setItem('descripcionVideo', descripcion);
    localStorage.setItem('urlVideo', url);

    const videoId = videoMatch ? videoMatch[1] : null;
    const playlistId = playlistMatch ? playlistMatch[1] : null;

    reproducirContenido(videoId, playlistId);
}

function reproducirContenido(videoId, playlistId) {
    const onYouTubeIframeAPIReady = () => {
        let playerConfig = {
            height: 720,
            width: 1080,
            playerVars: {
                autoplay: 1,
                controls: 1
            },
            events: {
                'onReady': (event) => console.log("El reproductor está listo."),
                'onStateChange': (event) => {
                    if (event.data === YT.PlayerState.PLAYING) console.log("Reproduciendo...");
                    if (event.data === YT.PlayerState.PAUSED) console.log("Pausado.");
                    if (event.data === YT.PlayerState.ENDED) console.log("Finalizado.");
                }
            }
        };

        if (playlistId) {
            // Si hay playlist, reproducirla
            playerConfig.playerVars.listType = 'playlist';
            playerConfig.playerVars.list = playlistId;
            if (videoId) {
                playerConfig.playerVars.index = 0;
            }
        } else if (videoId) {
            // Solo video
            playerConfig.videoId = videoId;
        }

        new YT.Player('player', playerConfig);
    };

    if (window.YT && window.YT.Player) {
        onYouTubeIframeAPIReady();
    } else {
        window.onYouTubeIframeAPIReady = onYouTubeIframeAPIReady;
    }
}
