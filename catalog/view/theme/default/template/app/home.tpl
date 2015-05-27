<div id="content">
<div class="page-header">
<div id="LoadingDiv" style="display:none;"></div>
<div class="container-fluid" id="main-content">
<section id="bjax-target" class="scrollable padder-lg w-f-md">
<a data-toggle="class:fa-spin" class="pull-right text-muted m-t-lg" href="#">
    <i id="refresh" class="icon-refresh i-lg inline"></i>
</a>
<h2 class="font-thin m-b">Hot Songs
                    <span style="width:20px;height:20px" class="musicbar inline m-l-sm">
                        <span class="bar1 a1 bg-primary lter"></span> <span class="bar2 a2 lt"></span>
                        <span class="bar3 a3 bg-success"></span> <span class="bar4 a4 bg-warning dk"></span>
                        <span class="bar5 a5 bg-danger dker"></span>
                    </span>
</h2>
<div class="row row-sm">
<?php $index=0; ?>
<?php foreach($hotSongVN as $songVN){ ?>
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
                    <a href="javascript:void(0);">
                        <img class="r r-2x img-full" alt="" src="data:image/<?php echo 'jpg;base64,' .base64_encode(file_get_contents($songVN['img_src']));?>">
                        <img class="looseless-img" src="data:image/<?php echo 'jpg;base64,' .base64_encode(file_get_contents(STATIC_PATH. 'image/looseless.jpg'));?>">
                    </a>
                </div>
                <div class="padder-v"><a class="text-ellipsis" href="#"><?=$songVN['title']?</a>
                    <a class="text-ellipsis text-xs text-muted" href="#"><?=$songVN['artis']?</a>
                </div>
            </div>
        </div>
    <?php }?>
<?php $index ++; }?>
</div>
<div class="row">
    <div class="col-md-7"><h3 class="font-thin">Hot Albums</h3>
        <div class="row row-sm">
            <?php foreach($albumUKs as $albumUK){ ?>
                <div class="col-xs-6 col-sm-3">
                    <div class="item">
                        <div class="pos-relative">
                            <div class="item-overlay opacity r r-2x bg-black">
                                <div class="center text-center m-t-n">
                                    <a href="javascript:void(0);"><i class="fa fa-play-circle fa-2x"></i></a>
                                </div>
                            </div>
                            <a href="javascript:void(0);">
                                <img class="r r-2x img-full" alt="" src="data:image/<?php echo 'jpg;base64,' .base64_encode(file_get_contents($albumUK['img_src']));?>">
                                <img class="looseless-img" src="data:image/<?php echo 'jpg;base64,' .base64_encode(file_get_contents(STATIC_PATH. 'image/looseless.jpg'));?>">
                            </a>
                        </div>
                        <div class="padder-v"><a class="text-ellipsis" href="#"><?=$albumUK['title']?></a>
                            <a class="text-ellipsis text-xs text-muted" href="#"><?=$albumUK['artis']></a>
                        </div>
                    </div>
                </div>
            <?php } ?>
        </div>
    </div>
    <div class="col-md-5"><h3 class="font-thin">Top Songs UK</h3>
        <div class="list-group bg-white list-group-lg no-bg auto">
            <?php foreach($hotSongUK as $songUK){ ?>
                <a class="list-group-item clearfix" href="#">
                    <span class="pull-right h2 text-muted m-l">1</span>
                    <span class="pull-left thumb-sm avatar m-r">
                        <img alt="" class="img-circle" src="data:image/<?php echo 'jpg;base64,' .base64_encode(file_get_contents($songUK['img_src']));?>">
                    </span>
                    <span class="clear"><span><?=$song['title']?></span>
                        <small class="text-muted clear text-ellipsis"><?=$song['artis']?></small>
                    </span>
                </a>
            <?php } ?>
        </div>
    </div>
</div>
</section>
</div>
</div>
<div class="container-fluid text-center">
</div>
</div>