$(document).ready(function(){
    $('.playlist-menu').removeClass('active open');

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
    $('#jp_second').bind($.jPlayer.event.ended, function(event) {
        isSecondPlaying = false;
        var index = secondPlaylist.current;
        if(index == secondPlaylist.playlist.length - 1){
            $('.playIcon').show();
            $('.pauseIcon').addClass('hidden');
        }
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
        data.search_name = temp[2];
        hash = temp[0];
        if(hash == 'search'){
            $("#header input[name='search_name']").val(temp[2].split('+').join(' ').toString());
            $("#header input[name='search_name']").focus();
            $('#searchIndicator').show();
        }
    }
    if (hash.length > 0){
        if(hash == 'music' || hash == 'video' || hash == 'search' || hash == 'favorite'){
            fetchDATA(hash, $('#content'), data);
        }else if (hash == 'song'){
            if(isHasLoad){
                var keyword = temp[1].substring(temp[1].lastIndexOf('_')+1);
                gotoSongGET(keyword);
            }
        }else if(hash == 'playlist'){
            if(isHasLoad){
                var arrPath = temp[1].split('-');
                if(arrPath.length > 1){
                    data.pl_id = arrPath[1];
                    fetchDATA(hash, $('#content'), data);
                }
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
    var searchName = $("input[name='search_name']").val().trim();
    window.location.hash = "#search/singer/" + searchName.split(' ').join('+').toString();
    $('#searchIndicator').show();
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

    $('.playIcon').show();
    $('.pauseIcon').addClass('hidden');
    secondPlaylist.pause();
    secondPlaylist.play(index);
    $('.play' + index).hide();
    $('.pause'+ index).removeClass('hidden');
    $('#liCollapse' + index).collapse('show');

    updateHeight();
    $('#jp_second').bind($.jPlayer.event.ended, function(e) {
        var index = parseInt(secondPlaylist.current);
        $('#liCollapse' + index).collapse('hide');
        if(index == secondPlaylist.playlist.length - 1){
            $('.playIcon').show();
            $('.pauseIcon').addClass('hidden');
        }else{
            secondPlaylist.play(index + 1);
        }
        updateHeight();
    });
}

function playSong(link, ePlay){
    $('#second-jplayer').jPlayer("stop");
    bindPlayFunction();
    function bindPlayFunction(){
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

        $(ePlay).find('#play_icon').hide();
        $(ePlay).find('#pause_icon').removeClass('hidden');
        $(ePlay).unbind('click');
        $(ePlay).bind('click', function(){
            pauseSong(link, ePlay);
        });
    }
}

function pauseSong(link, ePlay){
    $(ePlay).find('#play_icon').show();
    $(ePlay).find('#pause_icon').addClass('hidden');
    secondPlaylist.pause();
    $(ePlay).bind('click', function(){
        playSong(link, ePlay);
    });
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
            $('#firstSongLi').replaceWith(json.tileSong);
            $('#mainImg').replaceWith(json.tileImg);
            $('#noidungBh').replaceWith(json.lyric);
            $('#interestedAlbum').replaceWith(json.relatedAlbums);
            window.location.hash = "#song/" + foldToAssci(title+artis) + "_" + json.keyword;
        }
    });
}

function bindRightClickAction(){
    $('.mysong').on('contextmenu', function(e){
        e.preventDefault();
        window.currentLi = $(this);
        $(".custom-menu").finish().toggle(100).
            css({ top: e.pageY + "px",
                left: e.pageX + "px"
            });
    });
    $(document).bind("mousedown", function (e) {
        if (!$(e.target).parents(".custom-menu").length > 0) {
            $(".custom-menu").hide(100);
        }
    });
    $(".custom-menu li").click(function(e){
        switch($(this).attr("data-action")) {
            case "1": handleOpenWindow(1, window.currentLi); break;
            case "2": handleOpenWindow(2, window.currentLi); break;
            case "3": handleOpenWindow(3, window.currentLi); break;
        }
        $(".custom-menu").hide(100);
    });

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
            }
        }
    }
}

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
function openConfirmModal(song_favorite_id){
    $('#confirmModalOKbutton').bind('click',function(){
        removeFavoriteSong(song_favorite_id);
    });
    $('#confirmModal').modal('show');
}

function removeFavoriteSong(song_favorite_id){
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
                       var tmpHtml = '<a href="javascript:void(0);" onclick="gotoPlaylistByID('+ json.playlist_id +','+ json.playlist_name +');">';
                       tmpHtml += '<b class="badge pull-right">0</b>'
                       tmpHtml+= '<span><i class="fa fa-list-ul"></i>'+ json.playlist_name + '</span></a>';
                       $(parentDiv).html(tmpHtml);
                       $(parentDiv).attr('id', '');

                       var html = '<li class="li-menu" id="addNewParentLi">';
                       html += '<a href="javascript:void(0);" onclick="createNewPlayList($(this), $(\'#addNewParentLi\'));">';
                       html += '<span class="pull-right" id="spinnerHidden" style="display: none;"><i class="fa fa-spinner"></i></span>';
                       html += '<span id="spanAddNew"><i class="fa fa-plus-circle"></i> Add new</span>';
                       html += '<input id="inputAddNew" style="display: none;" type="text"/></a></li>';
                       $('#menu').append(html);
                   }
               }
           });
       }
    });
}

function searchVideoSubmit(){
    var search = $('#searchVideo').val().trim();

}