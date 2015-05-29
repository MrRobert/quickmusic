<div id="content" style="padding-top: 60px;" class="album-content">
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
                                <img style="height: 320px;" class="img-full" src="data:image/<?php echo 'jpg;base64,' .base64_encode(file_get_contents($img_src));?>" alt="">
                                <img style="height: 10%; width: 24%;" class="looseless-img" src="data:image/<?php echo 'jpg;base64,' .base64_encode(file_get_contents(STATIC_PATH. 'image/looseless.jpg'));?>">
                            </div>
                            <ul class="list-group list-group-lg no-radius no-border no-bg m-t-n-xxs m-b-none auto">
                                <li class="list-group-item active">
                                    <div class="pull-right m-l">
                                        <a href="#" class="m-r-sm"><i class="fa fa-repeat"></i></a>
                                        <a href="#" class="m-r-sm"><i class="fa fa-heart-o"></i></i></a>
                                        <a href="#" class="m-r-sm"><i class="fa fa-plus-circle"></i></a>
                                    </div>
                                    <a href="javascript:void(0);" class="jp-play-me m-r-sm pull-left active" onclick="playSong('<?php echo $link;?>', $(this))">
                                        <i class="fa fa-play text" id="play_icon"></i>
                                        <i class="fa fa-pause text-active hidden" id="pause_icon"></i>
                                    </a>
                                    <div class="clear text-ellipsis"><span><?= $title;?></span>
                                        <span class="text-muted"> -- 04:35</span>
                                    </div>
                                </li>
                                <li>
                                    <span>DIV noi dung bai hat</span>
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
                <div class="col-sm-4 no-padder bg">
                    <div class="vbox">
                        <div class="scrollable hover" style="width: 100%">
                            <ul class="list-group list-group-lg no-bg auto m-b-none m-t-n-xxs">
                                <li class="list-group-item clearfix">
                                    <a href="#" class="jp-play-me pull-right m-t-sm m-l text-md">
                                        <i class="icon-control-play text"></i>
                                        <i class="icon-control-pause text-active"></i>
                                    </a>
                                    <a href="#" class="pull-left thumb-sm m-r"><img src="images/m0.jpg" alt="..."> </a>
                                    <a class="clear" href="#">
                                        <span class="block text-ellipsis">Little Town</span>
                                        <small class="text-muted">by Soph Ashe</small>
                                    </a>
                                </li>
                                <li class="list-group-item clearfix">
                                    <a href="#" class="jp-play-me pull-right m-t-sm m-l text-md">
                                        <i class="icon-control-play text"></i>
                                        <i class="icon-control-pause text-active"></i>
                                    </a>
                                    <a href="#" class="pull-left thumb-sm m-r"><img src="images/a1.png" alt="..."> </a>
                                    <a class="clear" href="#">
                                        <span class="block text-ellipsis">Get lacinia odio sem nec elit</span>
                                        <small class="text-muted">by Filex</small>
                                    </a>
                                </li>
                                <li class="list-group-item clearfix">
                                    <a href="#" class="jp-play-me pull-right m-t-sm m-l text-md">
                                        <i class="icon-control-play text"></i>
                                        <i class="icon-control-pause text-active"></i>
                                    </a>
                                    <a href="#" class="pull-left thumb-sm m-r"><img src="images/a2.png" alt="..."> </a>
                                    <a class="clear" href="#">
                                        <span class="block text-ellipsis">Donec sed odio du</span>
                                        <small class="text-muted">by Dan Doorack</small>
                                    </a>
                                </li>
                                <li class="list-group-item clearfix">
                                    <a href="#" class="jp-play-me pull-right m-t-sm m-l text-md">
                                        <i class="icon-control-play text"></i>
                                        <i class="icon-control-pause text-active"></i>
                                    </a>
                                    <a href="#" class="pull-left thumb-sm m-r"><img src="images/a3.png" alt="..."> </a>
                                    <a class="clear" href="#">
                                        <span class="block text-ellipsis">Curabitur blandit tempu</span>
                                        <small class="text-muted">by Foxes</small>
                                    </a></li>
                                <li class="list-group-item clearfix"><a href="#" class="jp-play-me pull-right m-t-sm m-l text-md">
                                        <i class="icon-control-play text"></i>
                                        <i class="icon-control-pause text-active"></i>
                                    </a>
                                    <a href="#" class="pull-left thumb-sm m-r"><img src="images/a4.png" alt="..."> </a>
                                    <a class="clear" href="#">
                                        <span class="block text-ellipsis">Urna mollis ornare vel eu leo</span>
                                        <small class="text-muted">by Chris Fox</small>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col-sm-3 no-padder lt">
                    <div class="vbox">
                        <div class="scrollable hover" style="width: 100%">
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
<script type="text/javascript">
    $('#container').css('background-color', '#0d1215');
</script>