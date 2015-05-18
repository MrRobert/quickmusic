$(document).ready(function(){
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
    var myPlaylist = new jPlayerPlaylist({
        jPlayer: "#jplayer_N",
        cssSelectorAncestor: "#jp_container_N"
    }, [
        {
            title:"Feeling Good",
            artist:"Michael Bublé",
            mp3: decodeURIComponent("http%3A%2F%2Fdata18.chiasenhac.com%2Fdownloads%2F1062%2F5%2F1061057-3f99fbeb%2F320%2FNocturne%2520Da%2520Khuc_%2520-%2520Chau%2520Kiet%2520Luan.mp3"),
            poster: "http://data.chiasenhac.com/data/cover/3/2088.jpg"
        },
        {
            title:"Home",
            artist:"Michael Bublé",
            mp3: decodeURIComponent("http%3A%2F%2Fdata5.chiasenhac.com%2Fdownloads%2F1003%2F4%2F1002845-08e27a72%2F128%2FHome%2520-%2520Michael%2520Buble.mp3"),
            poster: "http://data.chiasenhac.com/data/cover/14/13733.jpg"
        },
        {
            title:"Hoạ Mi Hót Trong Mưa",
            artist:"Hồng Nhung",
            mp3: decodeURIComponent("http://dl7.mp3.zdn.vn/fsdd1131lwwjA/cec91defca43a6a4d13df2662ea109d4/5554c680/2015/03/16/3/c/3c2cbf9dc1863f4edbcb98ac59a3cc80.mp3"),
            poster: "http://data.chiasenhac.com/data/cover/3/2142.jpg"
        }
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

function searchSubmit(){
    var data = {
      'search_name': $("input[name='search_name']").val().trim()
    };
    fetchDATA('search', $('#content'), data);
}

function fetchDATA(controllerPath, divTagert, data){
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
            $(divTagert).html(html);
        }
    });
}

function isExisted(playlist, song){
    if( playlist.playlist.indexOf(song) < 0){
        return false;
    }
    return true;
}

function bindCommonAction(){
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