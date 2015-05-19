$(document).ready(function(){
    secondPlaylist = initSecondPlayList();
    mainPlayList  = initMyPlayList();

    $(document).on($.jPlayer.event.pause, mainPlayList.cssSelector.jPlayer,  function(){
        $('.musicbar').removeClass('animate');
        $('.jp-play-me').removeClass('active');
        $('.jp-play-me').parent('li').removeClass('active');
    });

    $(document).on($.jPlayer.event.play, mainPlayList.cssSelector.jPlayer,  function(e){
        $('.musicbar').addClass('animate');
        var index = mainPlayList.current;
        if(index != null && index >= 0){
            var song = mainPlayList.playlist[index];
            notifyMusic(song.title, song.artist);
        }
    });

    $(document).on('click', '.jp-play-me', function(e){
        e && e.preventDefault();
        var $this = $(e.target);
        if (!$this.is('a')) $this = $this.closest('a');

        $('.jp-play-me').not($this).removeClass('active');
        $('.jp-play-me').parent('li').not($this.parent('li')).removeClass('active');

        $this.toggleClass('active');
        $this.parent('li').toggleClass('active');
        if( !$this.hasClass('active') ){
            myPlaylist.pause();
        }else{
            var i = Math.floor(Math.random() * (1 + 7 - 1));
            myPlaylist.play(i);
        }

    });

    // video
    $("#jplayer_1").jPlayer({
        ready: function () {
            $(this).jPlayer("setMedia", {
                title: "Big Buck Bunny",
                m4v: "http://flatfull.com/themes/assets/video/big_buck_bunny_trailer.m4v",
                ogv: "http://flatfull.com/themes/assets/video/big_buck_bunny_trailer.ogv",
                webmv: "http://flatfull.com/themes/assets/video/big_buck_bunny_trailer.webm",
                poster: "images/m41.jpg"
            });
        },
        swfPath: "js",
        supplied: "webmv, ogv, m4v",
        size: {
            width: "100%",
            height: "auto",
            cssClass: "jp-video-360p"
        },
        globalVolume: true,
        smoothPlayBar: true,
        keyEnabled: true
    });

    if (location.hash.replace("#", "").length > 0){
        fetchDATA(location.hash.replace("#", ""), $('#content'), []);
    }

    // One page application
    $(window).bind('hashchange', function(){
        var hash = location.hash;
        hash = hash.replace("#", "");
        if (hash.length > 0){
            fetchDATA(hash, $('#content'));
        }
    });

    bindCommonAction();
});

function initMyPlayList(){
    var song_CamGiacBenAnh = {
        title:"Cảm Giác Bên Anh",
        artist:"Hải Băng",
        mp3: decodeURIComponent("http%3A%2F%2Fdata16.chiasenhac.com%2Fdownloads%2F1007%2F2%2F1006440-f14c07f8%2F320%2FDa%2520Khuc%2520-%2520Le%2520Quyen.mp3")
    };

    var myPlaylist = new jPlayerPlaylist({
        jPlayer: "#jplayer_N",
        cssSelectorAncestor: "#jp_container_N"
    },[
        song_CamGiacBenAnh
    ], {
        playlistOptions: {
            enableRemoveControls: true,
            autoPlay: true
        },
        swfPath: "js/jPlayer",
        supplied: "webmv, ogv, m4v, oga, mp3",
        wmode: "linux",
        solution: "html,flash",
        smoothPlayBar: true,
        keyEnabled: true,
        audioFullScreen: false
    });

    return myPlaylist;
}

function initSecondPlayList(){
    var secondPlaylist = new jPlayerPlaylist({
        jPlayer: "#jp_second",
        cssSelectorAncestor: "#second-jplayer"
    },[],{
        playlistOptions: {
            enableRemoveControls: true,
            autoPlay: true
        },
        swfPath: "js/jPlayer",
        supplied: "webmv, ogv, m4v, oga, mp3",
        smoothPlayBar: true,
        keyEnabled: true,
        audioFullScreen: false
    });

    return secondPlaylist;
}

function searchSubmit(){
    $('#searchIndicator').show();
    var data = {
      'search_name': $("input[name='search_name']").val().trim()
    };
    fetchDATA('search', $('#content'), data);
}

function fetchDATA(controllerPath, divTagert, data){
    $('#LoadingDiv').show();
    $('#main-content').css('opacity', '0.6');
    $.ajax({
        url: 'index.php?route=app/'+ controllerPath,
        type: 'get',
        data: data,
        dataType: 'html',
        beforeSend: function() {
            // TODO : before sending
        },
        complete: function() {
            // TODO : completed
        },
        success: function(html) {
            $('#searchIndicator').hide();
            $(divTagert).html(html);
        }
    });
}

