<div class="vbox">
    <div class="w-f-md">
        <div class="hbox stretch bg-black dker">
            <!-- side content -->
            <aside class="col-sm-5 no-padder" id="sidebar">
                <div class="vbox animated fadeInUp">
                    <div class="scrollable" style="width: 100%">
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
                                <span class="h2 font-thin" style="margin: 15px; color: #ffffff"><?= $artis; ?></span>
                            </div>
                            <img style="height: 320px;" id="mainImg" class="img-full" src="data:image/<?php echo 'jpg;base64,' .base64_encode(file_get_contents($img_src));?>" alt="">
                            <img style="height: 10%; width: 24%;" class="looseless-img" src="data:image/<?php echo 'jpg;base64,' .base64_encode(file_get_contents(STATIC_PATH. 'image/looseless.jpg'));?>">
                        </div>
                        <ul class="list-group list-group-lg no-radius no-border no-bg m-t-n-xxs m-b-none auto">
                            <li class="list-group-item active" id="firstSongLi">
                                <div class="pull-right m-l">
                                    <a href="#" class="m-r-sm"><i class="fa fa-repeat"></i></a>
                                    <a href="#" class="m-r-sm"><i class="fa fa-heart-o"></i></i></a>
                                    <a href="javascript:void(0);" style="color: #9badb9;" id="plus_0" onclick="plusSong('index.php?route=app/search/playsong&src=\'<?php echo $link;?>\'', '<?=$title;?>','<?= $artis; ?>', 0)" class="plus-song pull-right"> <i class="fa fa-plus-circle"></i> </a>
                                    <a href="javascript:void(0);" style="color: #9badb9;" id="plused_0" class="hidden pull-right"><i class="fa fa-check"></i></a>
                                </div>
                                <a href="javascript:void(0);" class="jp-play-me m-r-sm pull-left active" onclick="playSong('<?php echo $link;?>', $(this))">
                                    <i class="fa fa-play text" id="play_icon"></i>
                                    <i class="fa fa-pause text-active hidden" id="pause_icon"></i>
                                </a>
                                <div class="clear text-ellipsis"><span style="color: #666666"><?= $title;?></span>
                                    <span class="text-muted"> -- 04:35</span>
                                </div>
                            </li>
                            <li>
                                <p class="my-indicator" id="noidungBh">
                                    <i class="fa fa-circle-o-notch fa-spin fa-4x"></i>
                                </p>
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
            <div class="col-sm-4 no-padder bg my-indicator" id="relatedSong">
                <div class="vbox">
                    <div style="margin:45%">
                        <i class="fa fa-circle-o-notch fa-spin fa-4x"></i>
                    </div>
                </div>
            </div>
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
<script type="text/javascript">
    $('#content').css('padding-top', '9%');
    $('#container').css('height', '927px');
    loadSongInfo('<?= $orginLink; ?>');
</script>
<input type="hidden" id="keyword" value="<?php echo $key;?>">