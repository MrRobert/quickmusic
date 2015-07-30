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
            <div class="item-song">
                <div class="pos-relative">
                    <div class="item-overlay opacity r r-2x bg-black">
                        <div class="text-info padder m-t-sm text-sm">
                            <a href="javascript:void(0);"><i class="fa fa-star"></i></a>
                            <a href="javascript:void(0);"><i class="fa fa-star"></i></a>
                            <a href="javascript:void(0);"><i class="fa fa-star"></i></a>
                            <a href="javascript:void(0);"><i class="fa fa-star"></i></a>
                            <a href="javascript:void(0);"><i class="fa fa-star-o text-muted"></i></a>
                        </div>
                        <div class="center text-center m-t-n">
                            <a onclick="gotoSong('<?php echo $songVN['href']?>', '<?= $index; ?>', '');" href="javascript:void(0);" href="javascript:void(0);" class="play-icon-a"><i class="fa fa-play fa-2x"></i></a>
                        </div>
                        <div class="bottom_2 padder m-b-sm">
                            <a href="javascript:void(0);" style="color: #9badb9;" id="plus_<?=$index;?>" onclick="plusSong('index.php?route=app/search/playsong&src=\'<?=$songVN['href']?>\'','<?= $songVN['title']?>', '<?= $songVN['artis']?>', <?= $index ?>)" class="plus-song pull-right"> <i class="fa fa-plus-circle"></i> </a>
                            <a href="javascript:void(0);" style="color: #9badb9;" id="plused_<?=$index;?>" class="hidden pull-right"><i class="fa fa-check"></i></a>
                        </div>
                        <div class="bottom padder m-b-sm">
                            <a class="pull-right" href="#"> <i class="fa fa-heart-o"></i> </a>
                        </div>
                    </div>
                    <a href="javascript:void(0);">
                        <img id="img_<?=$index;?>" class="r r-2x img-full" alt="" src="data:image/<?php echo 'jpg;base64,' .base64_encode(file_get_contents($songVN['img_src']));?>">
                        <img class="looseless-img" src="data:image/<?php echo 'jpg;base64,' .base64_encode(file_get_contents(STATIC_PATH. 'image/looseless.jpg'));?>">
                    </a>
                </div>
                <div class="padder-v"><a class="text-ellipsis" href="#" id="title_<?=$index;?>"><?=$songVN['title']?></a>
                    <a class="text-ellipsis text-xs text-muted" href="#" id="artis_<?=$index;?>"><?=$songVN['artis']?></a>
                </div>
            </div>
        </div>
    <?php }?>
