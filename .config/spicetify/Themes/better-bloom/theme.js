(function BetterBloom() {
  let styleSheet = document.createElement("style");
  if (!Spicetify.Player.data || !Spicetify.Platform) {
    setTimeout(BetterBloom, 100);
    return;
  }

  if (!Spicetify.CosmosAsync) {
    setTimeout(noControls, 10);
    return;
  }

  function setWindowHeight() {
    Spicetify.Platform.PlayerAPI._prefs
      .get({ key: "app.browser.zoom-level" })
      .then(async (value) => {
        const zoomLevel = value.entries["app.browser.zoom-level"].number;
        const zoomNum = Number(zoomLevel);

        const multiplier = zoomNum !== 0 ? zoomNum / 50 : 0;

        const isGlobalNav = document.querySelector(".Root__globalNav");
        const isWindows = Spicetify.Platform.PlatformData.os_name === "windows";

        const constant = 0.912872807;

        const base_width = 135;
        const final_width = base_width * constant ** multiplier;

        const base_height = 48;
        const final_height = base_height * Math.pow(1.1, multiplier);

        const padding_start = 4 * constant ** multiplier;
        const padding_end = 9 * constant ** multiplier;

        await Spicetify.CosmosAsync.post("sp://messages/v1/container/control", {
          type: "update_titlebar",
          height: final_height,
        });

        if (!isGlobalNav && isWindows) {
          styleSheet.innerText = `
          .main-topBar-container {
            padding-inline-end: ${padding_end}rem !important;
            padding-inline-start: ${padding_start}rem !important;
          }
          
          .spotify__container--is-desktop.spotify__os--is-windows .Root__globalNav {
            padding-inline: ${padding_start}rem ${padding_end}rem !important
          }`;
        }

        // update title bar to 48px
        if (!isGlobalNav) {
          styleSheet.innerText += `  
          .Root__main-view .main-topBar-container {
            top: calc(var(--panel-gap) / 2);
            height: calc(24px + var(--panel-gap) * 2);
            ${
              isWindows &&
              `padding-inline: ${padding_start}rem ${padding_end}rem !important`
            }

          }
          .main-topBar-container {
            position: fixed !important;
            backdrop-filter: none !important;
            left: 0;
            width: 100%;
            z-index: 5 !important;
            padding-inline-start: 5rem !important;
            opacity: 1 !important;
            justify-content: space-between !important;
          }
          `;
        } else {
          styleSheet.innerText += `
          .Root__globalNav {
            ${
              isWindows
                ? `padding-inline: ${padding_start}rem ${padding_end}rem !important`
                : `padding-inline-start: 5rem !important;`
            }
          }
          .main-topBar-container {
            ${!isWindows && `padding-inline-start: 5rem !important;`}
          }
        `;
        }

        if (
          isWindows &&
          Spicetify.Config.color_scheme !== "light" &&
          !document.querySelector(".Fullscreen")
        ) {
          document.documentElement.style.setProperty(
            "--control-width",
            `${final_width}px`
          );
          document.documentElement.style.setProperty(
            "--control-height",
            `${base_height}px`
          );
        }

        document.head.appendChild(styleSheet);
      });
  }

  window.addEventListener("resize", setWindowHeight);
  setWindowHeight(1);

  function cleanLabel(label) {
    const cleanedLabel = label.replace(/[{0}{1}«»”“]/g, "").trim();
    return cleanedLabel;
  }

  const { Locale } = Spicetify;
  if (!Locale) return;
  let playlistPlayLabel = Locale.get("playlist.a11y.play");
  playlistPlayLabel = cleanLabel(playlistPlayLabel);
  let playlistPauseLabel = Locale.get("playlist.a11y.pause");
  playlistPauseLabel = cleanLabel(playlistPauseLabel);

  const playLabel = Locale.get("play");
  const pauseLabel = Locale.get("pause");

  const browseLabel = Locale.get("browse");

  const addToLikedLabel = Locale.get(
    "web-player.aligned-curation.tooltips.add-to-liked-songs"
  );
  const addToPlaylistLabel = Locale.get(
    "web-player.aligned-curation.tooltips.add-to-playlist"
  );

  const skipForwardLabel = Locale.get("playback-control.skip-forward");
  const skipBackLabel = Locale.get("playback-control.skip-back");

  const whatsNewLabel = Locale.get("web-player.whats-new-feed.button-label");

  const friendsActivityLabel = Locale.get("buddy-feed.friend-activity");
  const tracklistPlayLabel = Locale.get("tracklist.a11y.play");

  const homeBtnLabelOne = Locale.get("view.web-player-home");

  let tracklistPlayLabelOne;
  let tracklistPlayLabelTwo;
  if (["zh-CN", "zh-TW", "am", "fi"].includes(Locale.getLocale())) {
    [tracklistPlayLabelOne, tracklistPlayLabelTwo] =
      tracklistPlayLabel.split("{1}");
  } else {
    [tracklistPlayLabelOne, tracklistPlayLabelTwo] =
      tracklistPlayLabel.split("{0}");
  }
  tracklistPlayLabelOne = cleanLabel(tracklistPlayLabelOne);
  tracklistPlayLabelTwo = cleanLabel(tracklistPlayLabelTwo);

  const ButtonStyles = document.createElement("style");
  ButtonStyles.innerHTML = `
  .main-playButton-button[aria-label*="${playLabel}"],
.main-playButton-PlayButton > button[aria-label*="${playLabel}"],
.main-playPauseButton-button[aria-label="${playLabel}"],
.main-playPauseButton-button[aria-label="${Locale.get(
    "playback-control.play"
  )}"],
.main-trackList-rowPlayPauseButton[aria-label*="${playLabel}"],
.main-trackList-rowImagePlayButton[aria-label*="${tracklistPlayLabelOne}"][aria-label*="${tracklistPlayLabelTwo}"],
.main-playButton-PlayButton > button[aria-label*="${playlistPlayLabel}"] {
  background-color: var(--spice-text) !important;
  -webkit-mask-image: url("https://sanooj.is-a.dev/better-bloom/assets/icons/play.svg") !important;
  mask-image: url("https://sanooj.is-a.dev/better-bloom/assets/icons/play.svg") !important;
}
.main-playButton-button[aria-label*="${pauseLabel}"],
.main-playButton-PlayButton > button[aria-label*="${pauseLabel}"],
.main-playPauseButton-button[aria-label*="${pauseLabel}"],
.main-playPauseButton-button[aria-label="${Locale.get(
    "playback-control.pause"
  )}"],
.main-trackList-rowPlayPauseButton[aria-label*="${pauseLabel}"],
.main-trackList-rowImagePlayButton[aria-label*="${pauseLabel}"],
.main-playButton-PlayButton > button[aria-label*="${playlistPauseLabel}"] {
  background-color: var(--spice-text) !important;
  -webkit-mask-image: url("https://sanooj.is-a.dev/better-bloom/assets/icons/pause.svg") !important;
  mask-image: url("https://sanooj.is-a.dev/better-bloom/assets/icons/pause.svg") !important;
}

.Root__globalNav
  button:is([aria-label="${Locale.get("search.a11y.clear-input")}"]) {
  background-color: transparent !important;
  border: none !important;
}

button[aria-label="${browseLabel}"] path {
  display: none !important;
}

button[aria-label="${browseLabel}"] svg {
  display: none;
  -webkit-mask-image: url("https://sanooj.is-a.dev/better-bloom/assets/icons/compass_outline.svg");
  mask-image: url("https://sanooj.is-a.dev/better-bloom/assets/icons/compass_outline.svg");
  background-color: var(--spice-subtext) !important;
  scale: 1.25;
}
.main-repeatButton-button[aria-label="${Locale.get(
    "playback-control.enable-repeat"
  )}"] ,
  .main-repeatButton-button[aria-label="${Locale.get(
    "playback-control.disable-repeat"
  )}"],
  .main-repeatButton-button[aria-label="${Locale.get(
    "playback-control.enable-repeat-one"
  )}"], {
  border: none;
  color: var(--spice-text);
  -webkit-mask-size: cover;
  mask-size: cover;
  -webkit-mask-repeat: no-repeat;
  mask-repeat: no-repeat;
  scale: 0.75 !important;
  background-color: var(--spice-text);
  color: var(--spice-subtext);
  svg {
    display: none;
  }
}

.main-playPauseButton-button,
button[aria-label="${addToLikedLabel}"],
button[aria-label="${addToPlaylistLabel}"],
.player-controls button[aria-label="${skipBackLabel}"],
.player-controls button[aria-label="${skipForwardLabel}"], {
  display: block;
  background-color: var(--spice-subtext);
  -webkit-mask-repeat: no-repeat;
  mask-repeat: no-repeat;
  -webkit-mask-size: cover;
  mask-size: cover;
  min-height: 1rem;
  min-width: 1rem;
  aspect-ratio: 1/1;
  border-radius: 0 !important;
  border: none !important;
  svg,
  span {
    display: none;
    visibility: hidden;
  }
}

button[aria-label="${addToLikedLabel}"] {
  -webkit-mask-image: url("https://sanooj.is-a.dev/better-bloom/assets/icons/heart-outline.svg");
  mask-image: url("https://sanooj.is-a.dev/better-bloom/assets/icons/heart-outline.svg") !important;
}
button[aria-label="${addToPlaylistLabel}"] {
  background-color: var(--spice-accent);
  -webkit-mask-image: url("https://sanooj.is-a.dev/better-bloom/assets/icons/heart.svg");
  mask-image: url("https://sanooj.is-a.dev/better-bloom/assets/icons/heart.svg") !important;
}

.player-controls button[aria-label="${skipBackLabel}"] {
  background-color: var(--spice-text);
  -webkit-mask-image: url("https://sanooj.is-a.dev/better-bloom/assets/icons/next.svg");
  mask-image: url("https://sanooj.is-a.dev/better-bloom/assets/icons/next.svg");
}
.player-controls button[aria-label="${skipForwardLabel}"] {
  background-color: var(--spice-text);
  -webkit-mask-image: url("https://sanooj.is-a.dev/better-bloom/assets/icons/prev.svg");
  mask-image: url("https://sanooj.is-a.dev/better-bloom/assets/icons/prev.svg");
}

button[aria-label="${friendsActivityLabel}"] > path,
button[aria-label="${whatsNewLabel}"] > path {
  display: none;
}

.main-actionButtons > div > button[aria-label="${whatsNewLabel}"] svg,
.main-actionButtons > button[aria-label="${whatsNewLabel}"] svg {
  background-color: var(--spice-subtext) !important;
  -webkit-mask-image: url("https://sanooj.is-a.dev/better-bloom/assets/icons/alert.svg");
  mask-image: url("https://sanooj.is-a.dev/better-bloom/assets/icons/alert.svg");
}
.main-actionButtons > div > button[aria-label="${friendsActivityLabel}"] svg,
.main-actionButtons > button[aria-label="${friendsActivityLabel}"] svg {
  background-color: var(--spice-subtext) !important;
  -webkit-mask-image: url("https://sanooj.is-a.dev/better-bloom/assets/icons/people-team.svg");
  mask-image: url("https://sanooj.is-a.dev/better-bloom/assets/icons/people-team.svg");
}

.main-yourLibraryX-navLink[aria-label="${homeBtnLabelOne}"] svg,
button[aria-label="${homeBtnLabelOne}"] svg {
  path {
    display: none !important;
  }
  mask-image: url("https://sanooj.is-a.dev/better-bloom/assets/icons/home-outline.svg");
  -webkit-mask-image: url("https://sanooj.is-a.dev/better-bloom/assets/icons/home-outline.svg");
  background-color: var(--spice-subtext) !important;
}


.main-yourLibraryX-navLink[aria-label="${homeBtnLabelOne}"].active svg,
.main-globalNav-navLinkActive[aria-label="${homeBtnLabelOne}"] svg {
  path {
    display: none !important;
  }
  mask-image: url("https://sanooj.is-a.dev/better-bloom/assets/icons/home-filled.svg");
  -webkit-mask-image: url("https://sanooj.is-a.dev/better-bloom/assets/icons/home-filled.svg");
  background-color: var(--spice-text) !important;
}

.main-yourLibraryX-navLink[aria-label="${homeBtnLabelOne}"].active svg{
  path {
    display: none !important;
  }
  background-color: var(--spice-accent) !important;
}
    `;
  document.head.appendChild(ButtonStyles);

  console.log("Better Bloom is running");

  function applyStyles() {
    // Apply predefined style properties directly
    document.documentElement.style.setProperty("--blur", "1.5rem");
    document.documentElement.style.setProperty("--satu", "90%");
    if (Spicetify.Config.color_scheme === "light") {
      document.documentElement.style.setProperty("--bright", "100%");
      document.documentElement.style.setProperty("--cont", "100%");
    } else {
      document.documentElement.style.setProperty("--cont", "80%");
      document.documentElement.style.setProperty("--bright", "50%");
    }
  }

  applyStyles();

  async function fetchFadeTime() {
    const response = await Spicetify.Platform.PlayerAPI._prefs.get({
      key: "audio.crossfade_v2",
    });
    let fadeTime = "0.4s";

    if (response.entries["audio.crossfade_v2"].bool) {
      const crossfadeTime = await Spicetify.Platform.PlayerAPI._prefs.get({
        key: "audio.crossfade.time_v2",
      });
      fadeTime = `${
        crossfadeTime.entries["audio.crossfade.time_v2"].number / 1000
      }s`;
    }

    document.documentElement.style.setProperty("--fade-time", fadeTime);
    console.log(`Fade Time: ${fadeTime}`);
  }

  function onSongChange() {
    fetchFadeTime();

    let bgImage = Spicetify.Player.data.item.metadata.image_url;
    if (bgImage.includes("spotify:image:")) {
      bgImage = bgImage.replace("spotify:image:", "https://i.scdn.co/image/");
    }

    // Updates the background based on current song
    document.documentElement.style.setProperty(
      "--image_url",
      `url("${bgImage}")`
    );
  }

  Spicetify.Player.addEventListener("songchange", onSongChange);
  onSongChange(); // Initial call to setup song change handling

  (function npvAmbience() {
    if (!(Spicetify.Player.data && document.head)) {
      setTimeout(npvAmbience, 10);
      return;
    }

    // Append Styling To Head
    const style = document.createElement("style");
    style.textContent = ` 
	aside[aria-label="Now playing view"] {
		--background-base: var(--spice-main) !important;
	}

	.main-nowPlayingView-gradient,
	.IkRGajTjItEFQkRMeH6v.f2UE9n5nZcbgZrGYTU3r {
		background: none !important;
	}

	.main-nowPlayingView-nowPlayingGrid .main-nowPlayingView-coverArtContainer:first-child ~ .main-nowPlayingView-coverArtContainer {
		width: 100%;
		filter: blur(3.5rem) saturate(2) brightness(50%) contrast(80%);
		position: absolute;
		left: 0;
		top: 0;
		padding-top: 48px;
		z-index: -1;
		opacity: 0;
		transition: opacity 0.5s;
	  }

	  .main-nowPlayingView-nowPlayingGrid .main-nowPlayingView-coverArtContainer:first-child ~ .main-nowPlayingView-coverArtContainer img {
		transition: opacity 0.5s ease 0s;
	  }

	  .main-nowPlayingView-nowPlayingGrid .main-nowPlayingView-coverArtContainer:first-child ~ .main-nowPlayingView-coverArtContainer .cover-art {
		background-color: unset;
		background-size: cover;
		transition: all 0.5s ease 0s;
	  }
	`;
    document.head.appendChild(style);

    // DOM Manipulation
    let coverArtClone;
    function waitForWidgetMounted() {
      const npvGrid = document.querySelector(
        ".main-nowPlayingView-nowPlayingGrid"
      );
      const coverArt = document.querySelector(
        ".main-nowPlayingView-coverArtContainer"
      );
      if (!(npvGrid && coverArt)) {
        setTimeout(waitForWidgetMounted, 300);
        return;
      }

      coverArtClone = coverArt.cloneNode(true);
      npvGrid.appendChild(coverArtClone);

      const imgContainer = coverArtClone.querySelector(".cover-art");
      imgContainer.style.backgroundImage = `url(${Spicetify.Player?.data?.item?.metadata?.image_xlarge_url})`;

      setTimeout(() => {
        coverArtClone.style.opacity = 1;
      }, 0);
    }

    (function attachObserver() {
      const rightSidebar = document.querySelector(".Root__right-sidebar");
      if (!rightSidebar) {
        setTimeout(attachObserver, 300);
        return;
      }
      waitForWidgetMounted();
      const observer = new MutationObserver((mutations) => {
        console.log("mutation observer invoked - right sidebar")
        mutations.forEach((mutation) => {
          console.log(mutation);
          if (mutation.addedNodes.length > 0) {
            const addedNodes = Array.from(mutation.addedNodes);
            const isNPV = addedNodes.some(
              (node) => node.ariaLabel && node.ariaLabel === "Now playing view"
            );
            if (isNPV) {
              waitForWidgetMounted();
            }
          }
        });
      });
      observer.observe(rightSidebar, { childList: true });
    })();

    // Event Listeners
    Spicetify.Player.addEventListener("songchange", function (e) {
      if (coverArtClone) {
        const imgContainer = coverArtClone.querySelector(".cover-art");
        const img = coverArtClone.querySelector("img");

        img.style.opacity = 0;
        setTimeout(() => {
          img.src = e.data.item.metadata.image_xlarge_url;
          img.style.opacity = 1;
          imgContainer.style.backgroundImage = `url(${e.data.item.metadata.image_xlarge_url})`;
        }, 500);
      }
    });
  })();
})();
