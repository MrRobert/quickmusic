$(document).ready(function(){
    $('.playlist-menu').removeClass('active open');
    bindRightClickLeftColumn();
    $.ajaxSetup({ cache: true });
    $.getScript('//connect.facebook.net/en_US/sdk.js', function(){
        FB.init({
            appId: '651313361641726',
            version: 'v2.3' // or v2.0, v2.1, v2.0
        });
        $('#loginbutton,#feedbutton').removeAttr('disabled');
    });

    secondPlaylist = initSecondPlayList();
    mainPlayList  = initMyPlayList();

    $('#jp_container_N').on($.jPlayer.event.pause, mainPlayList.cssSelector.jPlayer,  function(){
        $('.musicbar').removeClass('animate');
        $('.jp-play-me').removeClass('active');
        $('.jp-play-me').parent('li').removeClass('active');
    });

    $('#jp_container_N').on($.jPlayer.event.play, mainPlayList.cssSelector.jPlayer,  function(e){
        $('.musicbar').addClass('animate');
        var index = mainPlayList.current;
        if(index != null && index >= 0){
            var song = mainPlayList.playlist[index];
            notifyMusic(song.title, song.artist);
        }
    });

    $('#jp_container_N').on($.jPlayer.event.playing , mainPlayList.cssSelector.jPlayer,  function(e){
        isMainPlaying = true;
    });
    $('#jp_container_N').on($.jPlayer.event.ended , mainPlayList.cssSelector.jPlayer,  function(e){
        isMainPlaying = false;
    });

    $('#jp_second').bind($.jPlayer.event.playing, function(event) {
        isSecondPlaying = true;
        var index = secondPlaylist.current;
        $('.playIcon').show();
        $('.pauseIcon').addClass('hidden');
        $('.play'+index).hide();
        $('.pause'+index).removeClass('hidden');
        $('#liCollapse' + index).collapse('show');
    });
    $('#jp_second').bind($.jPlayer.event.ended, function(e) {
        isSecondPlaying = false;
        var index = parseInt(secondPlaylist.current);
        $('#liCollapse' + index).collapse('hide');
        if(index == secondPlaylist.playlist.length - 1){
            $('.playIcon').show();
            $('.pauseIcon').addClass('hidden');
        }else{
            var src = $('#songImg'+ index + 1).val();
            $('#mainImg').attr('src', src);
            secondPlaylist.play(index + 1);
        }
        updateHeight();
    });
    $('#jp_container_N').on('click', '.jp-play-me', function(e){
        e && e.preventDefault();
        var $this = $(e.target);
        if (!$this.is('a')) $this = $this.closest('a');

        $('.jp-play-me').not($this).removeClass('active');
        $('.jp-play-me').parent('li').not($this.parent('li')).removeClass('active');

        $this.toggleClass('active');
        $this.parent('li').toggleClass('active');
        if( !$this.hasClass('active') ){
            mainPlayList.pause();
        }else{
            var i = Math.floor(Math.random() * (1 + 7 - 1));
            mainPlayList.play(i);
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

    var currentHash = location.hash.replace("#", "");
    if (currentHash.length > 0 && isHasLoad){
        listenCommonRequest(currentHash);
    }
    // One page application
    $(window).on('hashchange', function(){
        var hash = location.hash;
        listenCommonRequest(hash);
    });

    bindCommonAction();

    $('#albumCarousel').bind('slide.bs.carousel', function (e) {
        if($('#albumTitle').html() == 'Hot Albums UK'){
            $('#albumTitle').html('Hot Albums VN');
        }else{
            $('#albumTitle').html('Hot Albums UK');
        }
    });

    $('#albumCarousel').carousel({
        interval: 10000
    });
});

function listenCommonRequest(hash){
    hash = hash.replace("#", "");
    var temp = hash.split('/');
    hash = temp[0];
    var data = {};
    if(temp.length > 2){
        if(hash == 'search'){
            data.search_name = temp[2];
            $("#header input[name='search_name']").val(temp[2].split('+').join(' ').toString());
            $("#header input[name='search_name']").focus();
            $('#searchIndicator').show();
        }
    }
    if (hash.length > 0){
        if(hash == 'music' || hash == 'favorite' || hash == 'film'){
            fetchDATA(hash, $('#content'), data);
        }else if(hash == 'search' && isHasLoad){
            if(temp[1] == 'singer'){
                $('#headerSearchIcon').removeClass('fa-youtube');
                $('#headerSearchIcon').addClass('fa-music');
                fetchDATA(hash, $('#content'), data);
            }else if(temp[1] == 'video'){
                $('#headerSearchIcon').removeClass('fa-music');
                $('#headerSearchIcon').addClass('fa-youtube');
                searchSubmit();
            }
        }else if (hash == 'song'){
            if(isHasLoad){
                var keyword = temp[1].substring(temp[1].lastIndexOf('_')+1);
                gotoSongGET(keyword);
            }
        }else if(hash == 'playlist'){
            if(isHasLoad){
                var arrPath = temp[1].split('-');
                if(arrPath.length > 1){
                    data.pl_id = window.atob(arrPath[1]);
                    fetchDATA(hash, $('#content'), data);
                }
            }
        }else if(hash == 'video'){
            if(temp[1] != null && temp[1].length > 0){
                data.videoId = temp[1];
                fetchDATA('video/playlist', $('#content'), data);
            }else{
                fetchDATA(hash, $('#content'), data);
            }
        }
    }
    isHasLoad = true;
}

function initMyPlayList(){
    var song_CamGiacBenAnh = {
        title:"Cảm Giác Bên Anh",
        artist:"Hải Băng",
        mp3: ''
    };

    var myPlaylist = new jPlayerPlaylist({
        jPlayer: "#jplayer_N",
        cssSelectorAncestor: "#jp_container_N"
    },[
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
    var searchType = ($('#headerSearchIcon').hasClass('fa-music'))? 'music' : 'video';
    var searchName = $("input[name='search_name']").val().trim();
    if(searchType == 'music'){
        window.location.hash = "#search/singer/" + searchName.split(' ').join('+').toString();
    }else if(searchType == 'video'){
        var searchObject = {
            q : searchName,
            part: 'snippet',
            maxResults: 30,
            key : 'AIzaSyDiAj-zEn_yqElnlvpwlGIanJGVZ5lhJII'
        };
        if(searchName == 'DuaLeo'){
            searchObject.channelId = 'UCpdQX3whRd61cgzjBXISFRQ';
        }else if(searchName == 'VitaminK'){
            searchObject.channelId = 'UCY6w7yucQDnJJ40x6_urpkg';
        }
        // TODO: more here

        $.get('index.php?route=app/video/searchlist', function(html){
            $.get("https://www.googleapis.com/youtube/v3/search", searchObject , function(response){
                    window.currentListVideoSearch = (response != undefined)? response.items : '';
                    $('#content').html(html);
                    bindDataToSearchVideo(response.items);
                    updateVideoHeight();
                    $('#searchIndicator').hide();
                }
            );
        });
        window.location.hash = "#search/video/"+ searchName;
        isHasLoad = false;
    }
    $('#searchIndicator').show();
}

function bindDataToSearchVideo(json){
    var html = '';
    for(var i= 0; i < json.length; i++){
        html+= '<div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">';
        html+= '<div class="item-song">';
        html+= '<div class="pos-relative">';
        html+= '<div class="bottom"></div>';
        html+= '<div class="item-overlay opacity r r-2x bg-black">';
        html+= '<div class="center text-center m-t-n">';
        html+= '<a onclick="gotoVideoItem(\''+ json[i].id.videoId + '\', \'gotoVideoItem\')" href="javascript:;" class="play-icon-a"><i class="fa fa-play fa-2x"></i></a>';
        html+= '</div></div>';
        html+= '<a href="javascript:void(0);">';
        html+= '<img class="r r-2x img-full" alt="" src="'+ json[i].snippet.thumbnails.default.url +'">';
        html+= '</a>';
        html+= '</div>';
        html+= '<div class="padder-v"><a class="text-ellipsis" href="javascript:;">'+ json[i].snippet.title +'</a>';
        html+= '</div></div></div>';
    }
    $('#videoContainer').html(html);
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
            if(controllerPath == 'album'){
                isHasLoad = false;
                window.location.hash = "#album/" + $('#albumQuery').val();
            }
        }
    });
}

function gotoSongGET(keyword){
    var data = {
        'keyword' : keyword,
    };
    $.ajax({
        url: 'index.php?route=app/song',
        type: 'get',
        data: data,
        dataType: 'html',
        success: function(html) {
            $('#content').html(html);
            FB.XFBML.parse();
        }
    });
}

function gotoSong(link, index, prefix){
    var title= $('#title_'+ prefix + index).html();
    var artis = $('#artis_'+ prefix + index).html();
    var data = {
        'link' : link,
        'title' :  title,
        'img_src' : window.btoa($('#img_'+ prefix + index).attr('src')),
        'artist' : artis
    };
    $.ajax({
        url: 'index.php?route=app/song',
        type: 'post',
        data: data,
        dataType: 'html',
        success: function(html) {
            $('#content').html(html);
            isHasLoad = false;
            window.location.hash = "#song/" + foldToAssci(title+artis) + "_" + $('#keyword').val();
            FB.XFBML.parse();
        }
    });
}

function foldToAssci(input){
    var orgin = [
        'à','á','ả','ã','ạ','â','ầ','ấ','ẩ','ẫ','ậ',
        'À','Á','Ả','Ã','Ạ','Â','Ầ','Ấ','Ẩ','Ẫ','Ậ',
        'ằ','ắ','ẳ','ẵ','ặ','ă',
        'Ằ','Ắ','Ẳ','Ẵ','Ặ','Ă',
        'đ', 'Đ',
        'è','é','ẻ','ẽ','ẹ','ê','ề','ế','ể','ễ','ệ',
        'È','É','Ẻ','Ẽ','Ẹ','Ê','Ề','Ế','Ể','Ễ','Ệ',
        'ì','í','ỉ','ị','ĩ',
        'Ì','Í','Ỉ','Ị','Ĩ',
        'ò','ó','ỏ','õ','ọ','ô','ồ','ố','ổ','ỗ','ộ','ơ','ờ','ớ','ở','ỡ','ợ',
        'Ò','Ó','Ỏ','Õ','Ọ','Ô','Ồ','Ố','Ổ','Ỗ','Ộ','Ơ','Ờ','Ớ','Ở','Ỡ','Ợ',
        'ù','ú','ủ','ũ','ụ','ừ','ứ','ử','ữ','ự','ư',
        'Ù','Ú','Ủ','Ũ','Ụ','Ừ','Ứ','Ử','Ữ','Ự','Ư',
        'ỳ','ý','ỷ','ỵ',
        'Ỳ','Ý','Ỷ','Ỵ',
        ';',',','`','?','~','/'
    ];
    var transalte = [
        'a','a','a','a','a','a','a','a','a','a','a',
        'A','A','A','A','A','A','A','A','A','A','A',
        'a','a','a','a','a',
        'A','A','A','A','A',
        'd','D',
        'e','e','e','e','e','e','e','e','e','e','e',
        'E','E','E','E','E','E','E','E','E','E','E',
        'i','i','i','i','i',
        'I','I','I','I','I',
        'o','o','o','o','o','o','o','o','o','o','o','o','o','o','o','o','o',
        'O','O','O','O','O','O','O','O','O','O','O','O','O','O','O','O','O',
        'u','u','u','u','u','u','u','u','u','u','u',
        'U','U','U','U','U','U','U','U','U','U','U',
        'y','y','y','y',
        'Y','Y','Y','Y',
        '','','','','',''
    ];
    var output='';
    for(var i=0; i<input.length; i++){
        var char = input[i];
        var index = orgin.indexOf(char);
        if( index >= 0){
            char = transalte[index];
        }else if(char == ' '){
            char = '-';
        }
        output+= char;
    }
    return output;
}

function playSongFavorite(index){
    var src = $('#songImg'+index).val();
    $('#mainImg').attr('src', src);
    var currentIndex = secondPlaylist.current;

    if($('.pause'+index).hasClass('hidden')){
        if(currentIndex + '' == index + ''){
            secondPlaylist.play();
        }else{
            secondPlaylist.play(index);
        }
        $('.playIcon').show();
        $('.pauseIcon').addClass('hidden');
        $('.play'+index).hide();
        $('.pause'+index).removeClass('hidden');
    }else{
        secondPlaylist.pause();
        $('.playIcon').show();
        $('.pauseIcon').addClass('hidden');
        $('.play'+index).show();
        $('.pause'+index).addClass('hidden');
    }
    $('#liCollapse' + index).collapse('show');
    updateHeight();
}

function playSong(link, ePlay){
    $('#second-jplayer').jPlayer("stop");
    if($(ePlay).find('#pause_icon').hasClass('hidden')){
        if(secondPlaylist.playlist.length > 0){
            secondPlaylist.play();
        }else{
            var song = {
                title: "",
                artist: "",
                mp3: "index.php?route=app/search/playsong&src=" + link
            };
            secondPlaylist.pause();
            secondPlaylist.playlist.splice(0,1);
            secondPlaylist.add(song);
            secondPlaylist.play(0);
            mainPlayList.pause();
        }
        $(ePlay).find('#play_icon').hide();
        $(ePlay).find('#pause_icon').removeClass('hidden');
    }else{
        pauseSong(ePlay);
    }
}

function pauseSong(ePlay){
    $(ePlay).find('#play_icon').show();
    $(ePlay).find('#pause_icon').addClass('hidden');
    secondPlaylist.pause();
}

function loadSongForMainPlaylist(song, index){
    var data = {
        'link' : song.mp3
    };
    $.ajax({
        url: 'index.php?route=app/search/getsong',
        type: 'get',
        data: data,
        dataType: 'json',
        success: function(json) {
            var mp3file = json[0].linkSong;
            mainPlayList.playlist[index].mp3 = "index.php?route=app/search/playsong&src=" + mp3file;
            mainPlayList.playlist[index].isFirstPlaying = false;
            playingIndex = true;
            mainPlayList.play(index);
        }
    });
}

function isExisted(playlist, link){
    if(playlist.playlist.length < 0) return true;
    for(var i=0; i< playlist.playlist.length; i++){
        if(playlist.playlist[i].mp3 == link){
            return true;
        }
    }
    return false;
}

function bindCommonAction(){
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
            secondPlaylist.setPlaylist([]);
            secondPlaylist.play(0);
        });
    }

    bindSendCondPlaylist();
}
function plusSong(link, title, artist, index){
    if(!isExisted(mainPlayList, link)){
        var song = {
            title: title,
            artist: artist,
            mp3: link,
            isFirstPlaying : true
        }
        mainPlayList.add(song);
        $('#plused_'+ index).removeClass("hidden");
        $('#plus_'+ index).hide();
    }
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
            icon : 'http://www.micro-solve.net/images/clients/user.png'
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

function loadSongInfo(link){
    var data = {
      'link' : link
    };
    $.ajax({
        url: 'index.php?route=app/song/infosong',
        type: 'get',
        data: data,
        dataType: 'json',
        success: function(json) {
            $('#noidungBh').replaceWith(json.lyric);
            $('#relatedSong').replaceWith(json.related);
            $('#interestedAlbum').replaceWith(json.relatedAlbums);
            $('#container').css('height', $('#mainHeight').height() + 150);
            bindRightClickAction();
        }
    });
}

function gotoSongV2(link, index, prefix){
    // make playlist empty
    secondPlaylist.pause();
    secondPlaylist.playlist.splice(0, secondPlaylist.playlist.length);

    var title= $('#title_'+ prefix + index).html();
    var artis = $('#artis_'+ prefix + index).html();
    var imgsrc = $('#imgSrc_'+ prefix + index).val();
    $('#noidungBh').replaceWith('<p class="my-indicator" id="noidungBh"><i class="fa fa-circle-o-notch fa-spin fa-4x"></i></p>');
    $('#interestedAlbum').replaceWith('<div style="margin-left: 3%" id="interestedAlbum"></div>');
    var data = {
        'link' : link,
        'title' :  title,
        'img_src' : window.btoa(imgsrc),
        'artist' : artis
    };
    $.ajax({
        url: 'index.php?route=app/song/getsongv2',
        type: 'post',
        data: data,
        dataType: 'json',
        success: function(json) {
            isHasLoad = false;
            var prepairHtmlUlElement = '<li class="list-group-item active" id="firstSongLi"></li>';
            prepairHtmlUlElement+= '<li><p class="my-indicator" id="noidungBh"><i class="fa fa-circle-o-notch fa-spin fa-4x"></i></p></li>';
            prepairHtmlUlElement+= '<li><div style="margin-left: 3%" id="interestedAlbum"></div></li>';
            prepairHtmlUlElement+= '<li id="liFacebookComment"></li>';
            $('#ulListSongParent').html(prepairHtmlUlElement);

            $('#firstSongLi').replaceWith(json.tileSong);
            $('#mainImg').replaceWith(json.tileImg);
            $('#noidungBh').replaceWith(json.lyric);
            $('#interestedAlbum').replaceWith(json.relatedAlbums);
            window.location.hash = "#song/" + foldToAssci(title+artis) + "_" + json.keyword;
            var html = '<div class="fb-comments" data-width="400" data-href="'+ json.currentLink + '" data-numposts="10" data-colorscheme="light"></div>';
            $('#liFacebookComment').html(html);
            FB.XFBML.parse();
        }
    });
}

// ------------- Do Action Right Click -------------------------------
function bindRightClickAction(){
    $('.mysong').on('contextmenu', function(e){
        e.preventDefault();
        window.currentLi = $(this);
        $("#custom-menu").finish().toggle(100).
            css({ top: e.pageY + "px",
                left: e.pageX + "px"
            });
    });
    $(document).bind("mousedown", function (e) {
        if (!$(e.target).parents("#custom-menu").length > 0 && !$(e.target).parents("#left-custom-menu").length > 0) {
            $("#custom-menu").hide(100);
            $("#left-custom-menu").hide(100);
        }else if(!$(e.target).parents("#custom-menu").length > 0){
            $("#custom-menu").hide(100);
        }else if(!$(e.target).parents("#left-custom-menu").length > 0){
            $("#left-custom-menu").hide(100);
        }
    });
    bindClickOnContextMenu();
}

function bindRightClickLeftColumn(){
    $('.col-left-context').on('contextmenu', function(e){
        e.preventDefault();
        $("#left-custom-menu").finish().toggle(100).
            css({ top: e.pageY + "px",
                left: e.pageX + "px"
        });
        window.curLeftMenuData = {
            video_channel_id : $(this).attr('data-channel')
        };
    });
    $(document).bind("mousedown", function (e) {
        if (!$(e.target).parents("#custom-menu").length > 0 && !$(e.target).parents("#left-custom-menu").length > 0) {
            $("#custom-menu").hide(100);
            $("#left-custom-menu").hide(100);
        }else if(!$(e.target).parents("#custom-menu").length > 0){
            $("#custom-menu").hide(100);
        }else if(!$(e.target).parents("#left-custom-menu").length > 0){
            $("#left-custom-menu").hide(100);
        }
    });
}

function bindClickOnContextMenu(){
    $("#custom-menu li").click(function(e){
        switch($(this).attr("data-action")) {
            case "1": handleOpenWindow(1, window.currentLi); break;
            case "2": handleOpenWindow(2, window.currentLi); break;
            case "3": handleOpenWindow(3, window.currentLi); break;
            case "subMenu_" : handleOpenWindow($(this).attr("data-action-val"), window.currentLi); break;
        }
        $("#custom-menu").hide(100);
    });
}

function handleOpenWindow(action, divLi){
    if(divLi != undefined && divLi != null){
        var index = $(divLi).attr("data-index");
        var srcSong = $('#song'+ index).val();
        var title = $('#title_'+index).html();
        var artis = $('#artis_'+index).html();
        var imgSrc = $('#imgSrc_'+index).val();
        if(action == 1){ // open in new tab
            mainPlayList.pause();
            secondPlaylist.pause();
            setTimeout(function(){
                resumePlaying();
            }, 100);

            var data = {
                'link' : srcSong,
                'title' :  title,
                'img_src' : window.btoa(imgSrc),
                'artist' : artis
            };
            $.ajax({
                url: 'index.php?route=app/song/gotosong',
                type: 'post',
                data: data,
                dataType: 'json',
                success: function(json) {
                    var finalUrl = json.rootUrl + "#song/" + foldToAssci(json.title + json.artis) + "_" + json.keyword;
                    window.open(finalUrl, '_blank');
                }
            });
        }else if(action == 2){ // open in new window
            mainPlayList.pause();
            secondPlaylist.pause();
            setTimeout(function(){
                resumePlaying();
            }, 100);

            var data2 = {
                'link' : srcSong,
                'title' :  title,
                'img_src' : window.btoa(imgSrc),
                'artist' : artis
            };
            $.ajax({
                url: 'index.php?route=app/song/gotosong',
                type: 'post',
                data: data2,
                dataType: 'json',
                success: function(json) {
                    var strWindowFeatures = "height=" + window.height + ",width= " + window.width;
                    var finalUrl = json.rootUrl + "#song/" + foldToAssci(json.title + json.artis) + "_" + json.keyword;
                    window.open(finalUrl, title, strWindowFeatures);
                }
            });
        }else if(action == 3){
            mainPlayList.pause();
            secondPlaylist.pause();
            setTimeout(function(){
                resumePlaying();
            }, 100);
            var data3 = {
                'link' : srcSong,
                'title' :  title,
                'img_src' : window.btoa(imgSrc),
                'artist' : artis
            };
            $.ajax({
                url: 'index.php?route=app/song/fetchsong',
                type: 'post',
                data: data3,
                dataType: 'json',
                success: function(json) {
                    if(json.linkSong != undefined && json.linkSong != ''){
                        plusSong('index.php?route=app/search/playsong&src='+ json.linkSong, title, artis, '-1');
                    }
                }
            });
        }else if(action.indexOf('subMenu_') >= 0){
            var playlist_id = parseInt(action.substring(action.indexOf('_')+1), 10);
            var dataPlaylist = {
                'playlist_id': playlist_id,
                'song_title': title,
                'link' : srcSong,
                'title' :  title,
                'img_src' : window.btoa(imgSrc),
                'artist' : artis
            };
            $.ajax({
                url: 'index.php?route=app/playlist/insert_song_playlist',
                type: 'post',
                data: dataPlaylist,
                dataType: 'json',
                success: function(json) {
                    if(json.status == "OK"){
                        var currentNumb = $('#numb'+ playlist_id).html().trim();
                        $('#numb'+playlist_id).html(parseInt(currentNumb) + 1);
                    }
                }
            });
        }
    }
}
// -------------- End Handle Right Click Action -----------

function resumePlaying(){
    if(isMainPlaying){
        mainPlayList.play();
        isMainPlaying = false;
    }else if(isSecondPlaying){
        secondPlaylist.play();
        isSecondPlaying = false;
    }
}

function favorite(){
    CookieHandler.setCookie("favorite");
}
function addToFavoriteSingle(div){
    var keyword = $('#keyword').val();
    $.getJSON('index.php?route=app/song/addfavorite&keyword=' + keyword, function(data){
        $(div).find('i').addClass('fa-heart');
        $(div).find('i').removeClass('fa-heart-o');
    });
}

function openConfirmModal(object_id, body, callBack, index){
    var defaulBody = (body != undefined && body !=null && body.length > 0) ? body: '<h4>Are you sure to remove this song from favorite collection?</h4>';
    var defaultCallBack = (callBack!=undefined && callBack!=null)? callBack: removeFavoriteSong;
    $('#confirmBody').html(defaulBody);
    $('#confirmModalOKbutton').bind('click',function(){
        defaultCallBack(object_id, index);
    });
    $('#confirmModal').modal('show');
}

function removeFavoriteSong(song_favorite_id, index){
    $.getJSON('index.php?route=app/favorite/remove&fs_id=' + song_favorite_id, function(data){
        if(data != 'OK'){
            alert(data);
        }else if(data == 'OK'){
            $('#' + song_favorite_id).remove();
        }
        $('#confirmModal').modal('hide');
    });
}

function bindSecondPlaylist(songs){
    mainPlayList.pause();
    secondPlaylist.pause();
    secondPlaylist.playlist = [];
    for(var i = 0 ; i< songs.length ; i++){
        var song = {
            title: songs[i].title,
            artist: songs[i].artist,
            mp3: "index.php?route=app/search/playsong&src=" + songs[i].linkSong
        };
        secondPlaylist.add(song);
    }
    //secondPlaylist.play(0);
}

function updateHeight(){
    var height1 = $('#columnHeight1').height();
    var mainHeight = $('#mainHeight').height();
    if(height1 > mainHeight){
        $('#container').height(height1 + 150);
    }else{
        $('#container').height(mainHeight + 150);
    }
}

function updateLyricsCollapse(){
    $('.lyricCollapse').bind('hidden.bs.collapse', function () {
        updateHeight();
    });
    $('.lyricCollapse').bind('shown.bs.collapse', function () {
        updateHeight();
    });
}

function gotoPlaylist(index, name){
    $('#LoadingDiv').show();
    $('#main-content').css('opacity', '0.6');
    var data = {
        pl_id: $('#playlist_'+index).val()
    };
    $.ajax({
        url: 'index.php?route=app/playlist',
        type: 'get',
        data: data,
        dataType: 'html',
        success: function(html) {
            $('#searchIndicator').hide();
            $('#content').html(html);
            isHasLoad = false;
            window.location.hash = "#playlist/" + foldToAssci(name) + "-" + window.btoa(data.pl_id);
        }
    });
}

function gotoPlaylistByID(id, name){
    $('#LoadingDiv').show();
    $('#main-content').css('opacity', '0.6');
    var data = {
        pl_id: id
    };
    $.ajax({
        url: 'index.php?route=app/playlist',
        type: 'get',
        data: data,
        dataType: 'html',
        success: function(html) {
            $('#searchIndicator').hide();
            $('#content').html(html);
            isHasLoad = false;
            window.location.hash = "#playlist/" + foldToAssci(name) + "-" + window.btoa(data.pl_id);
        }
    });
}

function createNewPlayList(divA, parentDiv){
    var html = '<a href="javascript:void(0);"><input class="form-control" id="curInput" type="text" style="width: 130px"/>';
        html += '<span style="display: none;"><i class="fa fa-spinner"></i></span></a>';
    $(divA).replaceWith(html);
    $('#curInput').focusout(function(){
        var tmp = $("<div />").append($(divA).clone()).html();
        $(parentDiv).html(tmp);
    });

    $('#curInput').focus();
    $('#curInput').bind('keypress', function(e){
       if(e.keyCode == 13){
           var data = {
               playlist_name : $(this).val()
           };
           $.ajax({
               url: 'index.php?route=app/playlist/insert',
               type: 'post',
               data: data,
               dataType: 'json',
               success: function(json) {
                   if(json.status == "OK"){
                       var tmpHtml = '<a href="javascript:void(0);" style="display: inline-block" onclick="gotoPlaylistByID('+ json.playlist_id +',\''+ json.playlist_name +'\');">';
                       tmpHtml += '<b class="badge pull-left" id="numb'+ json.playlist_id +'">0</b>';
                       tmpHtml += '<span><i class="fa fa-list-ul"></i>'+ json.playlist_name + '</span></a>';
                       tmpHtml += '<a style="display: inline" class="pull-right col-hide" onclick="openConfirmModal(' + json.playlist_id + ', \'<h4>Are you sure to delete this playlist?</h4>\', removePlaylist, '+ json.currentIndex + ');">';
                       tmpHtml += '<span><i class="fa fa-trash pull-right hidden-sm" style="padding:5px"></i></span>';
                       tmpHtml += '</a>';
                       $(parentDiv).html(tmpHtml);
                       $(parentDiv).attr('id', 'liPlaylist'+ json.currentIndex);

                       var html = '<li class="li-menu" id="addNewParentLi">';
                       html += '<a href="javascript:void(0);" onclick="createNewPlayList($(this), $(\'#addNewParentLi\'));">';
                       html += '<span class="pull-right" id="spinnerHidden" style="display: none;"><i class="fa fa-spinner"></i></span>';
                       html += '<span id="spanAddNew"><i class="fa fa-plus-circle"></i> Add new</span>';
                       html += '<input id="inputAddNew" style="display: none;" type="text"/></a></li>';
                       $('#menu').append(html);

                       // update context-menu
                       var liAddHtml = '<li id="liContextMenu'+ json.currentIndex +'" data-action="subMenu_" data-action-val="subMenu_'+ json.playlist_id +'"><a tabindex="-1" href="javascript:;"><i class="fa fa-link"></i>'+ json.playlist_name +'</a></li>';
                       $('#userPlaylist-subMenu').append(liAddHtml);
                       bindClickOnContextMenu();
                   }
               }
           });
       }
    });
}

function removePlaylist(playlist_id, index){
    var data = {
        'playlist_id' : playlist_id
    };
    $.ajax({
        url: 'index.php?route=app/playlist/delete',
        type: 'post',
        data: data,
        dataType: 'json',
        success: function(json) {
            if(json.status == "OK"){
                $('#liPlaylist' + index).remove();
                $('#liContextMenu'+index).remove();
                $('#confirmModal').modal('hide');
            }
        }
    });
}

function bindSearchVideo(){
    $('#searchVideoBtn').bind('click', function(){
        var q = $('#searchVideoInput').val();
        $.get("https://www.googleapis.com/youtube/v3/search",{
                q: q,
                part: 'snippet',
                key : 'AIzaSyDiAj-zEn_yqElnlvpwlGIanJGVZ5lhJII'
            }, function(response){
                window.currentListVideoSearch = (response != undefined)? response.items : '';
                $('#ulSearchResult').html('');
                for(var i= 0; i < response.items.length; i++){
                    var html = '<li class="list-group-item active">';
                    html += '<div class="row">' ;
                    html += '<div class="col-sm-4">';
                    html += '<img class="img-full" src="'+ response.items[i].snippet.thumbnails.default.url +'" />';
                    html += '</div>';
                    html += '<div class="col-sm-8">';
                    html += '<div class="yt-lockup-content">';
                    html += '<h3 class="yt-lockup-title">';
                    html += '<a href="javascript:;" onclick="gotoVideoItem(\''+ response.items[i].id.videoId + '\', \'gotoVideoItem\')" class="yt-uix-tile-link yt-ui-ellipsis yt-ui-ellipsis-2 yt-uix-sessionlink  spf-link" data-sessionlink="itct=CBgQ3DAYACITCKKH656FmcYCFQeGWAod6RwA9ij0JFIMc29uIHR1bmcgbXRw" title="'+ response.items[i].snippet.title +'" rel="spf-prefetch" aria-describedby="description-id-22668" dir="ltr">'+ response.items[i].snippet.title +'</a>';
                    html += '</h3>';
                    html += '<div class="yt-lockup-description yt-ui-ellipsis yt-ui-ellipsis-2" dir="ltr">'+ response.items[i].snippet.description;
                    html += '</div>';
                    html += '</div></div></div></li>';
                    $('#ulSearchResult').append(html);
                }
                $('#rootDivSearchResult').show();
                updateVideoHeight();
            }
        );
    });
}
function updateVideoHeight(){
    $('#container').height($(document).height() + 100);
}

function htmlVideoItem(video, videoStateToGo){
    var html = '<div class="row">' ;
    html += '<div class="col-sm-4">';
    if(videoStateToGo == 'gotoVideoItem'){
        html += '<a href="javascript:;" onclick="gotoVideoItem(\''+ video.id.videoId + '\')">'
        html += '<img class="img-full" src="'+ video.snippet.thumbnails.default.url +'" /></a>';
    }else if(videoStateToGo == 'loadVideoFromList'){
        html += '<a href="javascript:;" onclick="loadVideoFromList(\''+ video.id.videoId + '\')">'
        html += '<img class="img-full" src="'+ video.snippet.thumbnails.default.url +'" /></a>';
    }
    html += '</div>';
    html += '<div class="col-sm-8">';
    html += '<div class="yt-lockup-content">';
    html += '<h3 class="yt-lockup-title">';
    if(videoStateToGo == 'gotoVideoItem'){
        html += '<a href="javascript:;" onclick="gotoVideoItem(\''+ video.id.videoId + '\')" class="yt-uix-tile-link yt-ui-ellipsis yt-ui-ellipsis-2 yt-uix-sessionlink  spf-link" data-sessionlink="itct=CBgQ3DAYACITCKKH656FmcYCFQeGWAod6RwA9ij0JFIMc29uIHR1bmcgbXRw" title="'+ video.snippet.title +'" rel="spf-prefetch" aria-describedby="description-id-22668" dir="ltr">'+ video.snippet.title +'</a>';
    }else if(videoStateToGo == 'loadVideoFromList'){
        html += '<a href="javascript:;" onclick="loadVideoFromList(\''+ video.id.videoId + '\')" class="yt-uix-tile-link yt-ui-ellipsis yt-ui-ellipsis-2 yt-uix-sessionlink  spf-link" data-sessionlink="itct=CBgQ3DAYACITCKKH656FmcYCFQeGWAod6RwA9ij0JFIMc29uIHR1bmcgbXRw" title="'+ video.snippet.title +'" rel="spf-prefetch" aria-describedby="description-id-22668" dir="ltr">'+ video.snippet.title +'</a>';
    }
    html += '</h3>';
    var des = (video.snippet.description.length > 290) ? video.snippet.description.substring(0, 290) : video.snippet.description;
    html += '<div class="yt-lockup-description yt-ui-ellipsis yt-ui-ellipsis-2" dir="ltr">'+ des;
    if(video.snippet.description.length > 290){
        html+= '<a data-toggle="collapse" href="#collapse'+ video.id.videoId +'" aria-expanded="false" aria-controls="collapseExample">Show more</a>';
        html+= '<span class="collapse" id="collapse'+ video.id.videoId +'">'+ video.snippet.description.substring(290, video.snippet.description.length)+'</span>';
    }
    html += '</div>';
    html += '</div></div></div>';
    return html;
}

function gotoVideoItem(videoId){
    var data = {
        videoId : videoId
    };
    $.ajax({
        url: 'index.php?route=app/video/playlist',
        type: 'get',
        data: data,
        dataType: 'html',
        success: function(html) {
            $('#content').html(html);
            var htmlSrcVideo = '<iframe width="100%" height="580px" src="https://www.youtube.com/embed/'+ videoId+ '?autoplay=0&loop=1" frameborder="0" allowfullscreen style="max-width: 800px;"></iframe>';
            $('#videoContainer').html(htmlSrcVideo);

            var listVideoHtml = '';
            if(window.currentListVideoSearch == undefined || window.currentListVideoSearch.length == 0){
                for(var i=0; i < window.currentListVideoSearch.length; i++){
                    var videoObjectJson = window.currentListVideoSearch[i];
                    listVideoHtml += htmlVideoItem(videoObjectJson, 'loadVideoFromList');
                }
            }
            $('#videoListContainer').html(listVideoHtml);
            isHasLoad = false;
            window.location.hash = "#video/" + videoId;
            updateVideoHeight();
        }
    });
}
function loadVideoFromList(videoId){
    window.location.hash = "#video/" + videoId;
}

function loadRelatedVideoById(videoId){
    $.get("https://www.googleapis.com/youtube/v3/search",{
            part: 'snippet',
            relatedToVideoId : videoId,
            type : 'video',
            maxResults : 7,
            videoType: 'any',
            key : 'AIzaSyDiAj-zEn_yqElnlvpwlGIanJGVZ5lhJII'
        }, function(response){
            var listVideoHtml = '';
            for(var i=0; i < response.items.length; i++){
                var videoObjectJson = response.items[i];
                listVideoHtml += htmlVideoItem(videoObjectJson, 'loadVideoFromList');
            }
            $('#videoListContainer').html(listVideoHtml);
            updateVideoHeight();
        }
    );
}

function loadDetailVideo(videoId){
    $.get("https://www.googleapis.com/youtube/v3/videos",{
            part: 'snippet',
            id : videoId,
            key : 'AIzaSyDiAj-zEn_yqElnlvpwlGIanJGVZ5lhJII'
        }, function(response){
            if(response != null && response.items.length == 1){
                var videoObjectJson = response.items[0];
                $('#videoTitle').html(videoObjectJson.snippet.title);
            }
        }
    );

}

function openChannelDialog(){
    $('#channelDialog').modal('show');
}

function addCustomChannel(){
    var channelInput = $('#channelInput').val().trim();
    var data = {
        channel_name: channelInput
    };
    $.ajax({
        url: 'index.php?route=app/video_channel/insert',
        type: 'post',
        data: data,
        dataType: 'json',
        success: function(json) {
            if(json.status == "OK"){
                var html = '<li id="liChannel'+ json.channelId +'">';
                html += '<a href="#search/video/'+ channelInput +'" class="col-left-context" data-channel="'+ json.channelId +'">';
                html += '<img style="width:35px;" class="img-circle" src="'+ json.imageLink +'" />' + channelInput;
                html += '</a></li>';
                html += '<li id="customChannelAddLi" style="display: none"></li>'
                $('#customChannelAddLi').replaceWith(html);
                bindRightClickLeftColumn();
            }
        }
    });
}

function openDialogEditChannel(){
    $('#channelDialogAction').modal('show');
}

function editChannelName(){
    var data = {
        video_channel_id : window.curLeftMenuData.video_channel_id,
        channel_name: $('#channelDlActionInput').val().trim()
    };
    $.ajax({
        url: 'index.php?route=app/video_channel/update',
        type: 'post',
        data: data,
        dataType: 'json',
        success: function(json) {
            if(json == "OK"){
                $('#channelDialogAction').modal('hide');
                $('#channelName'+ data.video_channel_id).html(data.channel_name);
            }
        }
    });
}
function openDialogConfirm(){
    $('#confirmBody').html('<h4>Are you sure to delete this channel?</h4>');
    $('#confirmModalOKbutton').bind('click',function(){
        var data = {
          video_channel_id: window.curLeftMenuData.video_channel_id
        };
        $.ajax({
            url: 'index.php?route=app/video_channel/delete',
            type: 'post',
            data: data,
            dataType: 'json',
            success: function(json) {
                if(json == "OK"){
                    $('#confirmModal').modal('hide');
                    $('#liChannel'+ data.video_channel_id).remove();
                }
            }
        });
    });
    $('#confirmModal').modal('show');
}
function gotoAlbum(link, index, suffix){
    var artis = $('#album_artis'+ suffix + index).html();
    var title = $('#album_title'+ suffix + index).html();
    var data = {
        link: link,
        artis : artis,
        title : title
    }
    fetchDATA('album', $('#content'), data);
}
function gotoAlbumGET(albumId){
    fetchDATA('album/get', $('#content'), {albumId : albumId});
}