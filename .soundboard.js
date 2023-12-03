
// This code loads the IFrame Player API code asynchronously.
var tag = document.createElement('script');

tag.src = "https://www.youtube.com/iframe_api";
var firstScriptTag = document.getElementsByTagName('script')[0];
firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

function onYouTubeIframeAPIReady() {
    console.log('ready')
    $('.sound').each(function(index) { newSound($(this)); })
};


function newSound(controller) {
    controller = $(controller)
    console.log(controller.text())

    // create a div to load the player
    var div = $('<div><div>')
    div.attr('id', controller.text())
    $('#players').append(div)

    var player = new YT.Player(controller.text(), {
        videoId: controller.attr('video'),
        height: '0',
        width: '0',
        playerVars: {
            loop: controller.attr('loop'),
            playsinline: 1,
            autoplay: false,
        },

        events: {
            'onReady': onPlayerReady,
            'onStateChange': onPlayerStateChange,
        },
    })

    function onPlayerReady(e) {
        //console.log('video ready');
        player.setPlaybackQuality("small");
        controller.click(function(e) {
            var state = player.getPlayerState()
            if (state == YT.PlayerState.PLAYING || state == YT.PlayerState.BUFFERING) {
                player.pauseVideo();
            } else {
                player.seekTo(0);
                player.playVideo();
            }
        });
    };

    function onPlayerStateChange(event) {
        // TODO update button state visualization
        // transition TO playing state
        if (event.data == YT.PlayerState.PLAYING) { console.log('started'); 
                controller.addClass('playing')
        } else {
                controller.removeClass('playing')
        }
    };
};

$(document).ready(function() {
    // https://developer.mozilla.org/en-US/docs/Web/API/Screen_Wake_Lock_API
    if ("wakeLock" in navigator) {
        // Create a reference for the Wake Lock.
        let wakeLock = navigator.wakeLock.request("screen");
        document.addEventListener("visibilitychange", async () => {
          if (wakeLock !== null && document.visibilityState === "visible") {
            wakeLock = await navigator.wakeLock.request("screen");
          }
        });
    }
});

