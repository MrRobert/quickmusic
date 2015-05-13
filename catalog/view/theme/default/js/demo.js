$(document).ready(function(){

  var myPlaylist = new jPlayerPlaylist({
    jPlayer: "#jplayer_N",
    cssSelectorAncestor: "#jp_container_N"
  }, [
    {
      title:"Rồi Mai Thức Giấc",
      artist:"Bằng Kiều",
      mp3: decodeURIComponent("http%3A%2F%2Fdata5.chiasenhac.com%2Fdownloads%2F1003%2F4%2F1002677-aa57d9c9%2F128%2FRoi%2520Mai%2520Thuc%2520Giac%2520-%2520Bang%2520Kieu.mp3"),
      poster: "http://data.chiasenhac.com/data/cover/3/2088.jpg"
    },
    {
      title:"24h phép",
      artist:"Đan Nguyên",
      mp3: decodeURIComponent("http%3A%2F%2Fdata22.chiasenhac.com%2Fdownloads%2F1187%2F3%2F1186716-45e8644c%2F128%2F24%2520Gio%2520Phep%2520-%2520Dan%2520Nguyen.mp3"),
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
    smoothPlayBar: true,
    keyEnabled: true,
    audioFullScreen: false
  });
  
  $(document).on($.jPlayer.event.pause, myPlaylist.cssSelector.jPlayer,  function(){
    $('.musicbar').removeClass('animate');
    $('.jp-play-me').removeClass('active');
    $('.jp-play-me').parent('li').removeClass('active');
  });

  $(document).on($.jPlayer.event.play, myPlaylist.cssSelector.jPlayer,  function(){
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
        title: "Uptown Funk",
        m4v: decodeURIComponent("http%3A%2F%2Fdata26.chiasenhac.com%2Fdownloads%2F1425%2F3%2F1424357-33044a1c%2F128%2FUptown%2520Funk%2520-%2520Mark%2520Ronson_%2520Bruno%2520Mars.mp4"),
        poster: "http://data.chiasenhac.com/data/artist/88/87614.jpg"
      });
    },
    swfPath: "js",
    supplied: "webmv, ogv, m4v, mp4",
    size: {
      width: "100%",
      height: "auto",
      cssClass: "jp-video-360p"
    },
    globalVolume: true,
    smoothPlayBar: true,
    keyEnabled: true
  });


    // SECOND PLAY LIST

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
        mp3: decodeURIComponent("http%3A%2F%2Fdata.yeucahat.com%2Fdownloads%2F105%2F4%2Fb978bc6ae05ad665213e1a3f89162c9d%2FCam%2520Giac%2520Ben%2520Anh%2520-%2520Hai%2520Bang%2520%2528www.YeuCaHat.com%2529.mp3"),
    };

    bindSendCondPlaylist();

    function bindSendCondPlaylist(){
        $('.play-icon-a').bind('click', function(){
            myPlaylist.pause();
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

    $('.plus-song').bind('click', function(){
        if(!isExisted(myPlaylist, song_CamGiacBenAnh)){
            myPlaylist.add(song_CamGiacBenAnh);
        }
    });
    function isExisted(playlist, song){
        if( playlist.playlist.indexOf(song) < 0){
            return false;
        }
        return true;
    }
});