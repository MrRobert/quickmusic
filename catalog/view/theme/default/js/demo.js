$(document).ready(function(){
    mainPlayList  = initMyPlayList();
    $(document).on($.jPlayer.event.pause, mainPlayList.cssSelector.jPlayer,  function(){
        $('.musicbar').removeClass('animate');
        $('.jp-play-me').removeClass('active');
        $('.jp-play-me').parent('li').removeClass('active');
    });

    $(document).on($.jPlayer.event.play, mainPlayList.cssSelector.jPlayer,  function(){
        $('.musicbar').addClass('animate');
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
        fetchDATA(location.hash.replace("#", ""), $('#content'));
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
            artist:"Avicii",
            mp3: decodeURIComponent("http%3A%2F%2Fdata.chiasenhac.com%2Fdownloads%2F1491%2F4%2F1490424-d717712a%2F320%2FFeeling%2520Good%2520-%2520Avicii.mp3"),
            poster: "http://data.chiasenhac.com/data/cover/3/2088.jpg"
        },
        {
            title:"24h phép",
            artist:"Đan Nguyên",
            mp3: decodeURIComponent("http%3A%2F%2Fdata22.chiasenhac.com%2Fdownloads%2F1187%2F4%2F1186716-45e8644c%2F320%2F24%2520Gio%2520Phep%2520-%2520Dan%2520Nguyen.mp3"),
            poster: "http://data.chiasenhac.com/data/cover/14/13733.jpg"
        },
        {
            title:"Uptown Funk",
            artist:"Bruno Mars",
            mp3: decodeURIComponent("http%3A%2F%2Fdata2.chiasenhac.com%2Fdownloads%2F1442%2F3%2F1441969-5b93278b%2F128%2FUptown%2520Funk%2520-%2520Mark%2520Ronson_%2520Bruno%2520Mars.mp3"),
            poster: "http://data.chiasenhac.com/data/artist/88/87614.jpg"
        },
        {
            title:"Hoạ Mi Hót Trong Mưa",
            artist:"Hồng Nhung",
            mp3: decodeURIComponent("http%3A%2F%2Fdata5.chiasenhac.com%2Fdownloads%2F1003%2F3%2F1002284-f423cf9e%2F128%2FHoa%2520Mi%2520Hot%2520Trong%2520Mua%2520-%2520Hong%2520Nhung.mp3"),
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

function fetchDATA(controllerPath, divTagert){
    $.ajax({
        url: 'index.php?route=app/'+ controllerPath,
        type: 'get',
        data: '',
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