function playSong(link, divSong){
    var data = {
        'link' : link
    };
    $.ajax({
        url: 'index.php?route=app/search/getsong',
        type: 'get',
        data: data,
        dataType: 'json',
        success: function(json) {
            var mp3file = json.song.link.substring("decodeURIComponent(".length + 1 , json.song.link.lastIndexOf(")") -1);
            var song = {
                title: "",
                artist: "",
                mp3: decodeURIComponent(mp3file)
            };
            secondPlaylist.add(song);
            secondPlaylist.play(0);
            bindCommonPlaySong(link, divSong);
        }
    });
}

function bindCommonPlaySong(link, divSong){
    mainPlayList.pause();
    $('.play-icon-a').closest('.item-overlay').removeClass('active');
    $('.play-icon-a').children('.fa-play').addClass('fa-play');
    $('.play-icon-a').children('.fa-play').removeClass('fa-pause');

    // this
    $(divSong).closest('.item-overlay').addClass('active');
    $(divSong).children('.fa-play').addClass('fa-pause');
    $(divSong).children('.fa-play').removeClass('fa-play');

    $(divSong).bind('click', function(){
        $(divSong).closest('.item-overlay').removeClass('active');
        $(divSong).children('.fa-play').removeClass('fa-pause');
        $(divSong).children('.fa-play').addClass('fa-play');
        secondPlaylist.pause();

        $(divSong).bind('click', function(){
            playSong(link, divSong);
        });
    });
}

function isExisted(playlist, song){
    if( playlist.playlist.indexOf(song) < 0){
        return false;
    }
    return true;
}

function bindCommonAction(song){
    var song_CamGiacBenAnh = {
        title:"Cảm Giác Bên Anh",
        artist:"Hải Băng",
        mp3: decodeURIComponent("http%3A%2F%2Fdata.yeucahat.com%2Fdownloads%2F105%2F4%2Fb978bc6ae05ad665213e1a3f89162c9d%2FCam%2520Giac%2520Ben%2520Anh%2520-%2520Hai%2520Bang%2520%2528www.YeuCaHat.com%2529.mp3")
    };

    function bindSendCondPlaylist(){
        $('.play-icon-a').bind('click', function(){
            mainPlayList.pause();
            $(this).closest('.item-overlay').addClass('active');
            $(this).children('.fa-play').addClass('fa-pause');
            $(this).children('.fa-play').removeClass('fa-play');
            $(this).bind('click', function(){
                $(this).children('.fa-pause').addClass('fa-play');
                $(this).children('.fa-pause').removeClass('fa-pause');
                $(this).closest('.item-overlay').removeClass('active');
                secondPlaylist.pause();
                bindSendCondPlaylist();
            });
            secondPlaylist.setPlaylist([
                song_CamGiacBenAnh
            ]);
            secondPlaylist.play(0);
        });
    }

    bindSendCondPlaylist();

    $('.plus-song').bind('click', function(){
        if(!isExisted(mainPlayList, song_CamGiacBenAnh)){
            mainPlayList.add(song_CamGiacBenAnh);
        }
    });
}

window.addEventListener('load', function () {
    // At first, let's check if we have permission for notification
    // If not, let's ask for it
    if (window.Notification && Notification.permission !== "granted") {
        Notification.requestPermission(function (status) {
            if (Notification.permission !== status) {
                Notification.permission = status;
            }
        });
    }
});

var notification = null;
function notifyMusic(title, artist){
    if (window.Notification && Notification.permission === "granted") {
        notification = new Notification("QuickMusic",{
            body : title + ' by ' + artist,
            icon : 'https://graph.facebook.com/819276394825557/picture?width=30'
        });
        notification.onshow = function(){
            setTimeout(function(){
                notification.close();
            }, 3000)
        }
    }
    // If the user hasn't told if he wants to be notified or not
    // Note: because of Chrome, we are not sure the permission property
    // is set, therefore it's unsafe to check for the "default" value.
    else if (window.Notification && Notification.permission !== "denied") {
        Notification.requestPermission(function (status) {
            if (Notification.permission !== status) {
                Notification.permission = status;
            }

            // If the user said okay
            if (status === "granted") {
                notification = new Notification("QuickMusic",{
                    body : title + ' by ' + artist
                });
                notification.onshow = function(){
                    setTimeout(function(){
                        notification.close();
                    }, 3000)
                }
            }

            // Otherwise, we can fallback to a regular modal alert
            else {
                alert("Hi!");
            }
        });
    }

    // If the user refuses to get notified
    else {
        // We can fallback to a regular modal alert
        alert("Hi!");
    }
}