<?php $index ++; }?>
</div>
<div class="row">
    <div class="col-md-7">
        <h3 class="font-thin"><span id="albumTitle">Hot Albums UK</span>
            <a class="pull-right" href="#albumCarousel" role="button" data-slide="next" style="padding-left: 8%; color: #666666"><i class="fa fa-angle-right"></i></a>
            <a class="pull-right" href="#albumCarousel" role="button" data-slide="prev" style="color: #666666"><i class="fa fa-angle-left"></i></a>
        </h3>
        <div id="albumCarousel" class="carousel slide" data-ride="carousel">
            <!-- Wrapper for slides -->
            <div class="carousel-inner" role="listbox">
                <div class="item active">
                    <div class="row row-sm">
                        <?php $index=0;?>
                        <?php foreach($albumUKs as $albumUK){ ?>
                        <div class="col-xs-6 col-sm-3">
                            <div class="item-song">
                                <div class="pos-relative">
                                    <div class="item-overlay opacity r r-2x bg-black">
                                        <div class="center text-center m-t-n">
                                            <a href="javascript:void(0);" onclick="gotoAlbum('<?= $albumUK['href']; ?>', '<?= $index;?>', 'uk');">
                                                <i class="fa fa-play-circle fa-2x"></i>
                                            </a>
                                        </div>
                                    </div>
                                    <a href="javascript:void(0);" onclick="gotoAlbum('<?= $albumUK['href']; ?>', '<?= $index;?>', 'uk');">
                                        <img class="r r-2x img-full" alt="" src="data:image/<?php echo 'jpg;base64,' .base64_encode(file_get_contents($albumUK['img_src']));?>">
                                        <img class="looseless-img" src="data:image/<?php echo 'jpg;base64,' .base64_encode(file_get_contents(STATIC_PATH. 'image/looseless.jpg'));?>">
                                    </a>
                                </div>
                                <div class="padder-v"><a class="text-ellipsis" href="javascript:;" id="album_titleuk<?=$index;?>"><?=$albumUK['title']?></a>
                                    <a class="text-ellipsis text-xs text-muted" href="javascript:;" id="album_artisuk<?=$index;?>"><?=$albumUK['artis']?></a>
                                </div>
                            </div>
                        </div>
                        <?php $index++; } ?>
                    </div>
                </div>
                <div class="item">
                    <div class="row row-sm">
                        <?php $index=0;?>
                        <?php foreach($albumVNs as $albumVN){ ?>
                        <div class="col-xs-6 col-sm-3">
                            <div class="item-song">
                                <div class="pos-relative">
                                    <div class="item-overlay opacity r r-2x bg-black">
                                        <div class="center text-center m-t-n">
                                            <a href="javascript:void(0);" onclick="gotoAlbum('<?= $albumVN['href']; ?>', '<?= $index;?>', 'vn');">
                                                <i class="fa fa-play-circle fa-2x"></i>
                                            </a>
                                        </div>
                                    </div>
                                    <a href="javascript:void(0);" onclick="gotoAlbum('<?= $albumVN['href']; ?>', '<?= $index;?>', 'vn');">
                                        <img class="r r-2x img-full" alt="" src="data:image/<?php echo 'jpg;base64,' .base64_encode(file_get_contents($albumVN['img_src']));?>">
                                        <img class="looseless-img" src="data:image/<?php echo 'jpg;base64,' .base64_encode(file_get_contents(STATIC_PATH. 'image/looseless.jpg'));?>">
                                    </a>
                                </div>
                                <div class="padder-v"><a class="text-ellipsis" href="javascript:;" id="album_titlevn<?=$index;?>"><?=$albumVN['title']?></a>
                                    <a class="text-ellipsis text-xs text-muted" href="javascript:;" id="album_artisvn<?=$index;?>"><?=$albumVN['artis']?></a>
                                </div>
                            </div>
                        </div>
                        <?php $index++;} ?>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-5">
        <h3 class="font-thin">Top Songs UK
            <a class="pull-right" href="#myCarousel" role="button" data-slide="next" style="padding-left: 8%; color: #666666"><i class="fa fa-angle-right"></i></a>
            <a class="pull-right" href="#myCarousel" role="button" data-slide="prev" style="color: #666666"><i class="fa fa-angle-left"></i></a>
        </h3>
        <div id="myCarousel" class="carousel slide" data-ride="carousel">
            <!-- Wrapper for slides -->
            <div class="carousel-inner" role="listbox">
                <div class="item active">
                    <div class="list-group bg-white list-group-lg no-bg auto">
                        <?php $index = 0;?>
                        <?php foreach($hotSongUK as $songUK){ ?>
                        <?php if($index < 7){ ?>
                        <a class="list-group-item clearfix" href="javascript:void(0);" onclick="gotoSong('<?php echo $songUK['href'];?>', '<?= $index; ?>', 'uk')">
                            <span class="pull-right h2 text-muted m-l"><?php echo $index+1;?></span>
                            <span class="pull-left thumb-sm avatar m-r">
                                <img alt="" id="img_uk<?=$index;?>" class="img-circle img-with-small" src="data:image/<?php echo 'jpg;base64,' .base64_encode(file_get_contents($songUK['img_src']));?>">
                            </span>
                            <span class="clear"><span id="title_uk<?=$index; ?>"><?=$songUK['title']?></span>
                                <small class="text-muted clear text-ellipsis" id="artis_uk<?=$index;?>"><?=$songUK['artis']?></small>
                            </span>
                        </a>
                        <?php } ?>
                        <?php $index++; } ?>
                    </div>
                </div>
                <div class="item">
                    <div class="list-group bg-white list-group-lg no-bg auto">
                        <?php $index = 0;?>
                        <?php foreach($hotSongUK as $songUK){ ?>
                        <?php if($index >= 7 && $index < 14){ ?>
                        <a class="list-group-item clearfix" href="javascript:void(0);" onclick="gotoSong('<?php echo $songUK['href'];?>', '<?= $index; ?>', 'uk')">
                            <span class="pull-right h2 text-muted m-l"><?php echo $index+1;?></span>
                            <span class="pull-left thumb-sm avatar m-r">
                                <img alt="" id="img_uk<?=$index;?>" class="img-circle img-with-small" src="data:image/<?php echo 'jpg;base64,' .base64_encode(file_get_contents($songUK['img_src']));?>">
                            </span>
                            <span class="clear"><span id="title_uk<?=$index; ?>"><?=$songUK['title']?></span>
                                <small class="text-muted clear text-ellipsis" id="artis_uk<?=$index;?>"><?=$songUK['artis']?></small>
                            </span>
                        </a>
                        <?php } ?>
                        <?php $index++; } ?>
                    </div>
                </div>
                <div class="item">
                    <div class="list-group bg-white list-group-lg no-bg auto">
                        <?php $index = 0;?>
                        <?php foreach($hotSongUK as $songUK){ ?>
                        <?php if($index >= 14 && $index < 21){ ?>
                        <a class="list-group-item clearfix" href="javascript:void(0);" onclick="gotoSong('<?php echo $songUK['href'];?>', '<?= $index; ?>', 'uk')">
                            <span class="pull-right h2 text-muted m-l"><?php echo $index+1;?></span>
                            <span class="pull-left thumb-sm avatar m-r">
                                <img alt="" id="img_uk<?=$index;?>" class="img-circle img-with-small" src="data:image/<?php echo 'jpg;base64,' .base64_encode(file_get_contents($songUK['img_src']));?>">
                            </span>
                            <span class="clear"><span id="title_uk<?=$index; ?>"><?=$songUK['title']?></span>
                                <small class="text-muted clear text-ellipsis" id="artis_uk<?=$index;?>"><?=$songUK['artis']?></small>
                            </span>
                        </a>
                        <?php } ?>
                        <?php $index++; } ?>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</section>
</div>
</div>
<div class="container-fluid text-center">
</div>
</div>