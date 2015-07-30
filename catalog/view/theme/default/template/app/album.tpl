<div class="page-header">
    <div id="LoadingDiv" style="display:none;"></div>
    <div class="container-fluid" id="main-content">
        <div class="vbox">
            <div class="w-f-md">
                <div class="hbox stretch bg-black dker">
                    <!-- side content -->
                    <aside class="col-sm-5 no-padder" id="sidebar">
                        <div class="vbox animated fadeInUp">
                            <div class="scrollable" style="width: 100%" id="columnHeight1">
                                <div class="m-t-n-xxs item-song pos-rlt">
                                    <div class="top text-right">
                                <span class="musicbar animate bg-success bg-empty inline m-r-lg m-t" style="width:25px;height:30px">
                                    <span class="bar1 a3 lter"></span>
                                    <span class="bar2 a5 lt"></span>
                                    <span class="bar3 a1 bg"></span>
                                    <span class="bar4 a4 dk"></span>
                                    <span class="bar5 a2 dker"></span>
                                </span>
                                    </div>
                                    <div class="bottom gd bg-info wrapper-lg">
                                        <span class="pull-right text-sm" style="margin: 15px; color: #ffffff">101,400 <br>Followers</span>
                                        <span class="h2 font-thin" style="margin: 15px; color: #ffffff"><?= $songs[0]['artis']; ?></span>
                                    </div>
                                    <img style="height: 320px;" id="mainImg" class="img-full" src="data:image/<?php echo 'jpg;base64,' .base64_encode(file_get_contents($songs[0]['img_src']));?>" alt="">
                                    <img style="height: 10%; width: 24%;" class="looseless-img" src="data:image/<?php echo 'jpg;base64,' .base64_encode(file_get_contents(STATIC_PATH. 'image/looseless.jpg'));?>">
                                </div>
                                <ul class="list-group list-group-lg no-radius no-border no-bg m-t-n-xxs m-b-none auto" id="ulListSongParent">
                                    <?php $index = 0; ?>
                                    <?php foreach($songs as $song){ ?>
                                    <li class="list-group-item active">
                                        <div class="pull-right m-l">
                                            <a href="javascript:void(0);" class="m-r-sm" onclick="gotoSong('<?= $song['href']?>', '<?= $index; ?>', 'pl', true)"><i class="fa fa-arrow-right"></i></a>
                                            <a data-toggle="collapse" href="#liCollapse<?=$index;?>" aria-expanded="false" aria-controls="liCollapse<?=$index;?>" class="m-r-sm lyricCollapse"><i class="fa fa-file-text"></i></a>
                                            <a href="javascript:void(0);" class="m-r-sm"><i class="fa fa-repeat"></i></a>
                                            <a data-toggle="dropdown" class="dropdown-toggle bg clear" href="javascript:;">
                                                <i class="fa fa-plus-circle"></i>
                                            </a>
                                            <ul class="dropdown-menu dropdown-menu-right alerts-dropdown">
                                                <li>
                                                    <a href="javascript:void(0);" id="plus_<?=$index;?>" onclick="plusSong('index.php?route=app/search/playsong&src=\'<?php echo $song['linkSong'];?>\'', '<?=$song['title'];?>','<?= $song['artis']; ?>', '<?=$index;?>')" class="plus-song pull-right">
                                                        <i class="fa fa-link"></i>Add song to main player
                                                    </a>
                                                    <a href="javascript:void(0);" id="plused_<?=$index;?>" class="hidden pull-right"><i class="fa fa-check"></i>Add to main player</a>
                                                </li>
                                                <?php foreach($playlists as $playlist){ ?>
                                                <li><a href="javascript:;" onclick="beginAddSongToPlaylist('<?= $playlist['playlist_id'];?>', '0', 'ab')"><i class="fa fa-link"></i><?= $playlist['playlist_name']; ?></a></li>
                                                <?php }?>
                                                <li style="display: none" id="hiddenSongPlaylistLi"></li>
                                            </ul>
                                            <input type="hidden" id="title_ab<?=$index;?>" value="<?= $song['title'];?>" />
                                            <input type="hidden" id="artis_ab<?=$index;?>" value="<?= $song['artis'];?>" />
                                            <input type="hidden" id="image_ab<?=$index;?>" value="data:image/<?php echo 'jpg;base64,' .base64_encode(file_get_contents($song['img_src']));?>" />
                                            <input type="hidden" id="song_ab<?=$index;?>" value="<?= $song['href']; ?>" />
                                        </div>
                                        <a href="javascript:void(0);" class="jp-play-me m-r-sm pull-left active" onclick="playSongFavorite('<?=$index;?>')">
                                            <i class="fa fa-play text play<?=$index;?> playIcon" id="play_icon"></i>
                                            <i class="fa fa-pause text-active hidden pause<?=$index;?> pauseIcon" id="pause_icon"></i>
                                        </a>
                                        <div class="clear text-ellipsis"><span style="color: #666666"><?= $song['title'];?></span>
                                            <span class="text-muted"> -- 04:35</span>
                                        </div>
                                        <input type="hidden" id="title_pl<?=$index;?>" value="<?= $song['title']?>" />
                                        <input type="hidden" id="artis_pl<?=$index;?>" value="<?= $song['artis']?>" />
                                        <input type="hidden" id="songImg<?=$index;?>" value="data:image/<?php echo 'jpg;base64,' .base64_encode(file_get_contents($song['img_src']));?>" />
                                    </li>
                                    <li class="collapse" id="liCollapse<?=$index;?>">
                                        <div style="margin-left: 3%">
                                            <?=$song['lyric']?>
                                        </div>
                                    </li>
                                    <?php $index++;} ?>
                                    <li>
                                        <?= $promotion_albums; ?>
                                    </li>
                                    <li>
                                        <div class="fb-comments" data-width="400" data-href="<?= $currentLink; ?>" data-numposts="10" data-colorscheme="light">
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </aside>
                    <!-- / side content -->
                    <?= $promotion_song; ?>

                    <div class="col-sm-3 no-padder lt">
                        <div class="vbox">
                            <div id="divHeight" class="scrollable hover" style="width: 100%">
                                <div class="m-t-n-xxs">
                                    <div class="item pos-rlt"><a href="#"
                                                                 class="item-overlay active opacity wrapper-md font-xs"> <span
                                                    class="block h3 font-bold text-info">Find</span> <span class="text-muted">Search the music you like</span>
                                    <span class="bottom wrapper-md block">- <i
                                                class="icon-arrow-right i-lg pull-right"></i></span> </a> <a href="#">
                                            <img class="img-full" src="http://flatfull.com/themes/musik/images/m40.jpg" alt="..."> </a></div>
                                    <div class="item pos-rlt"><a href="#"
                                                                 class="item-overlay active opacity wrapper-md font-xs text-right">
                                            <span class="block h3 font-bold text-warning text-u-c">Listen</span> <span
                                                    class="text-muted">Find the peace in your heart</span> <span
                                                    class="bottom wrapper-md block"><i
                                                        class="icon-arrow-right i-lg pull-left"></i> -</span> </a> <a href="#">
                                            <img class="img-full" src="http://flatfull.com/themes/musik/images/m41.jpg" alt="..."> </a></div>
                                    <div class="item pos-rlt"><a href="#"
                                                                 class="item-overlay active opacity wrapper-md font-xs"> <span
                                                    class="block h3 font-bold text-success text-u-c">Share</span> <span
                                                    class="text-muted">Share the good songs with your loves</span> <span
                                                    class="bottom wrapper-md block">- <i
                                                        class="icon-arrow-right i-lg pull-right"></i></span> </a> <a href="#">
                                            <img class="img-full" src="http://flatfull.com/themes/musik/images/m42.jpg" alt="..."> </a></div>
                                    <div class="item pos-rlt"><a href="#"
                                                                 class="item-overlay active opacity wrapper-md font-xs text-right">
                                            <span class="block h3 font-bold text-white text-u-c">2014</span> <span
                                                    class="text-muted">Find, Listen &amp; Share</span> <span
                                                    class="bottom wrapper-md block"><i
                                                        class="icon-arrow-right i-lg pull-left"></i> -</span> </a> <a href="#">
                                            <img class="img-full" src="http://flatfull.com/themes/musik/images/m44.jpg" alt="..."> </a></div>
                                    <div class="item pos-rlt"><a href="#"
                                                                 class="item-overlay active opacity wrapper-md font-xs"> <span
                                                    class="block h3 font-bold text-danger-lter text-u-c">Top10</span> <span
                                                    class="text-muted">Selected songs</span> <span
                                                    class="bottom wrapper-md block">- <i
                                                        class="icon-arrow-right i-lg pull-right"></i></span> </a> <a href="#">
                                            <img class="img-full" src="http://flatfull.com/themes/musik/images/m45.jpg" alt="..."> </a></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<input type="hidden" id="albumQuery" value="<?= $albumId; ?>" />
<script type="text/javascript">
    $('#content').css('padding-top', '9%');
    $('#container').css('height', '927px');
    bindSecondPlaylist(<?php echo json_encode($songs); ?>);
    FB.XFBML.parse();
    updateHeight();
    updateLyricsCollapse();
    bindRightClickAction();
</script>