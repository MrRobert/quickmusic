<div class="page-header">
<div class="container-fluid">
<section id="bjax-target" class="scrollable padder-lg w-f-md">
<a data-toggle="class:fa-spin" class="pull-right text-muted m-t-lg" href="#">
    <i id="refresh" class="icon-refresh i-lg inline"></i>
</a>
<h2 class="font-thin m-b">Songs
                    <span style="width:20px;height:20px" class="musicbar inline m-l-sm">
                        <span class="bar1 a1 bg-primary lter"></span> <span class="bar2 a2 lt"></span>
                        <span class="bar3 a3 bg-success"></span> <span class="bar4 a4 bg-warning dk"></span>
                        <span class="bar5 a5 bg-danger dker"></span>
                    </span>
</h2>
<div class="row row-sm">
    <?php $index = 0; ?>
    <?php foreach($lstResult as $song){ ?>
        <?php if($index + 1 % 2 == 0) { ?>
            <div class="clearfix visible-xs"></div>
        <?php }else{ ?>
            <div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
                <div class="item">
                    <div class="pos-relative">
                        <div class="bottom"><span class="badge m-l-sm m-b-sm" style="background-color: #4cb6cb; color: #eaf6f9">03:20</span></div>
                        <div class="item-overlay opacity r r-2x bg-black">
                            <div class="text-info padder m-t-sm text-sm">
                                <a href="javascript:void(0);"><i class="fa fa-star"></i></a>
                                <a href="javascript:void(0);"><i class="fa fa-star"></i></a>
                                <a href="javascript:void(0);"><i class="fa fa-star"></i></a>
                                <a href="javascript:void(0);"><i class="fa fa-star"></i></a>
                                <a href="javascript:void(0);"><i class="fa fa-star-o text-muted"></i></a>
                            </div>
                            <div class="center text-center m-t-n">
                                <a href="javascript:void(0);" class="play-icon-a"><i class="fa fa-play fa-2x"></i></a>
                            </div>
                            <div class="bottom padder m-b-sm">
                                <a class="pull-right" href="#"> <i class="fa fa-heart-o"></i> </a>
                                <a href="javascript:void(0);" class="plus-song"> <i class="fa fa-plus-circle"></i> </a>
                            </div>
                        </div>
                        <a href="javascript:void(0);"><img class="r r-2x img-full" alt="" src="<?php echo $song['img_src'];?>"></a>
                        <input type="hidden" id="song_<?php echo $index;?>" value="<?php echo $index; ?>">
                    </div>
                    <div class="padder-v"><a class="text-ellipsis" href="#"><?php echo $song['title']; ?></a>
                        <a class="text-ellipsis text-xs text-muted" href="#"><?php echo $song['artis']; ?></a>
                    </div>
                </div>
            </div>
        <?php } ?>
    <?php $index++; ?>
    <?php } ?>
</div>
</section>

<!-- SESSION UK -->
<section id="bjax-target" class="scrollable padder-lg w-f-md">
<a data-toggle="class:fa-spin" class="pull-right text-muted m-t-lg" href="#">
    <i id="refresh" class="icon-refresh i-lg inline"></i>
</a>
<h2 class="font-thin m-b">Albums
                    <span style="width:20px;height:20px" class="musicbar inline m-l-sm">
                        <span class="bar1 a1 bg-primary lter"></span> <span class="bar2 a2 lt"></span>
                        <span class="bar3 a3 bg-success"></span> <span class="bar4 a4 bg-warning dk"></span>
                        <span class="bar5 a5 bg-danger dker"></span>
                    </span>
</h2>
    <div class="row row-sm">
        <div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
            <div class="item">
                <div class="pos-relative">
                    <div class="bottom"><span class="badge m-l-sm m-b-sm" style="background-color: #4cb6cb; color: #eaf6f9">03:20</span></div>
                    <div class="item-overlay opacity r r-2x bg-black">
                        <div class="text-info padder m-t-sm text-sm">
                            <a href="javascript:void(0);"><i class="fa fa-star"></i></a>
                            <a href="javascript:void(0);"><i class="fa fa-star"></i></a>
                            <a href="javascript:void(0);"><i class="fa fa-star"></i></a>
                            <a href="javascript:void(0);"><i class="fa fa-star"></i></a>
                            <a href="javascript:void(0);"><i class="fa fa-star-o text-muted"></i></a>
                        </div>
                        <div class="center text-center m-t-n">
                            <a href="javascript:void(0);" class="play-icon-a"><i class="fa fa-play fa-2x"></i></a>
                        </div>
                        <div class="bottom padder m-b-sm">
                            <a class="pull-right" href="#"> <i class="fa fa-heart-o"></i> </a>
                            <a href="javascript:void(0);" class="plus-song"> <i class="fa fa-plus-circle"></i> </a>
                        </div>
                    </div>
                    <a href="javascript:void(0);"><img class="r r-2x img-full" alt="" src="http://music.yeucahat.com/artist/82/Cảm Giác Bên Anh/Hai Bang~www.yeucahat.com~81306.jpg"></a>
                </div>
                <div class="padder-v"><a class="text-ellipsis" href="#">Cảm Giác Bên Anh</a>
                    <a class="text-ellipsis text-xs text-muted" href="#">Hải Băng</a>
                </div>
            </div>
        </div>

        <div class="col-xs-6 col-sm-4 col-md-3 col-lg-2">
            <div class="item">
                <div class="pos-relative">
                    <div class="bottom"><span class="badge m-l-sm m-b-sm" style="background-color: #4cb6cb; color: #eaf6f9">03:20</span></div>
                    <div class="item-overlay opacity r r-2x bg-black">
                        <div class="text-info padder m-t-sm text-sm">
                            <a href="javascript:void(0);"><i class="fa fa-star"></i></a>
                            <a href="javascript:void(0);"><i class="fa fa-star"></i></a>
                            <a href="javascript:void(0);"><i class="fa fa-star"></i></a>
                            <a href="javascript:void(0);"><i class="fa fa-star"></i></a>
                            <a href="javascript:void(0);"><i class="fa fa-star-o text-muted"></i></a>
                        </div>
                        <div class="center text-center m-t-n">
                            <a href="javascript:void(0);" class="play-icon-a"><i class="fa fa-play fa-2x"></i></a>
                        </div>
                        <div class="bottom padder m-b-sm">
                            <a class="pull-right" href="#"> <i class="fa fa-heart-o"></i> </a>
                            <a href="javascript:void(0);" class="plus-song"> <i class="fa fa-plus-circle"></i> </a>
                        </div>
                    </div>
                    <a href="javascript:void(0);"><img class="r r-2x img-full" alt="" src="http://music.yeucahat.com/artist/82/Cảm Giác Bên Anh/Hai Bang~www.yeucahat.com~81306.jpg"></a>
                </div>
                <div class="padder-v"><a class="text-ellipsis" href="#">Điều Em Hối Tiếc</a>
                    <a class="text-ellipsis text-xs text-muted" href="#">Hải Băng</a>
                </div>
            </div>
        </div>
        <div class="clearfix visible-xs"></div>
    </div>
</section>
</div>
</div>
<div class="container-fluid text-center">
</div>